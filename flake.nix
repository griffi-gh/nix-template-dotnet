{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    yafas.url = "github:UbiqueLambda/yafas";
  };

  outputs = {
    self, nixpkgs, yafas, ...
  }: yafas.allSystems nixpkgs ({ pkgs, system }: let
    dotnet_sdk = pkgs.dotnetCorePackages.sdk_8_0;
    dotnet_runtime = pkgs.dotnetCorePackages.runtime_8_0;
  in {
    devShells.default = pkgs.mkShell rec {
      buildInputs = with pkgs; [
        dotnet_sdk
        dotnet_runtime
        dotnetPackages.Nuget
        omnisharp-roslyn
        mono
        msbuild
      ];
      LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath buildInputs;
      DOTNET_ROOT = "${dotnet_sdk}";
      DOTNET_CLI_TELEMETRY_OPTOUT = 1;
    };
  });
}
