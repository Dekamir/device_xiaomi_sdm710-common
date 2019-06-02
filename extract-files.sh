#!/bin/bash
#
# SPDX-License-Identifier: Apache-2.0
#

set -e

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$MY_DIR" ]]; then MY_DIR="$PWD"; fi

BOOTLEGGERS_ROOT="$MY_DIR"/../../..

HELPER="$BOOTLEGGERS_ROOT"/vendor/bootleg/build/tools/extract_utils.sh
if [ ! -f "$HELPER" ]; then
    echo "Unable to find helper script at $HELPER"
    exit 1
fi
. "$HELPER"

# Default to sanitizing the vendor folder before extraction
CLEAN_VENDOR=true

while [ "$1" != "" ]; do
    case $1 in
        -n | --no-cleanup )     CLEAN_VENDOR=false
                                ;;
        -s | --section )        shift
                                SECTION=$1
                                CLEAN_VENDOR=false
                                ;;
        * )                     SRC=$1
                                ;;
    esac
    shift
done

if [ -z "$SRC" ]; then
    SRC=adb
fi

# Initialize the helper for common device
setup_vendor "$DEVICE_COMMON" "$VENDOR" "$BOOTLEGGERS_ROOT" true "$CLEAN_VENDOR"

extract "$MY_DIR"/proprietary-files.txt "$SRC" "$SECTION"

if [ -s "$MY_DIR"/../$DEVICE/proprietary-files.txt ]; then
    # Reinitialize the helper for device
    setup_vendor "$DEVICE" "$VENDOR" "$BOOTLEGGERS_ROOT" false "$CLEAN_VENDOR"

    extract "$MY_DIR"/../$DEVICE/proprietary-files.txt "$SRC" "$SECTION"
fi

"$MY_DIR"/setup-makefiles.sh

    # Patch libmmcamera2_stats_modules
    vendor/lib/libmmcamera2_stats_modules.so)
        sed -i "s|libgui.so|libfui.so|g" "${2}"
        sed -i "s|/data/misc/camera|/data/vendor/qcam|g" "${2}"
        patchelf --remove-needed libandroid.so "${2}"
        ;;

    # Hex edit camera blobs to use /data/vendor/qcam
   vendor/lib/libmm-qcamera.so | vendor/lib/libmmcamera2_cpp_module.so | vendor/lib/libmmcamera2_iface_modules.so | vendor/lib/libmmcamera2_imglib_modules.so | vendor/lib/libmmcamera2_mct.so | vendor/lib/libmmcamera2_pproc_modules.so | vendor/lib/libmmcamera2_stats_algorithm.so | vendor/lib/libmmcamera_dbg.so | vendor/lib/libmmcamera_hvx_grid_sum.so | vendor/lib/libmmcamera_hvx_zzHDR.so | vendor/lib/libmmcamera_imglib.so | vendor/lib/libmmcamera_isp_mesh_rolloff44.so | vendor/lib/libmmcamera_pdaf.so | vendor/lib/libmmcamera_pdafcamif.so | vendor/lib/libmmcamera_tintless_algo.so | vendor/lib/libmmcamera_tintless_bg_pca_algo.so | vendor/lib/libmmcamera_tuning.so)
        sed -i "s|/data/misc/camera|/data/vendor/qcam|g" "${2}"
        ;;
    vendor/bin/mm-qcamera-daemon)
        sed -i "s|/data/vendor/camera/cam_socket%d|/data/vendor/qcam/camer_socket%d|g" "${2}"
        ;;
