# Go CLI → HTTP API 封装模式

> 来源: 心理物理检测系统设计（2026-06-24）实战总结

## 适用场景

已有 Go CLI 程序（`fmt.Scanln` 读输入，`fmt.Println` 写输出），需要封装为 REST API 供 Hermes Agent 调用。核心诉求：**算法代码不动，只换入口。**

## 模式：main() 替换法

### 改动前

```go
// main() 里是 CLI 交互循环
func main() {
    engine := NewPsiEngine()
    for {
        fmt.Scanln(&input)
        // 处理...
        fmt.Println(result)
    }
}
```

### 改动后

```go
var sessions = make(map[string]*PsiEngine)
var mu sync.Mutex

func main() {
    http.HandleFunc("/session/start", handleStart)
    http.HandleFunc("/session/response", handleResponse)
    http.ListenAndServe(":8080", nil)
}
```

**只改 main()，其余函数一个字符不动。**

## 关键设计决策

### Session 管理

```go
var sessions = make(map[string]*PsiEngine)
```

用 map 存 session。每个 HTTP 请求通过 session_id 找到对应算法实例。加 `sync.Mutex` 防并发冲突。设 TTL（goroutine 定时清理），防止内存泄漏。

### API 端点精简

2 个端点通常足够：

| 端点 | 说明 |
|------|------|
| `POST /session/start` | 创建会话，返回第一轮数据 |
| `POST /session/{id}/action` | 提交输入，返回下一轮或最终结果 |

不需要 `GET /status`（进度在每次 response 里返回）、`DELETE /session`（设 TTL 自动过期优于手动清理）。

### 健康检查

```go
http.HandleFunc("/health", func(w http.ResponseWriter, r *http.Request) {
    json.NewEncoder(w).Encode(map[string]interface{}{
        "status":   "ok",
        "sessions": len(sessions),
    })
})
```

监控用，一行代码。

## 编译 & 部署

```bash
# 编译（目标架构相同则不需要交叉编译）
go build -o binary_name server.go

# 产物：单文件可执行程序，无外部依赖
scp binary_name user@host:~/
ssh user@host "./binary_name &"
```

Go 编译器产出静态链接二进制，目标机器不需要装 Go。

## 坑点

1. **不要用 `fmt.Scanln` 残留** — 改完 main() 后 `grep Scanln server.go` 确认零残留
2. **session TTL 必须有** — 内存 map 不清理会无限增长
3. **并发安全** — map 不是线程安全的，HTTP server 天然多协程
4. **UUID 依赖** — `import "github.com/google/uuid"` 需要在 `go mod tidy` 后自动拉取

## 与 MCP 的配合

Go HTTP API → MCP Server（Python, 几行 httpx）→ Hermes Agent。MCP 只做翻译，不加业务逻辑。Hermes 做所有对话和状态管理。
