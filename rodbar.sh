#!/bin/bash

_get_screen_width() {
    local width=$(xrandr | awk -F , '/^Screen/{print $2}' | awk '{print $2}')
    echo $width
}


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

    ### battery set 2
    # empty warning 'e211'

    ### battery set 1
    # empty not charging 'e1fd'
    # half not charging 'e1fe'
    # full not charging 'e1ff'
    # plugged in 'e200'
    # charging 'e201'

    case $status in
        'Full')
            icon='\ue200 ' ;;
        'Charging')
            icon='\ue201 ' ;;
        'Discharging')
            icon='\ue1fe ' ;;
        'Unknown')
            icon='\ue211 ' ;;
        *)
            icon="[$status] " ;;
    esac

    echo -e "$icon$level"
}

_application() {
    local app_icon='\ue1ae'
    local app=$(bspc query -T -n | jq -r .client.instanceName | tr '[:upper:]' '[:lower:]')

    echo -e "$app_icon $app"
}

_desktop() {
    local all current nicks

    all=$(bspc query -D --names | tr '\n' ' ')
    all=($all)
    nicks=( ' \ue172 ' ' \ue169 ' ' \ue16a ' ' \ue16b ' ' \ue16c ' ' \ue16d ' ' \ue16e ' ' \ue16f ' ' \ue170 ' ' \ue171 ' )
    current=$(bspc query -D -d --names)

    for i in ${!all[@]}; do
        if [ ${all[i]} == $current ]; then
            nicks[$i]="%{R}${nicks[i]}%{R}"
        fi
    done

    echo -e "${nicks[@]}"
}

_layout() {
    local screen_icon='\ue09f'
    echo -e "$screen_icon $(bspc query -T -d | jq -r .layout)"
}

_xoffset() {
    # local screen_width=$(_get_screen_width)
    # echo $(( (screen_width / 2) - (BAR_WIDTH / 2) ))
    local screen_offset=$(( 1400 + 12 ))
    echo $screen_offset
}

_output() {
    local left center right
    while :; do
        left="%{l} $(_battery) $(_volume) $(_layout) $(_application) "
        center="%{c} $(_desktop) "
        right="%{r} $(_clock) "
        echo "$left$center$right"
        sleep 0.25
    done
}

BAR_HEIGHT=24
# BAR_WIDTH=$(( $(_get_screen_width) - 24 )) 
BAR_WIDTH=$(( 2560 - $BAR_HEIGHT )) 

_dimensions=${BAR_WIDTH}x${BAR_HEIGHT}+$(_xoffset)+12

_font=terminus-14

_font_icons='-wuncon-siji-medium-r-normal--10-100-75-75-c-80-iso10646-1'

_fg_color=\#839496

_bg_color=\#002b36



_output | lemonbar -g ${_dimensions} -f ${_font} -f ${_font_icons} -F ${_fg_color} -B ${_bg_color}
