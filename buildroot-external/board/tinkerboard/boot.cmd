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
fdt addr ${fdt_addr} && fdt get value bootargs /chosen bootargs
setenv bootargs "${bootargs} root=PARTUUID=deedbeef-${bootpart}"
ext4load ${devtype} ${devnum}:${bootpart} ${kernel_addr_r} zImage
bootz ${kernel_addr_r} - ${fdt_addr};
