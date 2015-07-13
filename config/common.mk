PRODUCT_BRAND ?= sudamod

ifneq ($(TARGET_SCREEN_WIDTH) $(TARGET_SCREEN_HEIGHT),$(space))
# determine the smaller dimension
TARGET_BOOTANIMATION_SIZE := $(shell \
  if [ $(TARGET_SCREEN_WIDTH) -lt $(TARGET_SCREEN_HEIGHT) ]; then \
    echo $(TARGET_SCREEN_WIDTH); \
  else \
    echo $(TARGET_SCREEN_HEIGHT); \
  fi )

# get a sorted list of the sizes
bootanimation_sizes := $(subst .zip,, $(shell ls vendor/sm/prebuilt/common/bootanimation))
bootanimation_sizes := $(shell echo -e $(subst $(space),'\n',$(bootanimation_sizes)) | sort -rn)

# find the appropriate size and set
define check_and_set_bootanimation
$(eval TARGET_BOOTANIMATION_NAME := $(shell \
  if [ -z "$(TARGET_BOOTANIMATION_NAME)" ]; then
    if [ $(1) -le $(TARGET_BOOTANIMATION_SIZE) ]; then \
      echo $(1); \
      exit 0; \
    fi;
  fi;
  echo $(TARGET_BOOTANIMATION_NAME); ))
endef
$(foreach size,$(bootanimation_sizes), $(call check_and_set_bootanimation,$(size)))

ifeq ($(TARGET_BOOTANIMATION_HALF_RES),true)
PRODUCT_BOOTANIMATION := vendor/sm/prebuilt/common/bootanimation/halfres/$(TARGET_BOOTANIMATION_NAME).zip
else
PRODUCT_BOOTANIMATION := vendor/sm/prebuilt/common/bootanimation/$(TARGET_BOOTANIMATION_NAME).zip
endif
endif

ifdef SM_NIGHTLY
PRODUCT_PROPERTY_OVERRIDES += \
    ro.rommanager.developerid=sudamodnightly
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.rommanager.developerid=sudamod
endif

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.com.android.dataroaming=false

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.selinux=1

# Thank you, please drive thru!
PRODUCT_PROPERTY_OVERRIDES += persist.sys.dun.override=0

ifneq ($(TARGET_BUILD_VARIANT),eng)
# Enable ADB authentication
ADDITIONAL_DEFAULT_PROPERTIES += ro.adb.secure=1
endif

# Copy over the changelog to the device
PRODUCT_COPY_FILES += \
    vendor/sm/CHANGELOG.mkdn:system/etc/CHANGELOG-CM.txt

# Backup Tool
ifneq ($(WITH_GMS),true)
PRODUCT_COPY_FILES += \
    vendor/sm/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/sm/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/sm/prebuilt/common/bin/50-sm.sh:system/addon.d/50-sm.sh \
    vendor/sm/prebuilt/common/bin/blacklist:system/addon.d/blacklist
endif

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

# SuperSU
PRODUCT_COPY_FILES += \
 vendor/sm/prebuilt/common/supersu/UPDATE-SuperSU.zip:supersu/UPDATE-SuperSU.zip \
 vendor/sm/prebuilt/common/etc/init.d/99SuperSUDaemon:system/etc/init.d/99SuperSUDaemon

# Xposed
PRODUCT_COPY_FILES += \
 vendor/sm/prebuilt/common/xposed/UPDATE-XPOSED.zip:xposed/UPDATE-XPOSED.zip \

# Bring in camera effects
PRODUCT_COPY_FILES +=  \
    vendor/sm/prebuilt/common/media/LMprec_508.emd:system/media/LMprec_508.emd \
    vendor/sm/prebuilt/common/media/PFFprec_600.emd:system/media/PFFprec_600.emd

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


# T-Mobile theme engine
include vendor/sm/config/themes_common.mk


# Screen recorder
PRODUCT_PACKAGES += \
    libscreenrecorder \
    ScreenRecorder

# Required SM packages
PRODUCT_PACKAGES += \
    Development \
    BluetoothExt \
    Profiles

# Optional SM packages
PRODUCT_PACKAGES += \
    VoicePlus \
    Basic \
    libemoji \
    Terminal

PRODUCT_PROPERTY_OVERRIDES += \
    persist.radio.ipcall.enabled=true


# Custom SM packages
PRODUCT_PACKAGES += \
    AudioFX \
    CMWallpapers \
    CMFileManager \
    Eleven \
    LockClock \
    SudaLauncher
#SudaModUpdater 

# CM Platform Library
PRODUCT_PACKAGES += \
    org.cyanogenmod.platform-res \
    org.cyanogenmod.platform \
    org.cyanogenmod.platform.xml

# CM Hardware Abstraction Framework
PRODUCT_PACKAGES += \
    org.cyanogenmod.hardware \
    org.cyanogenmod.hardware.xml

# Extra tools in SM
PRODUCT_PACKAGES += \
    libsepol \
    e2fsck \
    mke2fs \
    tune2fs \
    bash \
    nano \
    htop \
    powertop \
    lsof \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat \
    mkfs.f2fs \
    fsck.f2fs \
    fibmap.f2fs \
    ntfsfix \
    ntfs-3g \
    gdbserver \
    micro_bench \
    oprofiled \
    sqlite3 \
    strace

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

# These packages are excluded from user builds
ifneq ($(TARGET_BUILD_VARIANT),user)

PRODUCT_PACKAGES += \
    procmem \
    procrank \
    su

PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.root_access=1
else

PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.root_access=0

endif

# Chromium Prebuilt
ifeq ($(PRODUCT_PREBUILT_WEBVIEWCHROMIUM),yes)
-include prebuilts/chromium/$(SM_BUILD)/chromium_prebuilt.mk
endif

PRODUCT_PACKAGE_OVERLAYS += vendor/sm/overlay/common

PRODUCT_VERSION_MAJOR = 51
PRODUCT_VERSION_MINOR = 1
PRODUCT_VERSION_MAINTENANCE = 0

# Set SM_BUILDTYPE and Odex support
ifneq ($(filter mokee buildbot-0x,$(shell python -c 'import os;print os.uname()[1][:11]')),)

    ifdef SM_NIGHTLY
        SM_BUILDTYPE := NIGHTLY
    endif
    ifdef SM_EXPERIMENTAL
        SM_BUILDTYPE := EXPERIMENTAL
    endif
    ifdef SM_RELEASE
        SM_BUILDTYPE := RELEASE
        WITH_DEXPREOPT := true
    endif
    ifdef SM_HISTORY
        SM_BUILDTYPE := HISTORY
        WITH_DEXPREOPT := true
    endif
endif

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
    SM_BUILDTYPE := OFFICIAL
    SM_EXTRAVERSION :=
endif

ifneq ($(filter RELEASE HISTORY,$(SM_BUILDTYPE)),)
    ifdef SM_BUILD_DATE
        SM_VERSION := SM$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(SM_BUILD)-$(SM_BUILD_DATE)-$(SM_BUILDTYPE)
    else
        SM_VERSION := SM$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(SM_BUILD)-$(shell date +%y%m%d)-$(SM_BUILDTYPE)
    endif
else
    SM_VERSION := SM$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(SM_BUILD)-$(shell date +%Y%m%d%H%M)-$(SM_BUILDTYPE)
endif

ifndef CM_PLATFORM_SDK_VERSION
  # This is the canonical definition of the SDK version, which defines
  # the set of APIs and functionality available in the platform.  It
  # is a single integer that increases monotonically as updates to
  # the SDK are released.  It should only be incremented when the APIs for
  # the new release are frozen (so that developers don't write apps against
  # intermediate builds).
  CM_PLATFORM_SDK_VERSION := 1
endif

PRODUCT_PROPERTY_OVERRIDES += \
  ro.sm.version=$(SM_VERSION) \
  ro.sm.releasetype=$(SM_BUILDTYPE) \
  ro.modversion=$(SM_VERSION)

-include vendor/sm-priv/keys/keys.mk

-include $(WORKSPACE)/build_env/image-auto-bits.mk

-include $(WORKSPACE)/build-env/image-auto-bits.mk

$(call prepend-product-if-exists, vendor/extra/product.mk)
