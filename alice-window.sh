#!/usr/bin/env bash

BROWSER="yandex-browser"
URL="https://ya.ru/alice"
APP_CLASS="chrome-ya.ru__alice-Default"
PROFILE_DIR="$HOME/.config/alice-app"

# Чтобы запускать в полноэкранном режиме, раскомментируйте:
# FS_FLAG="--start-fullscreen"

exec "$BROWSER" \
  --app="$URL" \
  --class="$APP_CLASS" \
  --user-data-dir="$PROFILE_DIR" \
  ${FS_FLAG:+"$FS_FLAG"} \
  "$@"

