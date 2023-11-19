set flake_dir ~/.flakes

function clone_flakes
    set hardware_configuration $flake_dir"/hosts/laptop/hardware-configuration.nix"
    git clone https://github.com/hmanhng/.flakes $flake_dir --branch=tmpfs
    cp /etc/nixos/hardware-configuration.nix $hardware_configuration
    perl -i -pe 'if ($in_section) { s/by-uuid\/[^"]+/by-label\/nixos/; $in_section = 0; } elsif (/fileSystems."\/nix" =/) { $in_section = 1; }' $hardware_configuration
    perl -i -pe 'if ($in_section) { s/by-uuid\/[^"]+/by-label\/boot/; $in_section = 0; } elsif (/fileSystems."\/boot" =/) { $in_section = 1; }' $hardware_configuration
    sed -i '/tmpfs/a\      options = [ "defaults" "size=10G" "mode=755"  ];' $hardware_configuration
    sed -i 's/swapDevices = \[ ];/swapDevices = [{ device = "\/var\/lib\/swapfile"; size = 16*1024; }];\n  boot.kernel.sysctl = {"vm.swappiness" = 10;};/g' $hardware_configuration
    alejandra $hardware_configuration
end

function symbolic_nvim
    set nvim_flake $flake_dir"/home/editors/nvim"
    set nvim_dir ~/.config/nvim
    rm -rf $nvim_dir ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim
    mkdir $nvim_dir || true
    set item lua init.lua stylua.toml
    for i in $item
        ln -vsn $nvim_flake/$i $nvim_dir/$i
    end
end

function hmanhng -d "hmanhng function"
    switch "$argv"
        case {,-}-c{lone,}
            clone_flakes
            symbolic_nvim
        case {,-}-g{pg,}
            nix develop $flake_dir/.#secret -c ssh-to-pgp -private-key -i ~/.ssh/id_rsa | gpg --import --quiet
        case {,-}-s{sh,}
            unzip /run/media/hmanhng/Ventoy/ssh.zip -d ~/.ssh
        case {,-}-w{allpapers,}
            git clone https://github.com/hmanhng/wallpapers ~/Pictures/wallpapers
        case \*
            echo -e "\ahmanhng function:"
            echo -e "[-c | --clone]:        Clone .flakes --branch=tmpfs and Symbolic nvim from flakes"
            echo -e "[-g | --gpg]:          Import ssh-to-pgp for sops"
            echo -e "[-s | --ssh]:          Unzip .ssh from usb"
            echo -e "[-w | --wallpapers]:   Clone wallpapers"
    end
end
