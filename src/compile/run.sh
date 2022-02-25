
  
export PATH=$PATH:/usr/local/i386elfgcc/bin

nasm "/home/teer/Schreibtisch/Programming/C/OperatingSystem/src/boot/bootloader.asm" -f bin -o "/home/teer/Schreibtisch/Programming/C/OperatingSystem/src/bin/boot.bin"
nasm "/home/teer/Schreibtisch/Programming/C/OperatingSystem/src/boot/kernel_entry.asm" -f elf -o "/home/teer/Schreibtisch/Programming/C/OperatingSystem/src/bin/kernel_entry.o"
i386-elf-gcc -ffreestanding -m32 -g -c "/home/teer/Schreibtisch/Programming/C/OperatingSystem/src/kernel/kernel.cpp" -o "/home/teer/Schreibtisch/Programming/C/OperatingSystem/src/bin/kernel.o"
nasm "/home/teer/Schreibtisch/Programming/C/OperatingSystem/src/kernel/zeros.asm" -f bin -o "/home/teer/Schreibtisch/Programming/C/OperatingSystem/src/bin/zeros.bin"

i386-elf-ld -o "/home/teer/Schreibtisch/Programming/C/OperatingSystem/src/bin/full_kernel.bin" -Ttext 0x1000 "/home/teer/Schreibtisch/Programming/C/OperatingSystem/src/bin/kernel_entry.o" "/home/teer/Schreibtisch/Programming/C/OperatingSystem/src/bin/kernel.o" --oformat binary

cat "/home/teer/Schreibtisch/Programming/C/OperatingSystem/src/bin/boot.bin" "/home/teer/Schreibtisch/Programming/C/OperatingSystem/src/bin/full_kernel.bin" "/home/teer/Schreibtisch/Programming/C/OperatingSystem/src/bin/zeros.bin"  > "/home/teer/Schreibtisch/Programming/C/OperatingSystem/src/bin/Thon.bin"

qemu-system-x86_64 -drive format=raw,file="/home/teer/Schreibtisch/Programming/C/OperatingSystem/src/bin/Thon.bin",index=0,if=floppy,  -m 128M