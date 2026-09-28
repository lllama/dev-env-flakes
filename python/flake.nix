{
  description = "dev-env starter profile: Python development";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      packages.${system}.default = pkgs.buildEnv {
        name = "dev-env-python";
        paths = with pkgs; [ python3 uv git curl jq ripgrep fd vim jujutsu ];
      };
    };
}
