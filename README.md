# Hackintosh

This repository contains my EFI folders and bootloaders configurations to boot macOS on my computers.

# Models

## MSI Z97 Gaming 5

### Specifications :

- Motherboard : MSI Z97 Gaming 5
- CPU : i5-4690k
- GPU : Intel HD Graphics 4600

### Bios settings :

`Settings > Advanced > Integrated Graphics Configuration`

- Set `Initiate Graphic Adapter` to `IGD`
- Set `Integrated Graphics Shared Memory` to `64M`

`OC > CPU Features`

- Set `Intel VT-D Tech` to `Disabled`
- Set `CFG Lock` to `Disabled`

## Asus VivoBook 15 X510UF

### Specifications :

- CPU : i7-8550U
- GPU : Intel HD Graphics 620

# Credits

- [OpenCore Bootloader](https://github.com/acidanthera/OpenCorePkg)
- [Clover Bootloader](https://github.com/CloverHackyColor/CloverBootloader)
- [acidanthera](https://github.com/acidanthera) for OpenCore & Kexts
- [tctien342](https://github.com/tctien342/Asus-Vivobook-S510UA-Hackintosh) for Asus Patches & Kexts