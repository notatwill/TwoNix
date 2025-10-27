{pkgs, ...}: let
  migrate = pkgs.writeShellScriptBin "migrate" ''
    # Check for correct number of arguments
    if [ "$#" -ne 3 ]; then
      echo "Usage: $0 <flake-ref> <target-host> <facter-path>"
      echo "Example: $0 '.#andromeda' 'root@192.168.1.100' './hosts/andromeda/facter.json'"
      exit 1
    fi

    FLAKE_REF=$1
    TARGET_HOST=$2
    FACTER_PATH=$3

    # Create a temp dir with all the extra files we need
    temp=$(mktemp -d)
    cleanup() {
      rm -rf "$temp"
    }
    trap cleanup EXIT

    mkdir -p "$temp/nix/persist/var/lib/sops"
    sudo cp -a "/nix/persist/var/lib/sops" "$temp/nix/persist/var/lib/sops"
    sudo cp -a "/nix/persist/home/willg/.config/sops/age" "$temp/nix/persist/home/willg/.config/sops/age"
    sudo chown -R "$(id -u):$(id -g)" "$temp"

    nixos-anywhere --extra-files "$temp" --flake "$FLAKE_REF" --target-host "$TARGET_HOST" \
    --generate-hardware-config nixos-facter "$FACTER_PATH" \
    --chown "/nix/persist/home/willg" "1000:100"
  '';
in {
  home.packages = [pkgs.nixos-anywhere pkgs.coreutils pkgs.sudo];
  home.shellAliases.migrate = "${migrate}/bin/migrate";
}
