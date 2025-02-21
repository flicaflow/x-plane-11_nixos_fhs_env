{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: 
   let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      x-plane-11 = pkgs.stdenv.mkDerivation {
        pname = "X-Plane 11";
        version = "1";

         src = pkgs.fetchzip {
           # Internet Archive should be more reliable
           url = "https://www.x-plane.com/update/installers11/X-Plane11InstallerLinux.zip";
           sha256 = "sha256-s2RKZ14Ki+G6ZdC4t/JHecT6GBZdyzNKlFIcTFoDP3Y=";
         };

         installPhase = ''
           mkdir -p $out/bin
           install -m755 -D "X-Plane 11 Installer Linux" $out/bin/x-plane-11
         '';

      };
      fhs = pkgs.buildFHSEnv {
        name = "X-Plane 11";
        targetPkgs = pkgs: with pkgs; [
          x-plane-11
          libGL
          libGLU
          xorg.libX11
          xorg.libXcursor
          xorg.libXrandr
          xorg.libXext
          xorg.libXinerama
          glib
          at-spi2-atk
          gdk-pixbuf
          cairo
          pango
          gtk2
          dbus
        ];
        #runScript = "x-plane-11";
      };
    in
      {
        devShells.${system}.default = fhs.env;
        packages.${system} = {
          default = fhs;
          x-plane-11 = x-plane-11;
        };
      };
}
