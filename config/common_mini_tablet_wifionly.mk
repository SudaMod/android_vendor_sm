# Inherit common SM stuff
$(call inherit-product, vendor/sm/config/common.mk)

# Include SM audio files
include vendor/sm/config/sm_audio.mk

# Required SM packages
PRODUCT_PACKAGES += \
    LatinIME

# Default notification/alarm sounds
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.notification_sound=Hello.ogg \
    ro.config.alarm_alert=Helium.ogg

ifeq ($(TARGET_SCREEN_WIDTH) $(TARGET_SCREEN_HEIGHT),$(space))
    PRODUCT_COPY_FILES += \
        vendor/sm/prebuilt/common/bootanimation/800.zip:system/media/bootanimation.zip
endif
