#!/bin/bash

if [ $# -ne 1 ]; then
	echo "usage: $0 /path/to/directory"
	echo "   (The target directory to organize)"
	exit 1
fi

TARGET_DIR="$1"

if [ ! -d "$TARGET_DIR" ]; then
	echo "Error: Directory '$TARGET_DIR' does not exist."
        exit 1
fi
echo "starting organisation in: $TARGET_DIR"

for file in "$TARGET_DIR"/*; do
if [ -d "$file" ]; then	
continue
fi

FILENAME=$(basename "$file")
EXT="${FILENAME##*.}"
EXT_LOWER=$(echo "$EXT" | tr '[:upper:]' '[:lower:]')

DEST_FOLDER=""
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
mkdir -p "$DEST_PATH"

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

if mv "$file" "$DEST_PATH/$UNIQUE_FILENAME"; then
echo " [MOVED] $FILENAME -> $DEST_FOLDER/$UNIQUE_FILENAME"
else
echo " [ERROR] Failed to move $FILENAME to $DEST_FOLDER. Check permissions."
fi

done 
echo "2nd task completed :conflict resolution"

