# Inherit common SM stuff
$(call inherit-product, vendor/sm/config/common.mk)

PRODUCT_SIZE := full

# Recorder
PRODUCT_PACKAGES += \
    Recorder
