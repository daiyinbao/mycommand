#!/usr/bin/env bash
#----------------------------------------------------------------------------------------------------------------------
#Desc: This script is used for passwordless SSH connection.免密登录
#Usage: ssh-server.sh ip hostname [|port]
#Auther: daiyinbao
#Date: 2026-02-12
#----------------------------------------------------------------------------------------------------------------------

set -e

IP="$1"
USER="$2"
PORT="${3:-22}" # 可选，第 3 个参数是端口，默认 22

if [ -z "$IP" ] || [ -z "$USER" ]; then
  echo "用法: $0 <ip> <username> [port]"
  echo "示例: $0 192.168.122.1 daiyinbao"
  exit 1
fi

KEY_PUB="$HOME/.ssh/id_ed25519.pub"

# 1️⃣ 确保本地有 SSH key
if [ ! -f "$KEY_PUB" ]; then
  echo "🔑 未检测到 SSH key，正在生成..."
  ssh-keygen -t ed25519
fi

# 2️⃣ 测试 22 端口是否可达
echo "🔍 检查 $IP:$PORT 是否可连接..."
if ! timeout 3 bash -c "</dev/tcp/$IP/$PORT" 2>/dev/null; then
  echo "❌ 无法连接到 $IP:$PORT"
  echo "👉 请确认："
  echo "   - 目标机器 SSH 已启动"
  echo "   - 端口号是否正确"
  exit 2
fi

# 3️⃣ 安装公钥
echo "🚀 安装 SSH 公钥到 $USER@$IP ..."
ssh-copy-id -p "$PORT" "$USER@$IP"

# 4️⃣ 测试免密登录
echo "✅ 测试免密登录..."
ssh -p "$PORT" "$USER@$IP" "echo 'SSH key login OK ✔'"

echo "🎉 完成，你现在可以直接："
echo "ssh -p $PORT $USER@$IP"
