echo Compiling

export PATH=$PATH:/usr/local/i386elfgcc/bin

nasm "boot/bootloader.asm" -f bin -o "bin/boot.bin"
nasm "boot/kernel_entry.asm" -f elf -o "bin/kernel_entry.o"
i386-elf-gcc -ffreestanding -m32 -g -c "kernel/kernel.cpp" -o "bin/kernel.o"
i386-elf-gcc -ffreestanding -m32 -g -c "kernel/print.cpp" -o "bin/print.o"
nasm "kernel/zeros.asm" -f bin -o "bin/zeros.bin"

i386-elf-ld -o "bin/full_kernel.bin" -Ttext 0x1000 "bin/kernel_entry.o" "bin/kernel.o" "bin/print.o" --oformat binary

cat "bin/boot.bin" "bin/full_kernel.bin" "bin/zeros.bin"  > "bin/myos.bin"

echo Compiling Succesfull
if grub-file --is-x86-multiboot /home/teer/Schreibtisch/Programming/C/OperatingSystem/src/bin/myos.bin; then
    echo Multiboot Confirmed
else 
    echo this file is not Multiboot
fi

mkdir -p bin/isodir/boot/grub
cp bin/myos.bin bin/isodir/boot/myos.bin
cp bin/grub.cfg bin/isodir/boot/grub/grub.cfg
grub2-mkrescue -o myos.iso bin/isodir

qemu-system-i386 -cdrom myos.iso