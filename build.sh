#!/bin/bash

# Set toolchains directory
TOP=$(realpath ../)

# Set Architecture and Config
KERNEL_ARCH=arm64
ARCH=${KERNEL_ARCH}
DEFCONFIG='vendor/lahaina-qgki_defconfig'

# Cross Compile Flags
CLANG_TRIPLE=aarch64-linux-gnu-
CROSS_COMPILE=aarch64-linux-android-
CROSS_COMPILE_COMPAT=arm-linux-androideabi-

# Set tools path
CLANG_PATH="${TOP}/tools/clang/host/linux-x86/clang-r428724/bin"

# Export aosp gcc toolchains path
export PATH="$TOP/tools/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin:$PATH"
export PATH="$TOP/tools/gcc/linux-x86/arm/arm-linux-androideabi-4.9/bin:$PATH"
export PATH="$CLANG_PATH:$PATH"
export LD_LIBRARY_PATH="$TOP/tools/clang/host/linux-x86/clang-r428724/lib64:$LD_LIBRARY_PATH"

# Set tools path
TARGET_KERNEL_MAKE_ENV+="HOSTCC=${CLANG_PATH}/clang "
TARGET_KERNEL_MAKE_ENV+="HOSTCXX=${CLANG_PATH}/clang++ "
TARGET_KERNEL_MAKE_ENV+="HOSTLD=${CLANG_PATH}/ld.lld "
TARGET_KERNEL_MAKE_ENV+="CC=${CLANG_PATH}/clang "
TARGET_KERNEL_MAKE_ENV+="LLVM=${CLANG_PATH}/clang "
TARGET_KERNEL_MAKE_ENV+="LD=${CLANG_PATH}/ld.lld "
TARGET_KERNEL_MAKE_ENV+="AR=${CLANG_PATH}/llvm-ar "
TARGET_KERNEL_MAKE_ENV+="NM=${CLANG_PATH}/llvm-nm "
TARGET_KERNEL_MAKE_ENV+="OBJCOPY=${CLANG_PATH}/llvm-objcopy "
TARGET_KERNEL_MAKE_ENV+="OBJDUMP=${CLANG_PATH}/llvm-objdump "
TARGET_KERNEL_MAKE_ENV+="OBJSIZE=${CLANG_PATH}/llvm-size "
TARGET_KERNEL_MAKE_ENV+="READELF=${CLANG_PATH}/llvm-readelf "
TARGET_KERNEL_MAKE_ENV+="STRIP=${CLANG_PATH}/llvm-strip "

# Function to execute make command
make_kernel() {
    make O=out ${TARGET_KERNEL_MAKE_ENV} ARCH=${ARCH} CROSS_COMPILE=${CROSS_COMPILE} CROSS_COMPILE_COMPAT=${CROSS_COMPILE_COMPAT} CLANG_TRIPLE=${CLANG_TRIPLE} $@
    if [ $? -ne 0 ]; then
        echo "Error: make command failed"
        exit 1
    fi
}

# Make instructions
make_kernel ${DEFCONFIG}
make_kernel -j12

# Function to copy kernel modules
copy_files() {
    rm -rf out/gen_modules
    mkdir out/gen_modules

    FILES=(
        "drivers/bluetooth/bt_fm_slim.ko"
        "drivers/bluetooth/btpower.ko"
        "drivers/char/rdbg.ko"
        "drivers/edac/qcom_edac.ko"
        "drivers/hid/hid-aksys.ko"
        "drivers/input/uff_fp_drivers/uff_fp_driver.ko"
        "drivers/media/radio/rtc6226/radio-i2c-rtc6226-qca.ko"
        "drivers/media/tuners/e4000.ko"
        "drivers/media/tuners/fc0011.ko"
        "drivers/media/tuners/fc0012.ko"
        "drivers/media/tuners/fc0013.ko"
        "drivers/media/tuners/fc2580.ko"
        "drivers/media/tuners/it913x.ko"
        "drivers/media/tuners/m88rs6000t.ko"
        "drivers/media/tuners/max2165.ko"
        "drivers/media/tuners/mc44s803.ko"
        "drivers/media/tuners/msi001.ko"
        "drivers/media/tuners/mt2060.ko"
        "drivers/media/tuners/mt2063.ko"
        "drivers/media/tuners/mt20xx.ko"
        "drivers/media/tuners/mt2131.ko"
        "drivers/media/tuners/mt2266.ko"
        "drivers/media/tuners/mxl301rf.ko"
        "drivers/media/tuners/mxl5005s.ko"
        "drivers/media/tuners/mxl5007t.ko"
        "drivers/media/tuners/qm1d1b0004.ko"
        "drivers/media/tuners/qm1d1c0042.ko"
        "drivers/media/tuners/qt1010.ko"
        "drivers/media/tuners/r820t.ko"
        "drivers/media/tuners/si2157.ko"
        "drivers/media/tuners/tda18212.ko"
        "drivers/media/tuners/tda18218.ko"
        "drivers/media/tuners/tda18250.ko"
        "drivers/media/tuners/tda9887.ko"
        "drivers/media/tuners/tea5761.ko"
        "drivers/media/tuners/tea5767.ko"
        "drivers/media/tuners/tua9001.ko"
        "drivers/media/tuners/tuner-simple.ko"
        "drivers/media/tuners/tuner-types.ko"
        "drivers/media/tuners/tuner-xc2028.ko"
        "drivers/media/tuners/xc4000.ko"
        "drivers/media/tuners/xc5000.ko"
        "drivers/misc/aw8697_haptic/aw8697.ko"
        "drivers/misc/aw8697_haptic/haptic.ko"
        "drivers/misc/aw8697_haptic/haptic_feedback.ko"
        "drivers/slimbus/slimbus-ngd.ko"
        "drivers/slimbus/slimbus.ko"
        "drivers/soc/oplus/explorer/explorer.ko"
        "drivers/soc/oplus/oplus_consumer_ir/oplus_bsp_ir_core.ko"
        "drivers/soc/oplus/oplus_consumer_ir/oplus_bsp_kookong_ir_spi.ko"
        "drivers/soc/oplus/system/last_boot_reason/last_boot_reason.ko"
        "drivers/soc/oplus/thermal/horae_shell_temp.ko"
        "drivers/soc/qcom/llcc_perfmon.ko"
        "drivers/staging/qcacld-3.0/wlan.ko"
        "net/oplus_connectivity_routerboost/oplus_connectivity_routerboost.ko"
        "techpack/audio/asoc/codecs/aw882xx/aw882xx_dlkm.ko"
        "techpack/audio/asoc/codecs/bolero/bolero_cdc_dlkm.ko"
        "techpack/audio/asoc/codecs/bolero/rx_macro_dlkm.ko"
        "techpack/audio/asoc/codecs/bolero/tx_macro_dlkm.ko"
        "techpack/audio/asoc/codecs/bolero/va_macro_dlkm.ko"
        "techpack/audio/asoc/codecs/bolero/wsa_macro_dlkm.ko"
        "techpack/audio/asoc/codecs/hdmi_dlkm.ko"
        "techpack/audio/asoc/codecs/mbhc_dlkm.ko"
        "techpack/audio/asoc/codecs/sia81xx/sia81xx_dlkm.ko"
        "techpack/audio/asoc/codecs/stub_dlkm.ko"
        "techpack/audio/asoc/codecs/swr_dmic_dlkm.ko"
        "techpack/audio/asoc/codecs/swr_haptics_dlkm.ko"
        "techpack/audio/asoc/codecs/tfa98xx-v6/tfa98xx-v6_dlkm.ko"
        "techpack/audio/asoc/codecs/wcd937x/wcd937x_dlkm.ko"
        "techpack/audio/asoc/codecs/wcd937x/wcd937x_slave_dlkm.ko"
        "techpack/audio/asoc/codecs/wcd938x/wcd938x_dlkm.ko"
        "techpack/audio/asoc/codecs/wcd938x/wcd938x_slave_dlkm.ko"
        "techpack/audio/asoc/codecs/wcd9xxx_dlkm.ko"
        "techpack/audio/asoc/codecs/wcd_core_dlkm.ko"
        "techpack/audio/asoc/codecs/wsa883x/wsa883x_dlkm.ko"
        "techpack/audio/asoc/machine_dlkm.ko"
        "techpack/audio/asoc/platform_dlkm.ko"
        "techpack/audio/dsp/adsp_loader_dlkm.ko"
        "techpack/audio/dsp/codecs/native_dlkm.ko"
        "techpack/audio/dsp/q6_dlkm.ko"
        "techpack/audio/dsp/q6_notifier_dlkm.ko"
        "techpack/audio/dsp/q6_pdr_dlkm.ko"
        "techpack/audio/ipc/apr_dlkm.ko"
        "techpack/audio/soc/pinctrl_lpi_dlkm.ko"
        "techpack/audio/soc/pinctrl_wcd_dlkm.ko"
        "techpack/audio/soc/snd_event_dlkm.ko"
        "techpack/audio/soc/swr_ctrl_dlkm.ko"
        "techpack/audio/soc/swr_dlkm.ko"
        "techpack/camera/drivers/camera.ko"
        "techpack/datarmnet-ext/offload/rmnet_offload.ko"
        "techpack/datarmnet-ext/shs/rmnet_shs.ko"
        "techpack/datarmnet/core/rmnet_core.ko"
        "techpack/datarmnet/core/rmnet_ctl.ko"
        "techpack/display/msm/msm_drm.ko"
    )

    for FILE in "${FILES[@]}"; do
        if [ -f "out/${FILE}" ]; then
            cp "out/${FILE}" out/gen_modules
        else
            echo "'${FILE}' does not exist. Skipping."
        fi
    done
    mv out/gen_modules/wlan.ko out/gen_modules/qca_cld3_wlan.ko
    rm -rf out/gen_modules/wlan.ko
}

# Function to create dtb.img
create_dtb_img() {
    DIST_DIR=out/gen_dtb
    rm -rf ${DIST_DIR}
    mkdir -p ${DIST_DIR}
    cp out/arch/arm64/boot/dts/vendor/oplus/lunaa/*.dtb ${DIST_DIR}
    cp out/arch/arm64/boot/dts/vendor/qcom/*.dtb ${DIST_DIR}
    DTB_FILE_LIST=$(find ${DIST_DIR} -name "*.dtb" | sort)
    cat $DTB_FILE_LIST > out/arch/arm64/boot/dtb.img
}

# Check if 'arch/arm64/boot/Image' exists
if [ -f "out/arch/arm64/boot/Image" ]; then
    echo "Kernel build successful! "
    echo "Proceeding with copying modules."
    copy_files
    echo "Proceeding with generating dtb.img"
    create_dtb_img
    echo ''
    echo 'Done!'
    echo ''
else
    echo "Kernel build failed! Skipping copying modules."
fi
