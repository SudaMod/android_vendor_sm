# Inherit mini common SudaMod stuff
$(call inherit-product, vendor/sm/config/common_mini.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME

$(call inherit-product, vendor/sm/config/telephony.mk)
