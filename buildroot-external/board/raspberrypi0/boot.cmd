# test GPIO12 to be 0 (button pressed) to start recovery system
gpio input GPIO12
if test $? -eq 0; then
  echo "==== STARTING RECOVERY SYSTEM ===="
  setenv partuuid "deedbeef-02"
else
  echo "==== NORMAL BOOT ===="
  setenv partuuid "deedbeef-03"
fi

# modify bootargs, load kernel and boot it
fdt addr ${fdt_addr} && fdt get value bootargs /chosen bootargs
setenv bootargs "${bootargs} root=PARTUUID=${partuuid}"
fatload mmc ${devnum} ${kernel_addr_r} zImage
bootz ${kernel_addr_r} - ${fdt_addr};
