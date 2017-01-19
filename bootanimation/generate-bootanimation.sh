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

if [ "$HALF_RES" = "true" ]; then
    IMAGEWIDTH=$(expr $IMAGEWIDTH / 2)
fi

IMAGEHEIGHT=$(expr $IMAGEWIDTH / 3)

RESOLUTION=""$IMAGEWIDTH"x"$IMAGEHEIGHT""

for part_cnt in 0 1 2
do
    mkdir -p $ANDROID_PRODUCT_OUT/obj/BOOTANIMATION/bootanimation/part$part_cnt
done
tar xfp "vendor/sm/bootanimation/bootanimation.tar" --to-command="convert - -resize '$RESOLUTION' \"png8:$OUT/bootanimation/\$TAR_FILENAME\""

# Create desc.txt
echo "$IMAGESCALEWIDTH $IMAGESCALEHEIGHT" 30 > "$OUT/bootanimation/desc.txt"
<<<<<<< HEAD
cat "vendor/sm/bootanimation/desc.txt" >> "$OUT/bootanimation/desc.txt"
=======
cat "vendor/cm/bootanimation/desc.txt" >> "$OUT/bootanimation/desc.txt"
>>>>>>> 3c6bdac74bc212b26f723aa8697099fd636451a8

# Create bootanimation.zip
cd "$OUT/bootanimation"

zip -qr0 "$OUT/bootanimation.zip" .
