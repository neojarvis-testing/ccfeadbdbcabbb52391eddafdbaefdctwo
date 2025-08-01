#!/usr/bin/bash python3

is_file_empty() {
    local file=$1
    [ -s "$file" ]
}
append_to_destination() {
    local source=$1
    local destination=$2
    cat "$source" >> "$destination"
}
erase_and_append() {
    local source=$1
    local destination=$2
    > "$destination" 
    append_to_destination "$source" "$destination"
}

cd /home/coder/project/workspace/Projects

source_file="/home/coder/project/workspace/selenium/eventhandler.py"
destination_file="/home/coder/project/workspace/Projects/utilities/eventhandler.py"



if [ -f "$source_file" ]; then
    if [ -f "$destination_file" ]; then
        if is_file_empty "$destination_file"; then
            append_to_destination "$source_file" "$destination_file"
            appended_content=true
        else
            > "$destination_file"
            append_to_destination "$source_file" "$destination_file"
            appended_content=true
        fi
    else
        append_to_destination "$source_file" "$destination_file"
        appended_content=true
    fi
else
    echo "ERROR: Source file '$source_file' not found."
    exit 1
fi

rm -f "/home/coder/project/log.log"

python3 /home/coder/project/workspace/Projects/base.py

sleep 5
if [ "$appended_content" = true ]; then
    > "$destination_file"  
fi

source_file="../selenium/eventhandlerdummy.py"
if [ -f "$source_file" ]; then
    append_to_destination "$source_file" "$destination_file"
else
    echo "ERROR: Source file '$source_file' not found."
    exit 1
fi

cat /home/coder/project/log.log


