# Inherit full common SM stuff
$(call inherit-product, vendor/sm/config/common_full.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME

# Include SM LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/sm/overlay/dictionaries
