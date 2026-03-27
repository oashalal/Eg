#!/bin/bash

set -e

echo "=== Обновление системы ==="
sudo apt update

echo "=== Установка KDE Plasma (минимум) ==="
sudo apt install -y kde-standard kde-terminal dbus-x11

echo "=== Установка VNC и Web ==="
sudo apt install -y tigervnc-standalone-server tigervnc-common novnc websockify

echo "=== Установка XFCE fallback (на случай проблем) ==="
sudo apt install -y xfce4 xfce4-goodies

echo "=== Настройка VNC ==="

# Запрос пароля
echo "Введите пароль для VNC:"
vncpasswd

# Создание xstartup
mkdir -p ~/.vnc

cat > ~/.vnc/xstartup << 'EOF'
#!/bin/bash
export XDG_SESSION_TYPE=x11
export DESKTOP_SESSION=plasma
export KDE_SESSION_VERSION=5

xrdb $HOME/.Xresources

# Запуск KDE Plasma
startplasma-x11 &
EOF

chmod +x ~/.vnc/xstartup

echo "=== Запуск VNC сервера ==="
vncserver -kill :1 2>/dev/null || true
vncserver :1

echo "=== Запуск noVNC (web доступ) ==="
# убиваем старый если есть
pkill -f websockify || true

# запуск в фоне
nohup websockify --web=/usr/share/novnc/ 6080 localhost:5901 > /dev/null 2>&1 &

IP=$(hostname -I | awk '{print $1}')

echo ""
echo "======================================"
echo "✅ ГОТОВО!"
echo "Открывай в браузере:"
echo "👉 http://$IP:6080/vnc.html"
echo "======================================"
