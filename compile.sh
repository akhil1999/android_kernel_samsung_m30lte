clear
echo ░█████╗░██╗░░░██╗░██████╗████████╗░█████╗░███╗░░░███╗  ██╗░░██╗███████╗██████╗░███╗░░██╗███████╗██╗░░░░░
echo ██╔══██╗██║░░░██║██╔════╝╚══██╔══╝██╔══██╗████╗░████║  ██║░██╔╝██╔════╝██╔══██╗████╗░██║██╔════╝██║░░░░░
echo ██║░░╚═╝██║░░░██║╚█████╗░░░░██║░░░██║░░██║██╔████╔██║  █████═╝░█████╗░░██████╔╝██╔██╗██║█████╗░░██║░░░░░
echo ██║░░██╗██║░░░██║░╚═══██╗░░░██║░░░██║░░██║██║╚██╔╝██║  ██╔═██╗░██╔══╝░░██╔══██╗██║╚████║██╔══╝░░██║░░░░░
echo ╚█████╔╝╚██████╔╝██████╔╝░░░██║░░░╚█████╔╝██║░╚═╝░██║  ██║░╚██╗███████╗██║░░██║██║░╚███║███████╗███████╗
echo ░╚════╝░░╚═════╝░╚═════╝░░░░╚═╝░░░░╚════╝░╚═╝░░░░░╚═╝  ╚═╝░░╚═╝╚══════╝╚═╝░░╚═╝╚═╝░░╚══╝╚══════╝╚══════╝

echo ██████╗░██╗░░░██╗██╗██╗░░░░░██████╗░░██████╗░█████╗░██████╗░██╗██████╗░████████╗
echo ██╔══██╗██║░░░██║██║██║░░░░░██╔══██╗██╔════╝██╔══██╗██╔══██╗██║██╔══██╗╚══██╔══╝
echo ██████╦╝██║░░░██║██║██║░░░░░██║░░██║╚█████╗░██║░░╚═╝██████╔╝██║██████╔╝░░░██║░░░
echo ██╔══██╗██║░░░██║██║██║░░░░░██║░░██║░╚═══██╗██║░░██╗██╔══██╗██║██╔═══╝░░░░██║░░░
echo ██████╦╝╚██████╔╝██║███████╗██████╔╝██████╔╝╚█████╔╝██║░░██║██║██║░░░░░░░░██║░░░ █▄▄ █▄█   █▀▀ █░█ ▄▀█ █▀█ █▀ █▀▀ █░░ █▀█ █░█░█ █▄░█
echo ╚═════╝░░╚═════╝░╚═╝╚══════╝╚═════╝░╚═════╝░░╚════╝░╚═╝░░╚═╝╚═╝╚═╝░░░░░░░░╚═╝░░░ █▄█ ░█░   █▄▄ █▀█ █▀█ █▄█ ▄█ █▄▄ █▄▄ █▄█ ▀▄▀▄▀ █░▀█
echo " "
echo "Cleaning up old files..."
echo " "
cd AIK-Linux/
rm dtb.img
rm Image
./cleanup.sh
cd ..
echo " "
echo "Build Kernel?"
read -p "y/n?:" choice0
if [ $choice0 == y ]
then
echo " "
echo "Building Kernel..."
export ANDROID_MAJOR_VERSION=q
export arch=arm64
export CROSS_COMPILE=$(pwd)/toolchain/aarch64-linux-android-4.9/bin/aarch64-linux-android-
# make m30lte_00_defconfig 
make m30lte_00_defconfig
make -j8 LOCALVERSION="-TurboKernel-M30-v1"
echo " "
echo "Making boot image..."
echo " "
#copy compiled zImage and dtb image to AIK directory hehe
echo "Copying built zImage and DTB Image for packing..."
echo " "
cp /home/akhilesh/m30/android_kernel_samsung_m30lte/arch/arm64/boot/Image AIK-Linux/Image
cp /home/akhilesh/m30/android_kernel_samsung_m30lte/arch/arm64/boot/dtb.img AIK-Linux/dtb.img
cd AIK-Linux
echo "Unpacking reference boot image"
echo " "
./unpackimg.sh >/dev/null #Unpack Scaffold Boot IMG 
cp Image split_img/Image
cp dtb.img split_img/dtb.img
cd split_img/
rm boot.img-zImage
rm boot.img-dt
echo " "
echo "Copied newly compiled images"
echo " "
mv dtb.img boot.img-dt
mv Image boot.img-zImage
cd ..
echo "Repacking boot image"
echo " "
./repackimg.sh >/dev/null
mv image-new.img boot_new.img
cd ..
echo " "
echo " "
echo "Finding device..."
echo " "
echo "Flashing boot image to device..."
echo " "
adb devices >/dev/null
adb reboot recovery
sleep 40s
adb push /home/akhilesh/m30/android_kernel_samsung_m30lte/AIK-Linux/boot_new.img /external_sd/boot.img
echo " "
echo "using dd method..."
echo " "
adb shell "
dd if=/external_sd/boot.img of=/dev/block/platform/13500000.dwmmc0/by-name/BOOT
exit
"
adb reboot 
echo " "
echo "Finished flashing boot image"
else
   echo " "
   echo "Terminating build script..."
   echo "Have a nice day!"
   echo " "
fi
