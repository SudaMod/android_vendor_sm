# Inherit common SM stuff
$(call inherit-product, vendor/sm/config/common.mk)

PRODUCT_SIZE := full

# Themes
PRODUCT_PACKAGES += \
    HexoLibre
