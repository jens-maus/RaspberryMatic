# modify bootargs, load kernel and boot it
# fallback defaults
setenv load_addr ${ramdisk_addr_r}
setenv console "tty2"
setenv loglevel "0"
setenv bootfs 1
setenv recoveryfs 2
setenv rootfs 3
setenv userfs 4
setenv gpio_button "GPIO12"
setenv kernel_img "zImage"

# output where we are booting from
itest.b ${devnum} == 0 && echo "U-boot loaded from SD"
itest.b ${devnum} == 1 && echo "U-boot loaded from eMMC"

# import environment from /boot/bootEnv.txt
if test -e ${devtype} ${devnum}:${bootfs} bootEnv.txt; then
  load ${devtype} ${devnum}:${bootfs} ${load_addr} bootEnv.txt
  env import -t ${load_addr} ${filesize}
fi

# test if the gpio button is 0 (pressed) or if .recoveryMode exists in userfs
# or if zImage doesn't exist in the root partition
gpio input ${gpio_button}
if test $? -eq 0 -o -e ${devtype} ${devnum}:${userfs} /.recoveryMode -o ! -e ${devtype} ${devnum}:${rootfs} ${kernel_img}; then
  echo "==== STARTING RECOVERY SYSTEM ===="
  setenv root_num ${recoveryfs}
else
  echo "==== NORMAL BOOT ===="
  setenv root_num ${rootfs}
fi

# get partuuid of root_num
part uuid ${devtype} ${devnum}:${root_num} partuuid

# load devicetree
fdt addr ${fdt_addr}
fdt get value bootargs /chosen bootargs

# set bootargs
setenv bootargs "dwc_otg.lpm_enable=0 console=${console} kgdboc=${console} scandelay=5 root=PARTUUID=${partuuid} ro noswap rootfstype=ext4 elevator=deadline fsck.repair=yes lapic rootwait rootdelay=5 consoleblank=0 logo.nologo loglevel=${loglevel} quiet usb-storage.quirks=${usbstoragequirks} ${extraargs} ${bootargs}"

# load kernel
ext4load ${devtype} ${devnum}:${root_num} ${kernel_addr_r} ${kernel_img}

# boot kernel
bootz ${kernel_addr_r} - ${fdt_addr}
