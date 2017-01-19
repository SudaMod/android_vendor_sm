PRODUCT_BRAND ?= sudamod

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.selinux=1

# Default notification/alarm sounds
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.notification_sound=Argon.ogg \
    ro.config.alarm_alert=Hassium.ogg

ifneq ($(TARGET_BUILD_VARIANT),user)
# Thank you, please drive thru!
PRODUCT_PROPERTY_OVERRIDES += persist.sys.dun.override=0
endif

ifneq ($(TARGET_BUILD_VARIANT),eng)
# Enable ADB authentication
ADDITIONAL_DEFAULT_PROPERTIES += ro.adb.secure=1
endif

# Copy over the changelog to the device
PRODUCT_COPY_FILES += \
    vendor/sm/CHANGELOG.mkdn:system/etc/CHANGELOG-CM.txt

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/sm/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/sm/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/sm/prebuilt/common/bin/50-sm.sh:system/addon.d/50-sm.sh \
    vendor/sm/prebuilt/common/bin/blacklist:system/addon.d/blacklist

# Backup Services whitelist
PRODUCT_COPY_FILES += \
    vendor/sm/config/permissions/backup.xml:system/etc/sysconfig/backup.xml

# Signature compatibility validation
PRODUCT_COPY_FILES += \
    vendor/sm/prebuilt/common/bin/otasigcheck.sh:install/bin/otasigcheck.sh

# init.d support
PRODUCT_COPY_FILES += \
    vendor/sm/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/sm/prebuilt/common/bin/sysinit:system/bin/sysinit

ifneq ($(TARGET_BUILD_VARIANT),user)
# userinit support
PRODUCT_COPY_FILES += \
    vendor/sm/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit
endif

# SM-specific init file
PRODUCT_COPY_FILES += \
    vendor/sm/prebuilt/common/etc/init.local.rc:root/init.sm.rc

# Google PinYin
PRODUCT_COPY_FILES += $(shell test -d vendor/sm/prebuilt/google/app/GooglePinYin && \
    find vendor/sm/prebuilt/google/app/GooglePinYin -name '*.apk' \
    -printf '%p:system/app/GooglePinYin/%f ')
PRODUCT_COPY_FILES += $(shell test -d vendor/sm/prebuilt/google/app/GooglePinYin && \
    find vendor/sm/prebuilt/google/app/GooglePinYin -name '*.so' \
    -printf '%p:system/app/GooglePinYin/lib/arm/%f ')

#ForceStop
PRODUCT_COPY_FILES += \
    vendor/sm/prebuilt/Brevent/Brevent.apk:system/app/Brevent/Brevent.apk

# Copy over added mimetype supported in libcore.net.MimeUtils
PRODUCT_COPY_FILES += \
    vendor/sm/prebuilt/common/lib/content-types.properties:system/lib/content-types.properties

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:system/usr/keylayout/Vendor_045e_Product_0719.kl

# This is SM!
PRODUCT_COPY_FILES += \
    vendor/sm/config/permissions/com.cyanogenmod.android.xml:system/etc/permissions/com.cyanogenmod.android.xml \

# Phonelocation!
PRODUCT_COPY_FILES +=  \
    vendor/sm/prebuilt/common/media/location/suda-phonelocation.dat:system/media/location/suda-phonelocation.dat

# Include SM audio files
include vendor/sm/config/sm_audio.mk

# Theme engine
include vendor/sm/config/themes_common.mk

ifneq ($(TARGET_DISABLE_CMSDK), true)
# CMSDK
include vendor/sm/config/cmsdk_common.mk
endif

# Bootanimation
PRODUCT_PACKAGES += \
    bootanimation.zip

# Required CM packages
PRODUCT_PACKAGES += \
    BluetoothExt \
    CMAudioService \
    CMParts \
    Development \
    Profiles \
    WeatherManagerService

# Optional SM packages
PRODUCT_PACKAGES += \
    libemoji \
    LiveWallpapersPicker \
    PhotoTable \
    Terminal

# Include explicitly to work around GMS issues
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full \
    librsjni

# Custom CM packages
PRODUCT_PACKAGES += \
    AudioFX \
    CMFileManager \
    SMSetupWizard \
    Eleven \
    PhoneLocationProvider \
    CMSettingsProvider \
    ExactCalculator \
    LiveLockScreenService \
    LockClock \
    Screencast \
    SoundRecorder \
    Trebuchet \
    WallpaperPicker \
    WeatherProvider

# Exchange support
PRODUCT_PACKAGES += \
    Exchange2

# Extra tools in SM
PRODUCT_PACKAGES += \
    7z \
    bash \
    bzip2 \
    curl \
    fsck.ntfs \
    gdbserver \
    htop \
    lib7z \
    libsepol \
    micro_bench \
    mke2fs \
    mkfs.ntfs \
    mount.ntfs \
    oprofiled \
    pigz \
    powertop \
    sqlite3 \
    strace \
    tune2fs \
    unrar \
    unzip \
    vim \
    wget \
    zip

# Custom off-mode charger
ifneq ($(WITH_CM_CHARGER),false)
PRODUCT_PACKAGES += \
    charger_res_images \
    cm_charger_res_images \
    font_log.png \
    libhealthd.cm
endif

# ExFAT support
WITH_EXFAT ?= true
ifeq ($(WITH_EXFAT),true)
TARGET_USES_EXFAT := true
PRODUCT_PACKAGES += \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat
endif

# Openssh
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh

# rsync
PRODUCT_PACKAGES += \
    rsync

# Stagefright FFMPEG plugin
PRODUCT_PACKAGES += \
    libffmpeg_extractor \
    libffmpeg_omx \
    media_codecs_ffmpeg.xml

PRODUCT_PROPERTY_OVERRIDES += \
    media.sf.omx-plugin=libffmpeg_omx.so \
    media.sf.extractor-plugin=libffmpeg_extractor.so

# Storage manager
PRODUCT_PROPERTY_OVERRIDES += \
    ro.storage_manager.enabled=true

# Telephony
PRODUCT_PACKAGES += \
    telephony-ext

PRODUCT_BOOT_JARS += \
    telephony-ext

# These packages are excluded from user builds
ifneq ($(TARGET_BUILD_VARIANT),user)

PRODUCT_PACKAGES += \
    procmem \
    procrank

# Conditionally build in su
ifeq ($(WITH_SU),true)
PRODUCT_PACKAGES += \
    su
endif
<<<<<<< HEAD
=======
endif

DEVICE_PACKAGE_OVERLAYS += vendor/cm/overlay/common

PRODUCT_VERSION_MAJOR = 14
PRODUCT_VERSION_MINOR = 1
PRODUCT_VERSION_MAINTENANCE := 0

ifeq ($(TARGET_VENDOR_SHOW_MAINTENANCE_VERSION),true)
    CM_VERSION_MAINTENANCE := $(PRODUCT_VERSION_MAINTENANCE)
else
    CM_VERSION_MAINTENANCE := 0
>>>>>>> 3c6bdac74bc212b26f723aa8697099fd636451a8
endif


DEVICE_PACKAGE_OVERLAYS += vendor/sm/overlay/common

PRODUCT_VERSION_MAJOR = 71
PRODUCT_VERSION_MINOR = 1

ifdef SM_BUILDTYPE
    ifdef SM_EXTRAVERSION
        # Force build type to EXPERIMENTAL
        SM_BUILDTYPE := EXPERIMENTAL
        # Remove leading dash from SM_EXTRAVERSION
        SM_EXTRAVERSION := $(shell echo $(SM_EXTRAVERSION) | sed 's/-//')
        # Add leading dash to SM_EXTRAVERSION
        SM_EXTRAVERSION := -$(SM_EXTRAVERSION)
    endif
else
    # If SM_BUILDTYPE is not defined, set to UNOFFICIAL
    SM_BUILDTYPE := UNOFFICIAL
    SM_EXTRAVERSION :=
endif

ifneq ($(filter RELEASE,$(SM_BUILDTYPE)),)
    ifdef SM_BUILD_DATE
        SM_VERSION := SM$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(SM_BUILD)-$(SM_BUILD_DATE)-$(SM_BUILDTYPE)
    else
        SM_VERSION := SM$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(SM_BUILD)-$(shell date +%y%m%d)-$(SM_BUILDTYPE)
    endif
else
    SM_VERSION := SM$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(SM_BUILD)-$(shell date +%Y%m%d%H%M)-$(SM_BUILDTYPE)
endif

PRODUCT_PROPERTY_OVERRIDES += \
  ro.sm.version=$(SM_VERSION) \
  ro.sm.releasetype=$(SM_BUILDTYPE) \
  ro.modversion=$(SM_VERSION) \
  ro.cmlegal.url=https://lineageos.org/legal

PRODUCT_EXTRA_RECOVERY_KEYS += \
    vendor/sm/build/target/product/security/lineage

-include vendor/cm-priv/keys/keys.mk

PRODUCT_PROPERTY_OVERRIDES += \
  ro.sm.display.version=$(SM_VERSION)

-include $(WORKSPACE)/build_env/image-auto-bits.mk
-include vendor/sm/config/partner_gms.mk
-include vendor/cyngn/product.mk

$(call prepend-product-if-exists, vendor/extra/product.mk)
