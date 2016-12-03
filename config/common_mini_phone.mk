$(call inherit-product, vendor/sm/config/common_mini.mk)

# Required SM packages
PRODUCT_PACKAGES += \
    LatinIME

$(call inherit-product, vendor/sm/config/telephony.mk)
