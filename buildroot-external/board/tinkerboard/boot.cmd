# fallback defaults
setenv fdt_file "rk3288-tinker.dtb"
setenv load_addr "0x21000000"
setenv console "tty2"
setenv loglevel "0"
setenv bootfs 1
setenv rootfs 2
setenv userfs 3
setenv gpio_button "H23" # matches GPIO239
setenv kernel_img "zImage"
setenv recoveryfs_initrd "recoveryfs-initrd"

# output where we are booting from
itest.b ${devnum} == 1 && echo "U-boot loaded from SD"
itest.b ${devnum} == 2 && echo "U-boot loaded from eMMC"

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
  setenv initrd_addr_r ${load_addr}
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
load ${devtype} ${devnum}:${bootfs} ${fdt_addr_r} ${fdt_file}
fdt addr ${fdt_addr_r}

# set bootargs
setenv bootargs "console=${console} kgdboc=${console} scandelay=5 root=${rootfs_str} ro noswap rootfstype=ext4 elevator=deadline fsck.repair=yes lapic rootwait rootdelay=5 consoleblank=120 quiet loglevel=${loglevel} usb-storage.quirks=${usbstoragequirks} ${extraargs} ${bootargs}"

# load kernel
load ${devtype} ${devnum}:${kernelfs} ${kernel_addr_r} ${kernel_img}

# boot kernel
bootz ${kernel_addr_r} ${initrd_addr_r} ${fdt_addr_r}
