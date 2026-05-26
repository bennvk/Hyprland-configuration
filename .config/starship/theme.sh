#!/bin/bash

colors_file="$HOME/.cache/wal/colors.json"

C2=$(jq -r '.colors.color2' < "$colors_file")
C3=$(jq -r '.colors.color3' < "$colors_file")
C4=$(jq -r '.colors.color4' < "$colors_file")
C5=$(jq -r '.colors.color5' < "$colors_file")
C6=$(jq -r '.colors.color6' < "$colors_file")
C7=$(jq -r '.colors.color7' < "$colors_file")

cat > "$HOME/.config/starship/starship.toml" <<EOF
format = "  \$username\$directory\$git_status\$python\$line_break\$character"

[username]
style_user = "bold $C4"
style_root = "bold red"
show_always = true

[git_status]
format = '([with ]($style)[\$all_status\$ahead_behind](bold $C3) )'
style = "bold $C3"
ahead = "⇡\${count}"
behind = "⇣\${count}"
diverged = "⇕⇡\${ahead_count}⇣\${behind_count}"
modified = "✎\${count} "
untracked = "?\${count} "
staged = "+\${count} "
deleted = "✕\${count} "
stashed = "󰏗 "
conflicted = "⚠\${count} "

[python]
format = "([with]($style)\${virtualenv})"
style = "bold $C3"

[directory]
style = "bold $C3"
truncate_to_repo = false
truncation_length = 3

[character]
success_symbol = "[  ❯](bold $C7)"
error_symbol = "[  ❯](bold $C7)"
EOF
