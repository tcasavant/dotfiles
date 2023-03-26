BOX_COLOR=0xff282930
ACCENT_COLOR=0xff84aafa

if [[ $SELECTED == true ]]; then
    sketchybar --set $NAME icon.color=$BOX_COLOR \
                        label.color=$BOX_COLOR \
                        background.color=$ACCENT_COLOR \
                        background.border_color=$ACCENT_COLOR
else
    sketchybar --set $NAME icon.color=$ACCENT_COLOR \
                        label.color=$ACCENT_COLOR \
                        background.color=$BOX_COLOR \
                        background.border_color=$BOX_COLOR
fi

if [[ $SENDER == "front_app_switched" ]]; then
    
    SPACES=("plan" "mus" "main" "four" "five" "six" "seven" "eight")

    for i in "${!SPACES[@]}"; do
        sid=$(($i+1))
        arr=()
        icons=""
        
        QUERY=$(yabai -m query --windows --space $sid | jq '.[].app')

        if grep -q "\"" <<< $QUERY; then
            
            while IFS= read -r line; do arr+=("$line"); done <<< "$QUERY"
    
            for i in "${!arr[@]}"
            do
    	        icon=$(echo ${arr[i]} | sed 's/"//g')
  	        icon=$($HOME/.config/sketchybar/plugins/icons.sh $icon)
                icons+="$icon  "
            done

        fi

        sketchybar --set space.$sid label="$icons"

    done

fi
