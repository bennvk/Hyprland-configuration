#!/bin/bash

colors_file="$HOME/.cache/wal/colors.json"
output_file="$HOME/.config/starship.toml"

C2=$(jq -r '.colors.color2' < "$colors_file")
C3=$(jq -r '.colors.color3' < "$colors_file")
C4=$(jq -r '.colors.color4' < "$colors_file")
C5=$(jq -r '.colors.color5' < "$colors_file")
C6=$(jq -r '.colors.color6' < "$colors_file")
C7=$(jq -r '.colors.color7' < "$colors_file")

cat > "$output_file" <<EOF
format = "  \$username\$directory\$line_break\$character"

[username]
style_user = "bold $C4"
style_root = "bold red"
show_always = true

[directory]
style = "bold $C3"
truncate_to_repo = false
truncation_length = 3

[character]
success_symbol = "[  ❯](bold $C7)"
error_symbol = "[  ❯](bold red)"
EOF
