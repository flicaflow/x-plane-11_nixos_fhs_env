{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: 
   let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      fhs = pkgs.buildFHSEnv {
        name = "fhs-shell";
        targetPkgs = pkgs: with pkgs; [
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
      };
    in
      {
        devShells.${system}.default = fhs.env;
      };
}
