#!/bin/bash

if ! [ "$(id -u)" = 0 ]; then
   echo "The script need to be run as root." >&2
   exit 1
fi

basics ()
{
    yay -S brave-bin
}

# Options
# all (default)
# none
# manual
    # output array of options with attatched numbers
    # user inputs space separated numbers for multiselect
    # those apps are installed
development ()
{
    declare -a apps=(
        "code" # text editor
        "cool-retro-term" # terminal emulator
        "github-desktop" # github client
        "direnv" # bash scripting utility
    )

    read -r -p "Do you want to install all development apps, none, or make a custom selection of apps. (1/2/3)" apps_choice
    choice_status="incomplete"

    while [ $choice_status == "incomplete" ]; do
        case "$apps_choice" in
        1) # Install everything.
            for app in "${apps[@]}"; do
                yay -S "$app"
            done
            break
            ;;

        2) # Install nothing.
            break
            ;;

        3) # Install all apps manually selected by the user.
            for i in "${!apps[@]}";
            do 
                printf "%s\t%s\n" "$i" "${apps[$i]}"
            done

            echo
            read -r -p 'Input the numbers for the apps you want space separated: ' -a chosen_apps_indexes

            declare -a chosen_apps
            for app_index in "${chosen_apps_indexes[@]}"
            do
                chosen_apps+=("${apps[$app_index]}")
            done

            for app in "${chosen_apps[@]}"
            do
                yay -S "$app"
            done
            ;;

        *) # Check if users want to quit script or input. TODO: Not done.
            read -r -p "Invalid input. Do you want to quit this script or reinput selection? (0/1)" error_response
            case "$error_response" in
            0)
                : #TODO script clean quit function.
                ;;
            1)
                :
                ;;
            *)
                echo "Seriously you nitwit! I QUIT!"
                exit 1
                ;;
            esac
        esac
    done
}