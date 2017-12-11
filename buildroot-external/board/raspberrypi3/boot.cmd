# test GPIO6 to be 0 (button pressed) to start recovery system
gpio input GPIO6
if test $? -eq 0; then 
  echo "==== STARTING RECOVERY SYSTEM ===="
else
  echo "==== NORMAL BOOT ===="
  fdt addr ${fdt_addr} && fdt get value bootargs /chosen bootargs
  fatload mmc ${devnum} ${kernel_addr_r} zImage && bootz ${kernel_addr_r} - ${fdt_addr};
fi
