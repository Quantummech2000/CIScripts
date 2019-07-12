apt update 
apt upgrade -y 
apt install ccache bc libncurses5-dev git-core gnupg flex bison gperf build-essential zip curl libc6-dev ncurses-dev 
export BOT_API_KEY="673621974:AAGAEzCHFNn7e0KyGJVyJg01HBn29aWwKiw"
cd
export CHAT_ID="585730571"
export ARCH=arm64
export KERNELDIR=$HOME/WolfKernel
export KERNELNAME=Wolf
git clone https://github.com/quantummech2000/WolfKernel -b v1.9 WolfKernel
wget https://releases.linaro.org/components/toolchain/binaries/latest-7/aarch64-linux-gnu/gcc-linaro-7.4.1-2019.02-x86_64_aarch64-linux-gnu.tar.xz
tar -xvf  gcc-linaro-7.4.1-2019.02-x86_64_aarch64-linux-gnu.tar.xz
git clone https://github.com/VRanger/dragontc.git clang
cd WolfKernel
bash wolf.sh
