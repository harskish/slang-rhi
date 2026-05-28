#{ pkgs ? import <nixpkgs> { config = { allowUnfree = true; cudaSupport = true; }; } }:
{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  packages = with pkgs; [
    cmake
    ninja
    pkg-config
    gcc
    glfw
    vulkan-loader
    vulkan-headers
    xorg.libX11
    xorg.libXcursor
    xorg.libXrandr
    xorg.libXinerama
    xorg.libXi
    vulkan-tools
    #cudatoolkit
    #cudaPackages.cuda_nvrtc
    pkgs.bashInteractive # direnv shopt errors
  ];

  LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath (with pkgs; [
    stdenv.cc.cc
  ]++ lib.optionals stdenv.hostPlatform.isLinux [
    "/run/opengl-driver"
    xorg.libX11
    xorg.libXext
    wayland
    libGL
    libxkbcommon
    vulkan-loader
    #cudatoolkit
    #cudaPackages.cuda_nvrtc
  ]);

  shellHook = ''
    echo "Build and run with:"
    echo "cmake --preset default -DSLANG_RHI_BUILD_EXAMPLES=ON -DSLANG_RHI_FETCH_SLANG=ON"
    echo "cmake --build -DSLANG_RHI_DEBUG=1 --preset Release --target example-path-tracer"
    echo "./build/Release/example-path-tracer"
  '';
}
