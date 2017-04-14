#!/bin/bash

WIDTH="$1"
HEIGHT="$2"
HALF_RES="$3"
OUT="$ANDROID_PRODUCT_OUT/obj/BOOTANIMATION"

if [ "$HEIGHT" -lt "$WIDTH" ]; then
    IMAGEWIDTH="$HEIGHT"
else
    IMAGEWIDTH="$WIDTH"
fi

IMAGESCALEWIDTH="$IMAGEWIDTH"
IMAGESCALEHEIGHT=$(expr $IMAGESCALEWIDTH / 3)

if  [ "$WIDTH" = "1080" ]; then
cp "vendor/sm/bootanimation/1080.zip" "$OUT/bootanimation.zip"
elif  [ "$WIDTH" = "720" ]; then
cp "vendor/sm/bootanimation/720.zip" "$OUT/bootanimation.zip"
else
tar xfp "vendor/sm/bootanimation/bootanimation.tar" -C "$OUT/bootanimation/"
mogrify -resize $RESOLUTION -colors 250 -background white -gravity center -extent $RESOLUTION "$OUT/bootanimation/"*"/"*".png"

# Create desc.txt
echo "$WIDTH $HEIGHT" 60 > "$OUT/bootanimation/desc.txt"
cat "vendor/sm/bootanimation/desc.txt" >> "$OUT/bootanimation/desc.txt"

# Create bootanimation.zip
cd "$OUT/bootanimation"

zip -qr0 "$OUT/bootanimation.zip" .
fi
