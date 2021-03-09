#/bin/bash

KERNEL_VERSION=`uname -s -r -v`

BIOS_VENDOR=`sudo dmidecode -s bios-vendor`
BIOS_VERSION=`sudo dmidecode -s bios-version`
BIOS_RELEASE_DATE=`sudo dmidecode -s bios-release-date`
SYSTEM_MANUFACTURER=`sudo dmidecode -s system-manufacturer`
SYSTEM_PRODUCT=`sudo dmidecode -s system-product-name`
SYSTEM_VERSION=`sudo dmidecode -s system-version`
SYSTEM_SERIAL=`sudo dmidecode -s system-serial-number`
SYSTEM_UUID=`sudo dmidecode -s system-uuid`
BASEBOARD_MANUFACTURER=`sudo dmidecode -s baseboard-manufacturer`
BASEBOARD_PRODUCT_NAME=`sudo dmidecode -s baseboard-product-name`
BASEBOARD_VERSION=`sudo dmidecode -s baseboard-version`
BASEBOARD_SERIAL=`sudo dmidecode -s baseboard-serial-number`
BASEBOARD_ASSET_TAG=`sudo dmidecode -s baseboard-asset-tag`
CHASSIS_MANUFACTURER=`sudo dmidecode -s chassis-manufacturer`
CHASSIS_TYPE=`sudo dmidecode -s chassis-type`
CHASSIS_VERSION=`sudo dmidecode -s chassis-version`
CHASSIS_SERIAL=`sudo dmidecode -s chassis-serial-number`
CHASSIS_ASSET_TAG=`sudo dmidecode -s chassis-asset-tag`
CPU_VERSION=`sudo dmidecode -s processor-version`
CPU_ARCH=`uname -i`
VIRTUAL_CPU_COUNT=`lscpu | grep "CPU(s)" -m 1 | tr -d " " | cut -d ":" -f 2`
CPU_VIRTUALIZATION=`lscpu | grep "Virtualization" | tr -d " " | cut -d ":" -f 2`
CPU_THREAD_COUNT=`lscpu | grep "Thread(s)" | tr -d " " | cut -d ":" -f 2`
CPU_SOCKETS=`lscpu | grep "Socket(s)" | tr -d " " | cut -d ":" -f 2`
CORES_PER_CPU=`lscpu | grep "Core(s)" | tr -d " " | cut -d ":" -f 2`
CPU_L3_CACHE_SIZE=`lscpu | grep "L3" | tr -d " " | cut -d ":" -f 2`
RAM_MAX_CAPACITY_RAW=`sudo dmidecode | grep "Maximum Capacity:"`
BATTERY_INFO=`acpi -i | grep capacity`
PARTITION_INFO=`df -h | grep "/dev/" | tr -s " " | cut -d " " -f 1,2,6 | sort`
USB_DEVICES=`lsusb | grep -vi hub | cut -b 21-`
GRAPHIC_CARD=`lspci | grep VGA | cut -d ":" -f 3 | cut -b 2-`
NETWORK_CARDS=`lspci | grep Network | cut -d ":" -f 3 | cut -b 2- | tr '\n'  ';'`
MAX_RAM_SIZE=`sudo dmidecode | grep "Maximum Capacity" | tr -d ' ' | cut -d ':' -f2`
RAM_SIZE=`sudo dmidecode -t memory | grep Size | grep -v "No" | cut -d ':' -f 2 | cut -d ' ' -f 2 | awk '{s+=$1} END {print s / 1024}'`
RAM_SLOTS=`sudo dmidecode -t memory | grep Devices | tr -d ' ' | cut -d ':' -f2`
RAM_SERIAL_NUMBERS=`sudo dmidecode -t memory | grep "Serial" | tr -d " " | cut -d ":" -f 2 | tr -s '\n' '\t'`
RAM_TYPES=`sudo dmidecode -t memory | grep "Part" | tr -d " " | cut -d ":" -f 2 | tr -s '\n' '\t'`
RAM_BUILTIN_SPEED=`sudo dmidecode -t memory | grep Speed | grep -v Config | tr -d ' ' | cut -d ':' -f 2 | tr -s '\n' '\t'`
RAM_CONFIGURED_SPEED=`sudo dmidecode -t memory | grep Speed | grep Config | tr -d ' ' | cut -d ':' -f 2 | tr -s '\n' '\t'`
COMPUTER_PORTS_INTERNAL=`sudo dmidecode -t connector | grep "Internal Reference Designator" | grep -v Not | cut -d ":" -f 2 | cut -b 2- | tr -s '\n' ';'`
COMPUTER_PORTS_EXTERNAL=`sudo dmidecode -t connector | grep "External Reference Designator" | grep -v Not | cut -d ":" -f 2 | cut -b 2- | tr -s '\n' ';'`
KERNEL_VERSION=`uname -rp`
DISTRIBUTION_VERSION=`cat /etc/lsb-release | grep DESCRIPTION | cut -d "=" -f 2 | tr -d '"'`
STORAGE_INFO=$(smartctl --scan | sudo smartctl -i `cut -d' ' -f 1`)

echo "----------- BIOS --------------"
echo "BIOS vendor  : $BIOS_VENDOR"
echo "BIOS version : $BIOS_VERSION"
echo "BIOS date    : $BIOS_RELEASE_DATE"
echo "---------- SYSTEM -------------"
echo "SYS manufacturer: $SYSTEM_MANUFACTURER"
echo "SYS product name: $SYSTEM_PRODUCT"
echo "SYS version     : $SYSTEM_VERSION"
echo "SYS serial      : $SYSTEM_SERIAL"
echo "SYS UUID        : $SYSTEM_UUID"
echo "---------- BOARD -------------"
echo "Board manufacturer: $BASEBOARD_MANUFACTURER"
echo "Board product name: $BASEBOARD_PRODUCT_NAME"
echo "Board version     : $BASEBOARD_VERSION"
echo "Board serial      : $BASEBOARD_SERIAL"
echo "Board asset tag   : $BASEBOARD_ASSET_TAG"
echo "---------- CHASSIS -----------"
echo "Chassis manufacturer: $CHASSIS_MANUFACTURER"
echo "Chassis type        : $CHASSIS_TYPE"
echo "Chassis version     : $CHASSIS_VERSION"
echo "Chassis serial      : $CHASSIS_SERIAL"
echo "Chassis asset tag   : $CHASSIS_ASSET_TAG"
echo "---------- CPU ---------------"
echo "CPU version        : $CPU_VERSION"
echo "CPU architecture   : $CPU_ARCH"
echo "CPU sockets        : $CPU_SOCKETS"
echo "Cores per CPU      : $CORES_PER_CPU"
echo "Threads(HT) on core: $CPU_THREAD_COUNT"
echo "Virtual CPU count  : $VIRTUAL_CPU_COUNT"
echo "CPU virtualization : $CPU_VIRTUALIZATION"
echo "L3 cache size      : $CPU_L3_CACHE_SIZE"
echo "---------- RAM ---------------"
echo "RAM size      : ${RAM_SIZE}GB"
echo "RAM slots     : $RAM_SLOTS"
echo "Max RAM size  : $MAX_RAM_SIZE"
echo "RAM speed     : $RAM_BUILTIN_SPEED"
echo "RAM conf speed: $RAM_CONFIGURED_SPEED"
echo "RAM serials   : $RAM_SERIAL_NUMBERS"
echo "RAM parts     : $RAM_TYPES"
echo "---------- STORAGE -----------"
echo "$STORAGE_INFO"
echo "---------- BATTERY -----------"
echo "Battery info     : $BATTERY_INFO"
echo "---------- PARTITIONS --------"
echo "$PARTITION_INFO"
echo "---------- USB ---------------"
echo "$USB_DEVICES"
echo "---------- MISC -------"
echo "Kernel        : $KERNEL_VERSION"
echo "Distribution  : $DISTRIBUTION_VERSION"
echo "Graphic       : $GRAPHIC_CARD"
echo "Network       : $NETWORK_CARDS"
echo "Internal ports: $COMPUTER_PORTS_INTERNAL"
echo "External ports: $COMPUTER_PORTS_EXTERNAL"
