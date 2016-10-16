# Inherit common SM stuff
$(call inherit-product, vendor/sm/config/common_full.mk)

# Required SM packages
PRODUCT_PACKAGES += \
    LatinIME

# Include SM LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/sm/overlay/dictionaries

<<<<<<< HEAD
# Default notification/alarm sounds
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.notification_sound=Hello.ogg \
    ro.config.alarm_alert=Helium.ogg

=======
>>>>>>> 0432d1c84921af05b0f32540e30fd1d793662322
ifeq ($(TARGET_SCREEN_WIDTH) $(TARGET_SCREEN_HEIGHT),$(space))
    PRODUCT_COPY_FILES += \
        vendor/sm/prebuilt/common/bootanimation/800.zip:system/media/bootanimation.zip
endif
