# Copier le dossier EFI d'OpenCore
# Copier coller les kexts
# Mettre VBoxHfs.efi dans le dossier Drivers
https://github.com/khronokernel/Getting-Started-With-OpenCore/blob/master/OpenCore%20EFI/iMac17%2C1%20EFI(Skylake)/EFI/OC/Drivers/VBoxHfs.efi
# Mettre SSDT-EC.aml et SSDT-PLUG.aml dans le dossier ACPI https://dortania.github.io/Getting-Started-With-ACPI/Universal/ec-fix.html
# OC Clean Snapshot avec ProperTree
# Utiliser GenSMBIOS et mettre les infos dans PlatformInfo -> Generic
# Uploader sur config.plist et suivre les instructions sur OpenCore Sanity Checker
https://opencore.slowgeek.com/
# Retirer l'argument -v dans NVRAM -> Add -> boot-args
# Compiler et ajouter Spoof-SSDT.aml de Dortania pour désactiver le gpu si sur PCI0