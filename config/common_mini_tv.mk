# Inherit common SM stuff
$(call inherit-product, vendor/sm/config/common_mini.mk)

ifeq ($(TARGET_SCREEN_WIDTH) $(TARGET_SCREEN_HEIGHT),$(space))
    PRODUCT_COPY_FILES += \
        vendor/sm/prebuilt/common/bootanimation/800.zip:system/media/bootanimation.zip
endif
