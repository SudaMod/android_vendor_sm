# Inherit full common Lineage stuff
$(call inherit-product, vendor/sm/config/common_full.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME

# Include Lineage LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/sm/overlay/dictionaries

$(call inherit-product, vendor/sm/config/telephony.mk)
