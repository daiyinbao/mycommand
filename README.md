# 一.ports—端口查看工具

Human-friendly port viewer & killer script for Linux

## Usage

```bash
ports             # 查看所有监听端口
ports 8080        # 查看指定端口
ports 80 443      # 多端口
ports 8000-9000   # 端口范围
ports nginx       # 按进程名
ports -t          # tcp
ports -u          # udp
ports -k 8080     # 杀端口
```

# 二.clip — 命令行剪贴板工具 (Wayland / Linux)

`clip` 是一个轻量级命令行工具，用于将标准输入的内容复制到系统剪贴板，并支持 **按行选择、行号显示、自动去首尾空白**。

它主要面向 **Linux / Wayland** 环境（依赖 [`wl-copy`](https://github.com/bugaevc/wl-clipboard)），使用简单、功能实用。

---

## 功能特性

- 支持 **全量复制** 或 **指定行复制**
- 支持 **0-based 行号** 选择
- 支持 **逗号表示“起始行 + 行数”**（例如 `3,5`）
- 自动 **去除首尾空白行**，并 **trim 每行首尾空格**
- 完全兼容管道输入，适合与其他命令组合使用

---

## 安装

1. 确保已安装 `wl-copy`：

```bash
sudo apt install wl-clipboard
```

2.加入环境变量

```bash
mkdir -p ~/.local/bin
cp clip ~/.local/bin/
chmod +x ~/.local/bin/clip
```

3.使用

```bash
clip                   # 复制全部标准输入内容到剪贴板（自动去首尾空白行和行内空格）
clip 10                # 复制前 0~10 行
clip 2 8                # 复制第 2~8 行
clip 3,5                # 从第 3 行开始，复制 5 行
```

