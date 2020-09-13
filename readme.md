# Samsung M30 SM-M305F/M Kernel Source

Kernel Source 4.4.177 for the Samsung Galaxy M30

---
![Samsung Galaxy M30](https://fdn2.gsmarena.com/vv/pics/samsung/samsung-galaxy-m30-sm-m305f-1.jpg)


# About Device

Samsung Galaxy M30 (m30lte)

### Specifications

Basic   | Spec Sheet
-------:|:-------------------------
CPU     | Octa-core 2x1.8GHz A73 + 6x1.6Ghz A53, ARM HMP big.LITTLE GTS
Chipset | Samsung Exynos 7904
GPU     | ARM Mali G71 MP2
Memory  | 3 GB / 4 GB / 6 GB
Shipped Android Version | 8.1.0
Updated Android Version | 10.0
Storage | 32 GB / 64GB / 128GB
MicroSD | Up to 64 GB
Battery | 5000 mAh (non-removable)
Dimensions | 159 x 75.1 x 8.5 mm
Display | 1080 x 2340 pixels, 6.4" Super AMOLED
Rear Camera  | 13.0 MP, 5 MP, 5 MP LED flash
Front Camera | 16.0 MP

---

#  Steps to Compile

Get the GCC toolchain 4.9

Then add a build script
example:
```sh
export ANDROID_MAJOR_VERSION=q
export ARCH=arm64
export CROSS_COMPILE=path_to_toolchain_executables
make clean && make mrproper
make m30lte_00_defconfig
make j#
```
'#'=no of CPU threads your CPU has.
```sh
./build_script_name.sh
```
### Thanks to:
 * myself, akhil1999
 * Samsung for providing kernel source
