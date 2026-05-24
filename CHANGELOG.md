# gwshClaude 更新日志

## v1.1.0 (2026-05-24)

### 品牌 + 图标 + 安装体验

- **全面品牌替换** — 所有源文件（200+）"Claude Code" → "GWSH Claude Code"
  - 系统提示词、版本输出、欢迎页、终端标题、帮助文本、OAuth 引导
- **图标透明度修复** — 手动构建多尺寸 PNG-Icon（256~16px），32bpp Alpha 通道，无白色边框
- **安装秒级完成** — 大二进制不压缩，直接拷贝
- **重复安装自动卸载旧版** — 再次运行安装器自动静默移除旧版本
- **智能终端启动** — Win11 用 Windows Terminal，否则用 PowerShell
- **NSIS 安装详情可见** — 用户能看到安装进度

## v1.0.0 (2026-05-24)

### 首次发布

**软件包：**
- Windows 安装器 (`gwshClaude-setup.exe`)，基于 NSIS 构建
- 安装后全局命令：`gclaude`
- 无需 Bun/Node.js 等运行时依赖，自包含二进制
- 产品名称：**gwsh claude code**
- 自定义图标（源自 `png/logo.png`）

**安装器功能：**
- 图形化安装向导（欢迎页 → 目录选择 → 安装 → 完成），含自定义图标
- 开始菜单快捷方式（带图标）
- 自动检测 Git，未安装时提示下载
- 安装完可直接启动
- 自动配置用户 PATH
- 支持从控制面板卸载（自动清理 PATH + 快捷方式）
- 控制面板显示程序图标

**基于 free-code 源码：**
- 遥测/telemetry 已移除（Sentry、OpenTelemetry、Datadog、1P 日志）
- 安全护栏已剥离（CYBER_RISK_INSTRUCTION 清空）
- 54 个实验性 feature flags 已解锁
- 支持 5 个模型提供商（Anthropic、OpenAI Codex、AWS Bedrock、Google Vertex、Anthropic Foundry）

**待改进：**
- [ ] macOS pkg 安装器
- [ ] 安装时自动下载 Git（静默安装）
- [ ] 多语言支持
