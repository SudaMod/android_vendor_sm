# Inherit common SM stuff
$(call inherit-product, vendor/sm/config/common_full.mk)

# Default notification/alarm sounds
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.notification_sound=Tethys.ogg \
    ro.config.alarm_alert=Hello.ogg

ifeq ($(TARGET_SCREEN_WIDTH) $(TARGET_SCREEN_HEIGHT),$(space))
    PRODUCT_COPY_FILES += \
        vendor/sm/prebuilt/common/bootanimation/800.zip:system/media/bootanimation.zip
endif
