# Pangolin Desktop

The desktop UI for Dahlia OS

## To Use

To run Pangolin, you will need to have Flutter installed in your PATH, and a device or emulator to run it on.

## QEMU (Quick Emulator)

To install Qemu Type: `sudo apt install qemu`

to use qemu: `sudo qemu-system-x86_64 -cdrom (DAHLIA_ISO / IMG)`


##Important Style guide!
All dahlia applications MUST have a central theme color, that is not #ff5722, or material-deeporange or similar, as that is reserved for the system. Uploaders must upload a theme.txt in the root of their application, that contains the theme color, in preferably hexadecimal, but RGBA is acceptable as well. Uncompliant applications will have their theme colors set to a random color.