#!/bin/bash

COLORS_JSON="$HOME/.cache/wal/colors.json"

GTK_CSS="$HOME/.config/gtk-3.0/gtk.css"

BG_COLOR=$(jq -r '.colors.background' "$COLORS_JSON")
FG_COLOR=$(jq -r '.colors.foreground' "$COLORS_JSON")
COLOR1=$(jq -r '.colors.color1' "$COLORS_JSON")

BG_COLOR_HEX=$(jq -r '.colors.background' ~/.cache/wal/colors.json)

hex_to_rgba() {
  hex=${1#"#"}
  r=$((16#${hex:0:2}))
  g=$((16#${hex:2:2}))
  b=$((16#${hex:4:2}))
  echo "rgba($r,$g,$b,1.0)"
}

BG_COLOR_RGBA=$(hex_to_rgba "$BG_COLOR_HEX")

cat > "$GTK_CSS" <<EOF
@import url("resource:///org/kde/breeze/gtk/gtk.css");

@define-color bg_color $BG_COLOR_HEX;
@define-color fg_color $(jq -r '.colors.foreground' ~/.cache/wal/colors.json);
@define-color base_color $BG_COLOR_HEX;
@define-color text_color $(jq -r '.colors.foreground' ~/.cache/wal/colors.json);
@define-color selected_bg_color $(jq -r '.colors.color1' ~/.cache/wal/colors.json);
@define-color selected_fg_color $BG_COLOR_HEX;

window, .view, .view:selected, .view:selected:focus {
    background-color: $BG_COLOR_RGBA;
    color: @fg_color;
}

button, entry, textview {
    background-color: $BG_COLOR_RGBA;
    color: @text_color;
}
EOF
