# Inherit mini common SM stuff
$(call inherit-product, vendor/sm/config/common_mini.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME
