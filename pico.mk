# Copyright (C) 2009 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#
# This file is the build configuration for a full Android
# build for sapphire hardware. This cleanly combines a set of
# device-specific aspects (drivers) with a device-agnostic
# product configuration (apps).
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)
$(call inherit-product, device/common/gps/gps_eu_supl.mk)

# Stuff Common for all HTC Devices
$(call inherit-product, device/htc/common/common.mk)

DEVICE_PACKAGE_OVERLAYS += device/htc/pico/overlay
PRODUCT_LOCALES += mdpi

ifeq ($(TARGET_PREBUILT_KERNEL),)
	LOCAL_KERNEL := device/htc/pico/kernel
else
	LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

# Indcluded Packages
PRODUCT_PACKAGES += \
    librs_jni \
    libaudio \
    libcamera \
    lights.pico \
    libmm-omxcore \
    libOmxCore \
    libOmxVidEnc \
    com.android.future.usb.accessory \
    LiveWallpapers \
    LiveWallpapersPicker \
    gadget_id \
    bash \
    DSPManager \
    dexpreopt \
    hwaddrs \
    copybit.pico \
 
# Publish that we support the live wallpaper feature.
PRODUCT_COPY_FILES += \
    packages/wallpapers/LivePicker/android.software.live_wallpaper.xml:/system/etc/permissions/android.software.live_wallpaper.xml \

# Board-specific init
PRODUCT_COPY_FILES += \
    device/htc/pico/files/init.pico.rc:root/init.pico.rc \
    device/htc/pico/files/ueventd.rc:root/ueventd.rc \
    device/htc/pico/default.prop:root/default.prop \

# Some build properties
PRODUCT_PROPERTY_OVERRIDES += \
    rild.libpath=/system/lib/libhtc_ril.so \
    ro.ril.oem.ecclist=112,911 \
    ro.vold.umsdirtyratio=20
    ro.ril.enable.a52=0 \
    ro.ril.enable.a53=1 \
    ro.ril.def.agps.mode=6 \
    htc.audio.alt.enable=1 \
    htc.audio.hac.enable=1 \
    ro.com.google.networklocation=1 \
    ro.com.google.gmsversion=2.2_r8 \
    ro.setupwizard.enable_bypass=1 \
    dalvik.vm.lockprof.threshold=500 \
    dalvik.vm.dexopt-flags=m=y \
    ro.product.model=HTC Explorer A310e \
    ro.product.brand=htc_europe \
    ro.product.name=htc_pico \
    ro.product.device=pico \
    ro.product.board=pico \
    ro.telephony.call_ring.multiple=false \
    keyguard.no_require_sim=true \
    ro.com.android.dateformat=dd-MM-yyyy \
    persist.telephony.support_ipv6=true \
    persist.telephony.support_ipv4=true
    service.brcm.bt.activation = 0 \
    service.brcm.bt.srv_active = 0 \
    service.brcm.bt.hcid_active = 0 \
    service.brcm.bt.btld = 0 \
    service.brcm.bt.btld_pid = 0 \
    service.brcm.bt.avrcp_pass_thru = 0 \
    service.brcm.bt.avrcp_toggle = 1 \
  
# Prebuilt libraries that are needed to build open-source libraries
PRODUCT_COPY_FILES += \
#   vendor/htc/pico/proprietary/libcamera.so:obj/lib/libcamera.so \
    vendor/htc/pico/proprietary/libril.so:obj/lib/libril.so \

# Prebuilt Binaries
PRODUCT_COPY_FILES += \
    vendor/htc/pico/proprietary/bin/awb_camera:system/bin/awb_camera \
    vendor/htc/pico/proprietary/bin/bma150_usr:system/bin/bma150_usr \
    vendor/htc/pico/proprietary/bin/btld:system/bin/btld \
    vendor/htc/pico/proprietary/bin/cam_ins_spmo:system/bin/cam_ins_spmo \
    vendor/htc/pico/proprietary/bin/charging:system/bin/charging \
    vendor/htc/pico/proprietary/bin/htc_ebdlogd:system/bin/htc_ebdlogd \
    vendor/htc/pico/proprietary/bin/ipd:system/bin/ipd \
    vendor/htc/pico/proprietary/bin/logcat2:system/bin/logcat2 \
    vendor/htc/pico/proprietary/bin/lsc_camera:system/bin/lsc_camera \
    vendor/htc/pico/proprietary/bin/mm-qcamera-test:system/bin/mm-qcamera-test \
    vendor/htc/pico/proprietary/bin/mm-qcamera-testsuite-client-awb:system/bin/mm-qcamera-testsuite-client-awb \
    vendor/htc/pico/proprietary/bin/netsharing:system/bin/netsharing \
    vendor/htc/pico/proprietary/bin/rild:system/bin/rild \
    vendor/htc/pico/proprietary/bin/ser2net:system/bin/ser2net \
    vendor/htc/pico/proprietary/bin/snd:system/bin/snd \
    vendor/htc/pico/proprietary/bin/snd8k:system/bin/snd8k \
    vendor/htc/pico/proprietary/bin/tc:system/bin/tc \
    vendor/htc/pico/proprietary/bin/tund:system/bin/tund \
    vendor/htc/pico/proprietary/bin/udhcpd:system/bin/udhcpd\
    vendor/htc/pico/proprietary/bin/wireless_modem:system/xbin/wireless_modem \
    vendor/htc/pico/proprietary/bin/zchgd:system/bin/zchgd \

# Prebuilt Modules
PRODUCT_COPY_FILES += \
    device/htc/pico/files/bcm4330.ko:system/lib/modules/bcm4330.ko \
    device/htc/pico/files/dal_remotetest.ko:system/lib/modules/dal_remotetest.ko \
    device/htc/pico/files/dma_test.ko:system/lib/modules/dma_test.ko \
    device/htc/pico/files/gspca_main.ko:system/lib/modules/gspca_main.ko \
    device/htc/pico/files/kineto_gan.ko:system/lib/modules/kineto_gan.ko \
    device/htc/pico/files/lcd.ko:system/lib/modules/lcd.ko \
    device/htc/pico/files/librasdioif.ko:system/lib/modules/librasdioif.ko \
    device/htc/pico/files/max2165.ko:system/lib/modules/max2165.ko \
    device/htc/pico/files/mc44s803.ko:system/lib/modules/mc44s803.ko \
    device/htc/pico/files/mmc_test.ko:system/lib/modules/mmc_test.ko \
    device/htc/pico/files/mt20xx.ko:system/lib/modules/mt20xx.ko \
    device/htc/pico/files/mt2060.ko:system/lib/modules/mt2060.ko \
    device/htc/pico/files/mt2131.ko:system/lib/modules/mt2131.ko \
    device/htc/pico/files/mt2266.ko:system/lib/modules/mt2266.ko \
    device/htc/pico/files/mxl5005s.ko:system/lib/modules/mxl5005s.ko \
    device/htc/pico/files/mxl5007t.ko:system/lib/modules/mxl5007t.ko \
    device/htc/pico/files/qt1010.ko:system/lib/modules/qt1010.ko \
    device/htc/pico/files/tda827x.ko:system/lib/modules/tda827x.ko \
    device/htc/pico/files/tda8290.ko:system/lib/modules/tda8290.ko \
    device/htc/pico/files/tda9887.ko:system/lib/modules/tda9887.ko \
    device/htc/pico/files/tda18218.ko:system/lib/modules/tda18218.ko \
    device/htc/pico/files/tda18271.ko:system/lib/modules/tda18271.ko \
    device/htc/pico/files/tea5761.ko:system/lib/modules/tea5761.ko \
    device/htc/pico/files/tea5767.ko:system/lib/modules/tea5767.ko \
    device/htc/pico/files/tuner-simple.ko:system/lib/modules/tuner-simple.ko \
    device/htc/pico/files/tuner-types.ko:system/lib/modules/tuner-types.ko \
    device/htc/pico/files/tuner-xc2028.ko:system/lib/modules/tuner-xc2028.ko \
    device/htc/pico/files/xc5000.ko:system/lib/modules/xc5000.ko \

# Wifi
PRODUCT_COPY_FILES += \
    device/htc/pico/files/etc/wifi/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf \
    device/htc/pico/files/etc/dhcpd/dhcpcd.conf:system/etc/dhcpcd/dhcpcd.conf \

# SD Card
PRODUCT_COPY_FILES += \
    device/htc/pico/files/etc/vold.fstab:system/etc/vold.fstab \

# Audio
PRODUCT_COPY_FILES += \
    device/htc/pico/files/etc/AudioFilter.csv:system/etc/AudioFilter.csv \
    device/htc/pico/files/etc/media_profiles.xml:system/etc/media_profiles.xml \
    vendor/htc/pico/proprietary/lib/libaudioeq.so:system/lib/libaudioeq.so \

# Device permissions
PRODUCT_COPY_FILES += \
    frameworks/base/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/base/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/base/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/base/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/base/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/base/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/base/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
    frameworks/base/data/etc/android.hardware.touchscreen.multitouch.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.xml \
    frameworks/base/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml

# Sensors
PRODUCT_COPY_FILES += \
    vendor/htc/pico/proprietary/lib/hw/sensors.pico.so:system/lib/hw/sensors.pico.so \
    vendor/htc/pico/proprietary/lib/hw/lights.msm7k.so:system/lib/hw/lights.msm7k.so \
    
# GPS
PRODUCT_COPY_FILES += \
    vendor/htc/pico/proprietary/lib/hw/gps.pico.so:system/lib/hw/gps.pico.so \

# 3D
PRODUCT_COPY_FILES += \
    vendor/htc/pico/proprietary/lib/egl/libEGL_adreno200.so:system/lib/egl/libEGL_adreno200.so \
    vendor/htc/pico/proprietary/lib/egl/libGLESv1_CM_adreno200.so:system/lib/egl/libGLESv1_CM_adreno200.so \
    vendor/htc/pico/proprietary/lib/egl/libGLESv2_adreno200.so:system/lib/egl/libGLESv2_adreno200.so \
    vendor/htc/pico/proprietary/lib/egl/libq3dtools_adreno200.so:system/lib/egl/libq3dtools_adreno200.so \
    vendor/htc/pico/proprietary/lib/libgsl.so:system/lib/libgsl.so \
#   vendor/htc/pico/proprietary/lib/hw/eglsubAndroid.so:system/lib/hw/eglsubAndroid.so \
    vendor/htc/pico/proprietary/etc/firmware/yamato_pfp.fw:system/etc/firmware/yamato_pfp.fw \
    vendor/htc/pico/proprietary/etc/firmware/yamato_pm4.fw:system/etc/firmware/yamato_pm4.fw \

# Camera
PRODUCT_COPY_FILES += \
    vendor/htc/pico/proprietary/lib/liboemcamera.so:system/lib/liboemcamera.so \
    vendor/htc/pico/proprietary/lib/libmmipl.so:system/lib/libmmipl.so \
    vendor/htc/pico/proprietary/lib/libmmjpeg.so:system/lib/libmmjpeg.so \
    vendor/htc/pico/proprietary/lib/libcameraface.so:system/lib/libcameraface.so \
    vendor/htc/pico/proprietary/lib/libcamerapp.so:system/lib/libcamerapp.so \
    vendor/htc/pico/proprietary/lib/libcapsjava.so:system/lib/libcapsjava.so \
    vendor/htc/pico/proprietary/lib/libscaladoapi.so:system/lib/libscaladoapi.so \
    vendor/htc/pico/proprietary/lib/libscalado_htcalbum2.so:system/lib/libscalado_htcalbum2.so \
    vendor/htc/pico/proprietary/lib/libscaladoutil.so:system/lib/libscaladoutil.so \

# RIL
PRODUCT_COPY_FILES += \
    vendor/htc/pico/proprietary/lib/libhtc_ril_switch.so:system/lib/libhtc_ril_switch.so \
    vendor/htc/pico/proprietary/lib/libhtc_ril.so:system/lib/libhtc_ril.so \
    vendor/htc/pico/proprietary/lib/libreference-cdma-sms.so:system/lib/libreference-cdma-sms.so \

#CHROMATIX
PRODUCT_COPY_FILES += \
    vendor/htc/pico/proprietary/lib/libchromatix_mt9t013_default_video.so:system/lib/libchromatix_mt9t013_default_video.so \
    vendor/htc/pico/proprietary/lib/libchromatix_mt9t013_preview.so:system/lib/libchromatix_mt9t013_preview.so \

# OMX & MISC.
PRODUCT_COPY_FILES += \
    vendor/htc/pico/proprietary/lib/libmm-adspsvc.so:system/lib/libmm-adspsvc.so \
    vendor/htc/pico/proprietary/lib/libOmxH264Dec.so:system/lib/libOmxH264Dec.so \
    vendor/htc/pico/proprietary/lib/libOmxMpeg4Dec.so:system/lib/libOmxMpeg4Dec.so \
    vendor/htc/pico/proprietary/lib/libOmxVidEnc.so:system/lib/libOmxVidEnc.so \
    vendor/htc/pico/proprietary/lib/libOlaEngine.so:system/lib/libOlaEngine.so \
    vendor/htc/pico/proprietary/lib/libwsp.so:system/lib/libwsp.so \
    vendor/htc/pico/proprietary/lib/libwsp_jni.so:system/lib/libwsp_jni.so \
    vendor/htc/pico/proprietary/lib/libwebkitaccel.so:system/lib/libwebkitaccel.so \
    vendor/htc/pico/proprietary/lib/libOpenVG.so:system/lib/libOpenVG.so \
    vendor/htc/pico/proprietary/lib/libext2_blkid.so:system/lib/libext2_blkid.so \
    vendor/htc/pico/proprietary/lib/libext2_com_err.so:system/lib/libext2_com_err.so \
    vendor/htc/pico/proprietary/lib/libext2_e2p.so:system/lib/libext2_e2p.so \
    vendor/htc/pico/proprietary/lib/libext2fs.so:system/lib/libext2fs.so \
    vendor/htc/pico/proprietary/lib/libext2_profile.so:system/lib/libext2_profile.so \
    vendor/htc/pico/proprietary/lib/libext2_uuid.so:system/lib/libext2_uuid.so \
    vendor/htc/pico/proprietary/etc/gps.conf:system/etc
    vendor/htc/pico/proprietary/etc/spn-conf.xml:system/etc

# Audio DSP Profiles
PRODUCT_COPY_FILES += \
    device/htc/pico/dsp/AIC3254_REG.csv:system/etc/AIC3254_REG.csv \
    device/htc/pico/dsp/AIC3254_REG_DualMic.csv:system/etc/AIC3254_REG_DualMic.csv \
    device/htc/pico/dsp/AIC3254_REG_DualMicXD01.csv:system/etc/AIC3254_REG_DualMicXD01.csv \
    device/htc/pico/dsp/AIC3254_REG_DualMicXD02.csv:system/etc/AIC3254_REG_DualMicXD02.csv \
    device/htc/pico/dsp/AdieHWCodec.csv:system/etc/AdieHWCodec.csv \
    device/htc/pico/dsp/AudioBTID.csv:system/etc/AudioBTID.csv \
    device/htc/pico/dsp/CodecDSPID.txt:system/etc/CodecDSPID.txt \
    device/htc/pico/dsp/CodecDSPID_BCLK.txt:system/etc/CodecDSPID_BCLK.txt \
    device/htc/pico/dsp/HP_Audio.csv:system/etc/HP_Audio.csv \
    device/htc/pico/dsp/HP_Video.csv:system/etc/HP_Video.csv \
    device/htc/pico/dsp/SPK_Combination.csv:system/etc/SPK_Combination.csv \
    device/htc/pico/dsp/TPA2051_CFG.csv:system/etc/TPA2051_CFG.csv \
    device/htc/pico/dsp/soundimage/Sound_Bass_Booster.txt:system/etc/soundimage/Sound_Bass_Booster.txt \
    device/htc/pico/dsp/soundimage/Sound_Blues.txt:system/etc/soundimage/Sound_Blues.txt \
    device/htc/pico/dsp/soundimage/Sound_Classical.txt:system/etc/soundimage/Sound_Classical.txt \
    device/htc/pico/dsp/soundimage/Sound_Country.txt:system/etc/soundimage/Sound_Country.txt \
    device/htc/pico/dsp/soundimage/Sound_Dolby_A_HP.txt:system/etc/soundimage/Sound_Dolby_A_HP.txt \
    device/htc/pico/dsp/soundimage/Sound_Dolby_A_SPK.txt:system/etc/soundimage/Sound_Dolby_A_SPK.txt \
    device/htc/pico/dsp/soundimage/Sound_Dolby_HP.txt:system/etc/soundimage/Sound_Dolby_HP.txt \
    device/htc/pico/dsp/soundimage/Sound_Dolby_Spk.txt:system/etc/soundimage/Sound_Dolby_Spk.txt \
    device/htc/pico/dsp/soundimage/Sound_Dolby_V_HP.txt:system/etc/soundimage/Sound_Dolby_V_HP.txt \
    device/htc/pico/dsp/soundimage/Sound_Dolby_V_SPK.txt:system/etc/soundimage/Sound_Dolby_V_SPK.txt \
    device/htc/pico/dsp/soundimage/Sound_Dualmic.txt:system/etc/soundimage/Sound_Dualmic.txt \
    device/htc/pico/dsp/soundimage/Sound_Dualmic_EP.txt:system/etc/soundimage/Sound_Dualmic_EP.txt \
    device/htc/pico/dsp/soundimage/Sound_Dualmic_SPK.txt:system/etc/soundimage/Sound_Dualmic_SPK.txt \
    device/htc/pico/dsp/soundimage/Sound_Jazz.txt:system/etc/soundimage/Sound_Jazz.txt \
    device/htc/pico/dsp/soundimage/Sound_Latin.txt:system/etc/soundimage/Sound_Latin.txt \
    device/htc/pico/dsp/soundimage/Sound_New_Age.txt:system/etc/soundimage/Sound_New_Age.txt \
    device/htc/pico/dsp/soundimage/Sound_Original.txt:system/etc/soundimage/Sound_Original.txt \
    device/htc/pico/dsp/soundimage/Sound_Original_BCLK.txt:system/etc/soundimage/Sound_Original_BCLK.txt \
    device/htc/pico/dsp/soundimage/Sound_Original_Recording.txt:system/etc/soundimage/Sound_Original_Recording.txt \
    device/htc/pico/dsp/soundimage/Sound_Original_Recording_BCLK.txt:system/etc/soundimage/Sound_Original_Recording_BCLK.txt \
    device/htc/pico/dsp/soundimage/Sound_Original_SPK.txt:system/etc/soundimage/Sound_Original_SPK.txt \
    device/htc/pico/dsp/soundimage/Sound_Original_SPK_BCLK.txt:system/etc/soundimage/Sound_Phone_Original_SPK_BCLK.txt \
    device/htc/pico/dsp/soundimage/Sound_Phone_Original_HP.txt:system/etc/soundimage/Sound_Phone_Original_HP.txt \
    device/htc/pico/dsp/soundimage/Sound_Phone_Original_HP_BCLK.txt:system/etc/soundimage/Sound_Phone_Original_HP_BCLK.txt \
    device/htc/pico/dsp/soundimage/Sound_Phone_Original_REC.txt:system/etc/soundimage/Sound_Phone_Original_REC.txt \
    device/htc/pico/dsp/soundimage/Sound_Phone_Original_REC_BCLK.txt:system/etc/soundimage/Sound_Phone_Original_REC_BCLK.txt \
    device/htc/pico/dsp/soundimage/Sound_Phone_Original_SPK.txt:system/etc/soundimage/Sound_Phone_Original_SPK.txt \
    device/htc/pico/dsp/soundimage/Sound_Phone_Original_SPK_BCLK.txt:system/etc/soundimage/Sound_Phone_Original_SPK_BCLK.txt \
    device/htc/pico/dsp/soundimage/Sound_Piano.txt:system/etc/soundimage/Sound_Piano.txt \
    device/htc/pico/dsp/soundimage/Sound_Pop.txt:system/etc/soundimage/Sound_Pop.txt \
    device/htc/pico/dsp/soundimage/Sound_R_B.txt:system/etc/soundimage/Sound_R_B.txt \
    device/htc/pico/dsp/soundimage/Sound_Recording.txt:system/etc/soundimage/Sound_Recording.txt \
    device/htc/pico/dsp/soundimage/Sound_Recording_BCLK.txt:system/etc/soundimage/Sound_Recording_BCLK.txt \
    device/htc/pico/dsp/soundimage/Sound_Rock.txt:system/etc/soundimage/Sound_Rock.txt \
    device/htc/pico/dsp/soundimage/Sound_SRS_A_HP.txt:system/etc/soundimage/Sound_SRS_A_HP.txt \
    device/htc/pico/dsp/soundimage/Sound_SRS_A_SPK.txt:system/etc/soundimage/Sound_SRS_A_SPK.txt \
    device/htc/pico/dsp/soundimage/Sound_SRS_V_HP.txt:system/etc/soundimage/Sound_SRS_V_HP.txt \
    device/htc/pico/dsp/soundimage/Sound_SRS_V_SPK.txt:system/etc/soundimage/Sound_SRS_V_SPK.txt \
    device/htc/pico/dsp/soundimage/Sound_Treble_Booster.txt:system/etc/soundimage/Sound_Treble_Booster.txt \
    device/htc/pico/dsp/soundimage/Sound_Vocal_Booster.txt:system/etc/soundimage/Sound_Vocal_Booster.txt \
    vendor/htc/pico/proprietary/etc/soundimage/srsfx_trumedia_51.cfg:system/etc/soundimage/srsfx_trumedia_51.cfg \
    vendor/htc/pico/proprietary/etc/soundimage/srsfx_trumedia_movie.cfg:system/etc/soundimage/srsfx_trumedia_movie.cfg \
    vendor/htc/pico/proprietary/etc/soundimage/srsfx_trumedia_voice.cfg:system/etc/soundimage/srsfx_trumedia_voice.cfg \
    vendor/htc/pico/proprietary/etc/soundimage/srs_geq10.cfg:system/etc/soundimage/srs_geq10.cfg \
    vendor/htc/pico/proprietary/etc/soundimage/srsfx_trumedia_music.cfg:system/etc/soundimage/srsfx_trumedia_music.cfg \

# Bluetooth
PRODUCT_COPY_FILES += \
    vendor/htc/pico/proprietary/etc/firmware/BCM4330B1_002.001.003.0221.0228.hcd:system/etc/firmware/BCM4330B1_002.001.003.0221.0228.hcd \

# Keylayouts
PRODUCT_COPY_FILES += \
    device/htc/pico/keychars/qwerty2.kcm.bin:system/usr/keychars/qwerty2.kcm.bin \
    device/htc/pico/keychars/qwerty.kcm.bin:system/usr/keychars/qwerty.kcm.bin \
    device/htc/pico/keychars/pico-keypad.kcm.bin:system/usr/keychars/pico-keypad.kcm.bin \
    device/htc/pico/keychars/BT_HID.kcm.bin:system/usr/keychars/BT_HID.kcm.bin \
    device/htc/pico/keylayout/h2w_headset.kl:system/usr/keylayout/h2w_headset.kl \
    device/htc/pico/keylayout/qwerty.kl:system/usr/keylayout/qwerty.kl \
    device/htc/pico/keylayout/BT_HID.kl:system/usr/keylayout/BT_HID.kl \
    device/htc/pico/keylayout/pico-keypad.kl:system/usr/keylayout/pico-keypad.kl
    device/htc/pico/keylayout/AVRCP.kl:system/usr/keylayout/AVRCP.kl \

