#!/bin/bash

DRY_RUN=0

while getopts ":n" opt; do
    case $opt in
        n)
            DRY_RUN=1
            ;;
        \?)
            echo "Oops! You used a strange button: -$OPTARG" >&2
            echo "Use it like this: ./organizer.sh [-n] /path/to/folder"
            exit 1
            ;;
    esac
done

shift $((OPTIND - 1))

if [ $# -ne 1 ]; then
    echo "please tell me which folder to organize!"
    echo "example: ./organizer.sh -n my_messy_folder"
    exit 1
fi

TARGET_DIR="$1"

if [ ! -d "$TARGET_DIR" ]; then
    echo "Error: That folder does not exist!"
    exit 1
fi

if [ "$DRY_RUN" -eq 1 ]; then
    echo "----------------------------------"
    echo "PRETEND MODE (DRY RUN) IS ON! I WILL NOT MOVE ANY FILES."
    echo "----------------------------------"
fi

echo "starting organisation in: $TARGET_DIR"

for file in "$TARGET_DIR"/*; do
    if [ -d "$file" ]; then
        continue
    fi

    FILENAME=$(basename "$file")
    EXT="${FILENAME##*.}"
    EXT_LOWER=$(echo "$EXT" | tr '[:upper:]' '[:lower:]')

    case "$EXT_LOWER" in
        jpg|jpeg|png|gif|bmp|tiff)
            DEST_FOLDER="Images"
            ;;
        pdf|doc|docx|txt|xls|xlsx|ppt|pptx)
            DEST_FOLDER="Documents"
            ;;
        mp3|wav|flac|aac|m4a|mp4|mov|avi|wmv)
            DEST_FOLDER="Media"
            ;;
        zip|tar|gz|7z|rar)
            DEST_FOLDER="Archives"
            ;;
        *)
            DEST_FOLDER="Others"
            ;;
    esac

    DEST_PATH="$TARGET_DIR/$DEST_FOLDER"

    BASE_NAME="${FILENAME%.*}"
    CURRENT_EXT="${FILENAME##*.}"

    UNIQUE_FILENAME="$FILENAME"
    COUNTER=1

    while [ -f "$DEST_PATH/$UNIQUE_FILENAME" ]; do
        echo " [CONFLICT] File $UNIQUE_FILENAME already exists. Renaming..."

        if [ "$BASE_NAME" = "$CURRENT_EXT" ]; then
            UNIQUE_FILENAME="${BASE_NAME}_${COUNTER}"
        else
            UNIQUE_FILENAME="${BASE_NAME}_${COUNTER}.${CURRENT_EXT}"
        fi

        COUNTER=$((COUNTER + 1))
    done

    if [ "$DRY_RUN" -eq 0 ]; then
        mkdir -p "$DEST_PATH"

        if mv "$file" "$DEST_PATH/$UNIQUE_FILENAME"; then
            echo " [MOVED] $FILENAME -> $DEST_FOLDER/$UNIQUE_FILENAME"
        else
            echo " [ERROR] Failed to move $FILENAME. Check permissions."
        fi

    else
        echo "[DRY RUN] Would move $FILENAME to $DEST_FOLDER/$UNIQUE_FILENAME"
    fi
done
