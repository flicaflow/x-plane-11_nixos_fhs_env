# NixOS X-Plane 11 FHS environment

X-Plane 11 does not run ntively on NixOS. To get it working we have to create a FHS complinet environment with all required dependencies.

## How does it work

1. Checkout this repo and enter the directory
2. Enter the FHS environment by running `nix develop`
3. Run `x-plane-11` this will start the installer and later the the program itself

