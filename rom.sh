#!/usr/bin/env bash

export TZ="Asia/Kolkata";
export WKDIR="${HOME}/rom"
export ROM="${WKDIR}/out/target/product/santoni/LLuvia* "


git clone https://github.com/akhilnarang/scripts
cd scripts
bash setup/a*b*e*.sh
cd ../
mkdir ~/bin
PATH=~/bin:$PATH
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo
mkdir rom
cd rom
git config —global user.name "Quantummech2000"
git config —global user.email "vvr-rockstar@bmsit.in"
repo init -u https://github.com/LLuviaOS/android_manifest -b 3.0 --depth=1 
printf 'y'
repo sync -c -f --force-sync --no-tags --no-clone-bundle -j$(nproc --all)  >log 2>&1
git clone https://github.com/quantummech2000/android_device_xiaomi_santoni -b lluvia-pie device/xiaomi/santoni
git clone https://github.com/quantummech2000/android_vendor_xiaomi_santoni -b lluvia-pie vendor/xiaomi
git clone https://github.com/quantummech2000/jaguarkernel.git -b version2.0_treble kernel/xiaomi/msm8937
sudo rm -rf hardware/qcom/audio-caf/msm8996 && rm -rf hardware/qcom/display-caf/msm8996 && rm -rf hardware/qcom/media-caf/msm8996
git clone https://github.com/RiteshSaxena/hardware_qcom_display.git -b pie-caf-8996 hardware/qcom/display-caf/msm8996 && git clone https://github.com/RiteshSaxena/hardware_qcom_audio.git -b pie-caf-8996 hardware/qcom/audio-caf/msm8996 && git clone https://github.com/RiteshSaxena/hardware_qcom_media -b pie-caf-8996 hardware/qcom/media-caf/msm8996
. b*/e*
export USE_CCACHE=1
prebuilts/misc/linux-x86/ccache/ccache -M 50G
export CCACHE_COMPRESS=1
brunch santoni

if [[ ! -f "${IMAGE}" ]]; then
    echo -e "Build failed :P";
    curl -s -X POST https://api.telegram.org/bot$BOT_API_KEY/sendMessage -d text="CI build for LLUVIA ROM stopped due to an error" -d chat_id=$CHAT_ID
    curl -s -X POST https://api.telegram.org/bot$BOT_API_KEY/sendSticker -d sticker="CAADBQADHwADx8M3DyJi1SWaX6BdAg"  -d chat_id=$CHAT_ID
    success=false;
    exit 1;
else
    echo -e "Build Succesful!";
    success=true;
fi
function transfer() {
	zipname="${ROM}";
	url="$(curl -# -T ${ROM} https://transfer.sh)";
	printf '\n';
	echo -e "Download ${zipname} at ${url} ";
    curl -s -X POST https://api.telegram.org/bot$BOT_API_KEY/sendMessage -d text="$url" -d chat_id=$CHAT_ID
}
if [[ ${success} == true ]]; then
    echo -e "Uploading ${ZIPNAME} to https://transfer.sh/";
    transfer "${FINAL_ZIP}";
