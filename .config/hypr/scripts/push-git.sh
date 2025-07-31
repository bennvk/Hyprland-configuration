#bin/bash

mess=$1

cd ~/Github/Hyprland-configuration
git add .
git commit -m "$mess"
git push
