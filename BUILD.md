# GWSH Claude Code — 打包指南

## 环境准备

| 工具 | 用途 | 安装 |
|------|------|------|
| **Bun** 1.2+ | 编译二进制 | `npm install -g bun` |
| **NSIS 3.x** | 构建 Windows 安装器 | `winget install NSIS.NSIS` |
| **rcedit** | 向 exe 注入图标 | `npm install`（已在项目依赖中） |
| **sharp + to-ico** | PNG → ICO 图标转换（保留透明通道） | `npm install sharp to-ico` |

---

## 一键打包

```bash
# 1. 生成透明 ICO 图标
node -e "
const sharp=require('sharp'),fs=require('fs'),toIco=require('to-ico');
sharp('png/logo.png').resize(256,256).ensureAlpha().png().toBuffer()
  .then(b=>toIco(b)).then(b=>fs.writeFileSync('png/logo.ico',b))
"

# 2. 编译 + 注入图标
npx bun run ./scripts/build.ts --dev --feature-set=dev-full --outname=gclaude
cp gclaude-dev.exe dist/gclaude.exe
./node_modules/rcedit/bin/rcedit.exe dist/gclaude.exe --set-icon png/logo.ico

# 3. 构建安装器 (PowerShell)
& "C:\Program Files (x86)\NSIS\makensis.exe" scripts/installer/windows.nsi
```

产物：**`dist/installer/gwsh-code-setup.exe`**（~195 MB，安装秒级完成）

---

## 安装器特性

- 安装后点 "Run gclaude now" 会自动检测终端：
  - Windows 11 → 用 **Windows Terminal** 打开
  - 无 WT → 用 **PowerShell** 打开
- 大文件不压缩，直接拷贝，安装瞬间完成
- 自动配置 PATH、开始菜单快捷方式、控制面板卸载

---

## 产物结构

```
dist/
├── gclaude.exe                  ← 裸二进制（打包中间文件，不分发）
└── installer/
    └── gwsh-code-setup.exe      ← 唯一发布产物
```
