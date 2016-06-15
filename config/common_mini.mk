# Inherit common SM stuff
$(call inherit-product, vendor/sm/config/common.mk)

PRODUCT_SIZE := mini

# Include SM audio files
include vendor/sm/config/sm_audio.mk

# Default notification/alarm sounds
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.notification_sound=Hello.ogg \
    ro.config.alarm_alert=Helium.ogg

