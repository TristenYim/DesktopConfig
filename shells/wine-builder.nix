# This shell is for building wine from scratch

# I used this shell to successfully build ElementalWarrior's WINE fork for 
# Affinity Photo (affinity-photo3-wine9.13-part3)
# See how I did this at: https://codeberg.org/wanesty/affinity-wine-docs

{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
    buildInputs = with pkgs; [

        # These have been added because they were in the official nixpkgs WINE build
        # See https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/emulators/wine/base.nix
        libcap
        cups
        gettext
        dbus
        cairo
        unixODBC
        samba4
        ncurses
        libva
        libpcap
        libv4l
        sane-backends
        libgphoto2
        libkrb5
        fontconfig
        alsa-lib
        libpulseaudio
        xorg.libXinerama
        udev
        vulkan-loader
        SDL2
        libusb1
        gst_all_1.gstreamer
        gtk3
        glib
        opencl-headers
        ocl-icd
        openssl
        gnutls
        libGLU
        libGL
        mesa.osmesa
        libdrm
        xorg.libX11
        xorg.libXcomposite
        xorg.libXcursor
        xorg.libXext
        xorg.libXfixes
        xorg.libXi
        xorg.libXrandr
        xorg.libXrender
        xorg.libXxf86vm
        wayland
        libxkbcommon
        wayland-protocols
        wayland.dev
        libxkbcommon.dev
        mesa

        # These have been added because building gave errors or warnings if I didn't
        bison
        flex
        fontforge
        pkg-config
        makeWrapper
        freetype
        pkgsCross.mingw32.buildPackages.gcc
        pkgsCross.mingwW64.buildPackages.gcc
        gst_all_1.gst-plugins-base
        pcsclite

        # The included wine version is only for using Winetricks
        winetricks
        wineWowPackages.minimal
    ];
}
