# set toolchains directory
TOP=$(realpath ../)

# Set Architecture and Config
KERNEL_ARCH=arm64
ARCH=${KERNEL_ARCH}
DEFCONFIG='vendor/lahaina-qgki_defconfig'

# export aosp gcc toolchains path
PATH="$TOP/tools/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin:$PATH"
PATH="$TOP/tools/gcc/linux-x86/arm/arm-linux-androideabi-4.9/bin:$PATH"
PATH="$TOP/tools/clang/host/linux-x86/clang-r428724/bin:$PATH"
export LD_LIBRARY_PATH="$TOP/tools/clang/host/linux-x86/clang-r428724/lib64:$LD_LIBRARY_PATH"

# Cross Compile Flags
CLANG_TRIPLE=aarch64-linux-gnu-
CROSS_COMPILE=aarch64-linux-android-
CROSS_COMPILE_COMPAT=arm-linux-androideabi-

# Set tools path
TARGET_KERNEL_MAKE_ENV+="HOSTCC=${TOP}/tools/clang/host/linux-x86/clang-r428724/bin/clang "
TARGET_KERNEL_MAKE_ENV+="HOSTCXX=${TOP}/tools/clang/host/linux-x86/clang-r428724/bin/clang++ "
TARGET_KERNEL_MAKE_ENV+="HOSTLD=${TOP}/tools/clang/host/linux-x86/clang-r428724/bin/ld.lld "
TARGET_KERNEL_MAKE_ENV+="CC=${TOP}/tools/clang/host/linux-x86/clang-r428724/bin/clang "
TARGET_KERNEL_MAKE_ENV+="LLVM=${TOP}/tools/clang/host/linux-x86/clang-r428724/bin/clang "
TARGET_KERNEL_MAKE_ENV+="LD=${TOP}/tools/clang/host/linux-x86/clang-r428724/bin/ld.lld "
TARGET_KERNEL_MAKE_ENV+="AR=${TOP}/tools/clang/host/linux-x86/clang-r428724/bin/llvm-ar "
TARGET_KERNEL_MAKE_ENV+="NM=${TOP}/tools/clang/host/linux-x86/clang-r428724/bin/llvm-nm "
TARGET_KERNEL_MAKE_ENV+="OBJCOPY=${TOP}/tools/clang/host/linux-x86/clang-r428724/bin/llvm-objcopy "
TARGET_KERNEL_MAKE_ENV+="OBJDUMP=${TOP}/tools/clang/host/linux-x86/clang-r428724/bin/llvm-objdump "
TARGET_KERNEL_MAKE_ENV+="OBJSIZE=${TOP}/tools/clang/host/linux-x86/clang-r428724/bin/llvm-size "
TARGET_KERNEL_MAKE_ENV+="READELF=${TOP}/tools/clang/host/linux-x86/clang-r428724/bin/llvm-readelf "
TARGET_KERNEL_MAKE_ENV+="STRIP=${TOP}/tools/clang/host/linux-x86/clang-r428724/bin/llvm-strip "

# make instructions
make O=out ${TARGET_KERNEL_MAKE_ENV} ARCH=${ARCH} CROSS_COMPILE=${CROSS_COMPILE} CROSS_COMPILE_COMPAT=${CROSS_COMPILE_COMPAT} CLANG_TRIPLE=${CLANG_TRIPLE} ${DEFCONFIG}

make O=out ${TARGET_KERNEL_MAKE_ENV} ARCH=${ARCH} CROSS_COMPILE=${CROSS_COMPILE} CROSS_COMPILE_COMPAT=${CROSS_COMPILE_COMPAT} CLANG_TRIPLE=${CLANG_TRIPLE} -j12

mkdir out/gen_modules

cp out/drivers/bluetooth/bt_fm_slim.ko out/gen_modules
cp out/drivers/bluetooth/btpower.ko out/gen_modules
cp out/drivers/char/rdbg.ko out/gen_modules
cp out/drivers/edac/qcom_edac.ko out/gen_modules
cp out/drivers/hid/hid-aksys.ko out/gen_modules
cp out/drivers/input/uff_fp_drivers/uff_fp_driver.ko out/gen_modules
cp out/drivers/media/radio/rtc6226/radio-i2c-rtc6226-qca.ko out/gen_modules
cp out/drivers/media/tuners/e4000.ko out/gen_modules
cp out/drivers/media/tuners/fc0011.ko out/gen_modules
cp out/drivers/media/tuners/fc0012.ko out/gen_modules
cp out/drivers/media/tuners/fc0013.ko out/gen_modules
cp out/drivers/media/tuners/fc2580.ko out/gen_modules
cp out/drivers/media/tuners/it913x.ko out/gen_modules
cp out/drivers/media/tuners/m88rs6000t.ko out/gen_modules
cp out/drivers/media/tuners/max2165.ko out/gen_modules
cp out/drivers/media/tuners/mc44s803.ko out/gen_modules
cp out/drivers/media/tuners/msi001.ko out/gen_modules
cp out/drivers/media/tuners/mt2060.ko out/gen_modules
cp out/drivers/media/tuners/mt2063.ko out/gen_modules
cp out/drivers/media/tuners/mt20xx.ko out/gen_modules
cp out/drivers/media/tuners/mt2131.ko out/gen_modules
cp out/drivers/media/tuners/mt2266.ko out/gen_modules
cp out/drivers/media/tuners/mxl301rf.ko out/gen_modules
cp out/drivers/media/tuners/mxl5005s.ko out/gen_modules
cp out/drivers/media/tuners/mxl5007t.ko out/gen_modules
cp out/drivers/media/tuners/qm1d1b0004.ko out/gen_modules
cp out/drivers/media/tuners/qm1d1c0042.ko out/gen_modules
cp out/drivers/media/tuners/qt1010.ko out/gen_modules
cp out/drivers/media/tuners/r820t.ko out/gen_modules
cp out/drivers/media/tuners/si2157.ko out/gen_modules
cp out/drivers/media/tuners/tda18212.ko out/gen_modules
cp out/drivers/media/tuners/tda18218.ko out/gen_modules
cp out/drivers/media/tuners/tda18250.ko out/gen_modules
cp out/drivers/media/tuners/tda9887.ko out/gen_modules
cp out/drivers/media/tuners/tea5761.ko out/gen_modules
cp out/drivers/media/tuners/tea5767.ko out/gen_modules
cp out/drivers/media/tuners/tua9001.ko out/gen_modules
cp out/drivers/media/tuners/tuner-simple.ko out/gen_modules
cp out/drivers/media/tuners/tuner-types.ko out/gen_modules
cp out/drivers/media/tuners/tuner-xc2028.ko out/gen_modules
cp out/drivers/media/tuners/xc4000.ko out/gen_modules
cp out/drivers/media/tuners/xc5000.ko out/gen_modules
cp out/drivers/misc/aw8697_haptic/aw8697.ko out/gen_modules
cp out/drivers/misc/aw8697_haptic/haptic.ko out/gen_modules
cp out/drivers/misc/aw8697_haptic/haptic_feedback.ko out/gen_modules
cp out/drivers/slimbus/slimbus-ngd.ko out/gen_modules
cp out/drivers/slimbus/slimbus.ko out/gen_modules
cp out/drivers/soc/oplus/oplus_consumer_ir/oplus_bsp_ir_core.ko out/gen_modules
cp out/drivers/soc/oplus/oplus_consumer_ir/oplus_bsp_kookong_ir_spi.ko out/gen_modules
cp out/drivers/soc/oplus/thermal/horae_shell_temp.ko out/gen_modules
cp out/drivers/soc/qcom/llcc_perfmon.ko out/gen_modules
cp out/drivers/staging/qcacld-3.0/wlan.ko out/gen_modules
cp out/gen_modules/wlan.ko out/gen_modules/qca_cld3_wlan.ko
cp out/net/oplus_connectivity_routerboost/oplus_connectivity_routerboost.ko out/gen_modules
cp out/techpack/audio/asoc/codecs/aw882xx/aw882xx_dlkm.ko out/gen_modules
cp out/techpack/audio/asoc/codecs/bolero/bolero_cdc_dlkm.ko out/gen_modules
cp out/techpack/audio/asoc/codecs/bolero/rx_macro_dlkm.ko out/gen_modules
cp out/techpack/audio/asoc/codecs/bolero/tx_macro_dlkm.ko out/gen_modules
cp out/techpack/audio/asoc/codecs/bolero/va_macro_dlkm.ko out/gen_modules
cp out/techpack/audio/asoc/codecs/bolero/wsa_macro_dlkm.ko out/gen_modules
cp out/techpack/audio/asoc/codecs/hdmi_dlkm.ko out/gen_modules
cp out/techpack/audio/asoc/codecs/mbhc_dlkm.ko out/gen_modules
cp out/techpack/audio/asoc/codecs/sia81xx/sia81xx_dlkm.ko out/gen_modules
cp out/techpack/audio/asoc/codecs/stub_dlkm.ko out/gen_modules
cp out/techpack/audio/asoc/codecs/swr_dmic_dlkm.ko out/gen_modules
cp out/techpack/audio/asoc/codecs/swr_haptics_dlkm.ko out/gen_modules
cp out/techpack/audio/asoc/codecs/tfa98xx-v6/tfa98xx-v6_dlkm.ko out/gen_modules
cp out/techpack/audio/asoc/codecs/wcd937x/wcd937x_dlkm.ko out/gen_modules
cp out/techpack/audio/asoc/codecs/wcd937x/wcd937x_slave_dlkm.ko out/gen_modules
cp out/techpack/audio/asoc/codecs/wcd938x/wcd938x_dlkm.ko out/gen_modules
cp out/techpack/audio/asoc/codecs/wcd938x/wcd938x_slave_dlkm.ko out/gen_modules
cp out/techpack/audio/asoc/codecs/wcd9xxx_dlkm.ko out/gen_modules
cp out/techpack/audio/asoc/codecs/wcd_core_dlkm.ko out/gen_modules
cp out/techpack/audio/asoc/codecs/wsa883x/wsa883x_dlkm.ko out/gen_modules
cp out/techpack/audio/asoc/machine_dlkm.ko out/gen_modules
cp out/techpack/audio/asoc/platform_dlkm.ko out/gen_modules
cp out/techpack/audio/dsp/adsp_loader_dlkm.ko out/gen_modules
cp out/techpack/audio/dsp/codecs/native_dlkm.ko out/gen_modules
cp out/techpack/audio/dsp/q6_dlkm.ko out/gen_modules
cp out/techpack/audio/dsp/q6_notifier_dlkm.ko out/gen_modules
cp out/techpack/audio/dsp/q6_pdr_dlkm.ko out/gen_modules
cp out/techpack/audio/ipc/apr_dlkm.ko out/gen_modules
cp out/techpack/audio/soc/pinctrl_lpi_dlkm.ko out/gen_modules
cp out/techpack/audio/soc/pinctrl_wcd_dlkm.ko out/gen_modules
cp out/techpack/audio/soc/snd_event_dlkm.ko out/gen_modules
cp out/techpack/audio/soc/swr_ctrl_dlkm.ko out/gen_modules
cp out/techpack/audio/soc/swr_dlkm.ko out/gen_modules
cp out/techpack/camera/drivers/camera.ko out/gen_modules
cp out/techpack/datarmnet-ext/offload/rmnet_offload.ko out/gen_modules
cp out/techpack/datarmnet-ext/shs/rmnet_shs.ko out/gen_modules
cp out/techpack/datarmnet/core/rmnet_core.ko out/gen_modules
cp out/techpack/datarmnet/core/rmnet_ctl.ko out/gen_modules
cp out/techpack/display/msm/msm_drm.ko out/gen_modules

echo ''
echo 'Done !'
echo ''
