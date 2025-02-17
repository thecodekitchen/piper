#!/bin/sh
echo -ne '\033c\033]0;QDR Chat\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/QDR Chat.x86_64" "$@"
