# Inherit common SM stuff
$(call inherit-product, vendor/sm/config/common.mk)

PRODUCT_SIZE := full

# Include SM audio files
include vendor/sm/config/sm_audio.mk

# Optional SM packages
PRODUCT_PACKAGES += \
    LiveWallpapers \
    LiveWallpapersPicker \
    MagicSmokeWallpapers \
    NoiseField \
    PhaseBeam \
    PhotoTable \
    SoundRecorder \
    PhotoPhase \
    Screencast

# Extra tools in SM
PRODUCT_PACKAGES += \
    7z \
    lib7z \
    bash \
    bzip2 \
    curl \
    powertop \
    unrar \
    unzip \
    vim \
    wget \
    zip

# Themes
PRODUCT_PACKAGES += \
    HexoLibre
