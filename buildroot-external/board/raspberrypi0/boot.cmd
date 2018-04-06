# modify bootargs, load kernel and boot it
# fallback defaults
setenv load_addr ${ramdisk_addr_r}
setenv console "tty2"
setenv loglevel "0"
setenv bootfs 1
setenv rootfs 2
setenv userfs 3
setenv gpio_button "GPIO24"
setenv kernel_img "zImage"
setenv recoveryfs_initrd "recoveryfs-initrd"

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
  # load the initrd file
  load ${devtype} ${devnum}:${bootfs} ${load_addr} ${recoveryfs_initrd}
  setenv rootfs_str "/dev/ram0"
  setenv initrd_addr_r ${ramdisk_addr_r}
  setenv kernel_img "recoveryfs-zImage"
  setenv kernelfs ${bootfs}
else
  echo "==== NORMAL BOOT ===="
  # get partuuid of root_num
  part uuid ${devtype} ${devnum}:${rootfs} partuuid
  setenv rootfs_str "PARTUUID=${partuuid}"
  setenv initrd_addr_r "-"
  setenv kernelfs ${rootfs}
fi

# load devicetree
fdt addr ${fdt_addr}
fdt get value bootargs /chosen bootargs

# set bootargs
setenv bootargs "dwc_otg.lpm_enable=0 console=${console} kgdboc=${console} scandelay=5 root=${rootfs_str} ro noswap rootfstype=ext4 elevator=deadline fsck.repair=yes lapic rootwait rootdelay=5 consoleblank=0 logo.nologo loglevel=${loglevel} quiet usb-storage.quirks=${usbstoragequirks} ${extraargs} ${bootargs}"

# load kernel
load ${devtype} ${devnum}:${kernelfs} ${kernel_addr_r} ${kernel_img}

# boot kernel
bootz ${kernel_addr_r} ${initrd_addr_r} ${fdt_addr}
