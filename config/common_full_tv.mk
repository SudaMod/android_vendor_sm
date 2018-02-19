# Inherit full common SM stuff
$(call inherit-product, vendor/sm/config/common_full.mk)

PRODUCT_PACKAGES += TvSettings

DEVICE_PACKAGE_OVERLAYS += vendor/sm/overlay/tv
