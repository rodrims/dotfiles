#! /bin/bash

BAR_WIDTH=2536
BAR_HEIGHT=24


_clock() {
    local calendar_icon='\ue1cd'
    local clock_icon='\ue016'
    echo -e "$calendar_icon $(date +'%a %-d %b') $clock_icon $(date +'%I:%M')"
}

_volume() {
    local status level
    local sound_icon='\ue05d'
    local mute_icon='\ue04f'

    status=$(amixer -D pulse get Master | awk -F '[][]' '/%/{print $2","$4; exit}')
    level=${status%,*}

    case ${status#*,} in
        'off') echo -e "$mute_icon $level" ;;
        *)     echo -e "$sound_icon $level" ;;
    esac
}

_battery() {
    local status icon level

    status=$(cat /sys/class/power_supply/BAT0/status)
    level="$(cat /sys/class/power_supply/BAT0/capacity)%"


    case $status in
        'Full')
            icon='\ue1ff ' ;;
        *)
            icon="[$status] " ;;
    esac

    echo -e "$icon$level"
}

_desktop() {
    local all current

    all=$(bspc query -D --names | sed -n '1!p' | tr '\n' ' ')
    all=($all)
    current=$(bspc query -D -d --names)

    for i in ${!all[@]}; do
        if [ ${all[i]} == $current ]; then
            all[$i]="%{R}${all[i]}%{R}"
        fi
    done

    echo "${all[@]}"
}

_layout() {
    local screen_icon='\ue09f'
    echo -e "$screen_icon $(bspc query -T -d | jq -r .layout)"
}

_xoffset() {
    local status width

    status=$(xrandr | awk -F , '/^Screen/{print $2}')
    width=$(echo $status | awk '{print $2}')

    echo $(( (width / 2) - (BAR_WIDTH / 2) ))
}

_output() {
    local left center right
    while :; do
        left="%{l} $(_battery) $(_volume) $(_layout) "
        center="%{c} $(_desktop) "
        right="%{r} $(_clock) "
        echo "$left$center$right"
        sleep 0.25
    done
}

_dimensions=${BAR_WIDTH}x${BAR_HEIGHT}+$(_xoffset)+12

_font=terminus-14

_font_icons='-wuncon-siji-medium-r-normal--10-100-75-75-c-80-iso10646-1'

_fg_color=\#839496

_bg_color=\#002b36



_output | lemonbar -g ${_dimensions} -f ${_font} -f ${_font_icons} -F ${_fg_color} -B ${_bg_color}
