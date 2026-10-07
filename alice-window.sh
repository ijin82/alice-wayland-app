#!/usr/bin/env bash

BROWSER_BIN=$(command -v yandex-browser-stable || command -v yandex-browser)

if [[ -z "$BROWSER_BIN" ]]; then
    echo "Ошибка: Яндекс.Браузер не найден в системе!" >&2
    exit 1
fi


URL="https://ya.ru/alice"
APP_CLASS="chrome-ya.ru__alice-Default"
PROFILE_DIR="$HOME/.config/alice-app"

# Чтобы запускать в полноэкранном режиме, раскомментируйте:
# FS_FLAG="--start-fullscreen"

exec "$BROWSER_BIN" \
  --app="$URL" \
  --class="$APP_CLASS" \
  --user-data-dir="$PROFILE_DIR" \
  ${FS_FLAG:+"$FS_FLAG"} \
  "$@"

