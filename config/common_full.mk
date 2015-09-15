# Inherit common SM stuff
$(call inherit-product, vendor/sm/config/common.mk)

# Include SM audio files
include vendor/sm/config/sm_audio.mk

# Optional SM packages
PRODUCT_PACKAGES += \
    LiveWallpapers \
    LiveWallpapersPicker \
    PhotoTable \
    SoundRecorder \
    PhotoPhase \
    CMSettingsProvider \
    CMResolver

# Extra tools in SM
PRODUCT_PACKAGES += \
    vim \
    zip \
    unrar \
    curl
