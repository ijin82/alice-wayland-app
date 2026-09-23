#!/usr/bin/env bash

set -e

DESKTOP_FILE="alice-app.desktop"
ICON_FILE="alice_512.png"
APP_DIR="$HOME/.local/share/applications"
ICON_DIR="$HOME/.local/share/icons/hicolor/512x512/apps"
BIN_DIR="$HOME/.bin"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Создаём папки, если их нет
mkdir -p "$APP_DIR"
mkdir -p "$ICON_DIR"
mkdir -p "$BIN_DIR"

# Делаем скрипт запуска исполняемым
chmod +x "$SCRIPT_DIR/alice-window.sh"
cp "$SCRIPT_DIR/alice-window.sh" "$BIN_DIR/alice-window.sh"

# Копируем .desktop с подстановкой актуального пути к скрипту запуска
sed "s|^Exec=.*|Exec=$BIN_DIR/alice-window.sh|" "$DESKTOP_FILE" > "$APP_DIR/$DESKTOP_FILE"
echo "✓ $DESKTOP_FILE → $APP_DIR/ (с путём $BIN_DIR/alice-window.sh)"

# Копируем иконку
cp "$ICON_FILE" "$ICON_DIR/"
echo "✓ $ICON_FILE → $ICON_DIR/"

# Создаём симлинк с именем Wayland app_id для прямого сопоставления
ln -sf "$ICON_FILE" "$ICON_DIR/chrome-ya.ru__alice-Default.png"
echo "✓ chrome-ya.ru__alice-Default.png → $ICON_DIR/"

# Обновляем кэш иконок (если update-icon-caches есть в системе)
if command -v gtk-update-icon-cache &>/dev/null; then
  gtk-update-icon-cache "$HOME/.local/share/icons/hicolor" &>/dev/null || true
fi

# Обновляем кэш .desktop (если update-desktop-database есть)
if command -v update-desktop-database &>/dev/null; then
  update-desktop-database "$APP_DIR" &>/dev/null || true
fi

echo "Готово. Алиса должна появиться в гриде приложений GNOME."

