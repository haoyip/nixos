{pkgs, ...}: {
  environment.systemPackages = [
    (pkgs.writeShellApplication {
      name = "unlock-data";
      text = ''
        set -euo pipefail

        mount_point=/data/8tb_1

        unlock() {
          local uuid="$1" name="$2"

          if [ -e "/dev/mapper/$name" ]; then
            echo "$name is already unlocked"
            return
          fi

          echo "Unlocking $name..."
          printf '%s' "$luks_passphrase" |
            sudo ${pkgs.cryptsetup}/bin/cryptsetup luksOpen --key-file - "/dev/disk/by-uuid/$uuid" "$name"
        }

        if [ ! -e /dev/mapper/8tb_1 ] || [ ! -e /dev/mapper/8tb_2 ]; then
          sudo -v
          read -rsp "LUKS passphrase for 8tb_1/8tb_2: " luks_passphrase
          echo
          trap 'unset luks_passphrase' EXIT
        fi

        unlock 8bf54ff6-bd1c-4669-af77-52aee73283f0 8tb_1
        unlock 445bbd43-4e01-4d87-abcc-6ad56ca5e3c1 8tb_2

        # Both RAID1 must be registered before mounting.
        sudo ${pkgs.btrfs-progs}/bin/btrfs device scan

        if ${pkgs.util-linux}/bin/mountpoint -q "$mount_point"; then
          echo "$mount_point is already mounted"
        else
          echo "Mounting $mount_point..."
          sudo ${pkgs.util-linux}/bin/mount "$mount_point"
        fi

        echo "Data disk ready. Start data services with:"
        echo "  sudo systemctl start immich-server immich-machine-learning opencloud vaultwarden jellyfin dnsmasq"
      '';
    })
  ];
}
