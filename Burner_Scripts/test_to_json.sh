#!/bin/bash

ext_json_file="$HOME/Linux_Setup/data/extenstions.json"
ext_urls_file="$HOME/Linux_Setup/data/test_exts.txt"

new_extension_urls_to_json () {
    readarray -t extension_urls < "$ext_urls_file"

    bound1="<title>"
    bound2=" - Chrome Web Store</title>"

    if [ ! -f "$ext_json_file" ]; then
    touch "$ext_json_file"
    fi

    if [ "$(tail -n 1 "$ext_json_file")" = "]" ]; then
    sed -i "s/]//" "$ext_json_file"
    clean_ext_file=$(sed 's/^ *//; s/ *$//; /^$/d; /^\s*$/d' "$ext_json_file")
    echo "$clean_ext_file" | tee "$ext_json_file" > /dev/null 2>&1
    fi

    first_line=$(head -n 1 "$ext_json_file")
    case "$first_line" in
        "")
            echo '[' | tee "$ext_json_file"
        ;;
        *)
            sed -i "1i [" "$ext_json_file"
        ;;
    esac

    for ext_url in "${extension_urls[@]}"; do
    ext_name=$(curl -L "$ext_url" | grep -oP "(?<=$bound1).*(?=$bound2)")
    ext_id="${ext_url##*/}"

    ext_json_string="$(
      jq --null-input \
        --arg name "${ext_name}" \
        --arg url "${ext_url}" \
        --arg id "${ext_id}" \
        '$ARGS.named'
    ),"

    echo "$ext_json_string"

    sleep 0.5
    echo "$ext_json_string" >> "$ext_json_file"
    done

    tac "$ext_json_file" | sed '2 s/.*/}/' | tac | tee "$ext_json_file" > /dev/null 2>&1 #FIXME This is messing up the file.

    echo
    cat "$ext_json_file"

    last_line=$(tail -n 1 "$ext_json_file")
    sleep 0.5
    if [ ! "$last_line" = "]" ]; then
    echo ']' | tee -a "$ext_json_file" > /dev/null 2>&1
    fi

    #   echo "" > "$ext_urls_file"
}

# if file is not empty
if [ -s "$ext_urls_file" ]; then
  new_extension_urls_to_json
fi

# first_line=$(head -n 1 "$ext_json_file")
# if [ ! "$first_line" = "[" ]; then
#     echo "boo"
#     sed -i "1i [" "$ext_json_file"
# fi