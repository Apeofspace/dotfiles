# while inotifywait -e close_write ~/.config/waybar; do killall -SIGUSR2 waybar; done
while inotifywait -e close_write ~/.config/hypr/waybar; do killall -SIGUSR2 "waybar -c ~/.config/hypr/waybar/config.jsonc -s ./config/hypr/waybar/style.css"; done
