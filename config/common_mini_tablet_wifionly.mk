# Inherit common SM stuff
$(call inherit-product, vendor/sm/config/common_mini.mk)

# Required SM packages
PRODUCT_PACKAGES += \
    LatinIME
