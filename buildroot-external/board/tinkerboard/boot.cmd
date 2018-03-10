# test GPIO12 to be 0 (button pressed) to start recovery system
gpio input GPIO12
if test $? -eq 0 -o -e ${devtype} ${devnum}:4 /.recoveryMode -o ! -e ${devtype} ${devnum}:3 /zImage; then
  echo "==== STARTING RECOVERY SYSTEM ===="
  setenv bootpart 02
else
  echo "==== NORMAL BOOT ===="
  setenv bootpart 03
fi

# modify bootargs, load kernel and boot it
load ${devtype} ${devnum}:1 ${fdt_addr_r} /rk3288-miniarm.dtb
fdt addr ${fdt_addr_r}
setenv bootargs "console=tty2 root=PARTUUID=deedbeef-${bootpart} ro noswap rootfstype=ext4 elevator=deadline fsck.repair=yes lapic rootwait rootdelay=5 consoleblank=0 logo.nologo loglevel=0 quiet"
ext4load ${devtype} ${devnum}:${bootpart} ${kernel_addr_r} zImage
bootz ${kernel_addr_r} - ${fdt_addr_r};
