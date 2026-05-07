set flake_dir ~/.flakes

function hmanhng -d "hmanhng function"
    switch "$argv"
        case {,-}-c{lone,}
            git clone https://github.com/hmanhng/.flakes $flake_dir
            symbolic_nvim
        case {,-}-g{pg,}
            nix develop $flake_dir/.#secret -c ssh-to-pgp -private-key -i ~/.ssh/id_rsa | gpg --import --quiet
        case {,-}-s{sh,}
            7z e /run/media/hmanhng/Ventoy/ssh.zip -o$HOME/.ssh
        case {,-}-w{allpapers,}
            git clone --depth 1 https://github.com/hmanhng/wallpapers ~/Pictures/wallpapers
        case \*
            echo -e "\ahmanhng function:"
            echo -e "[-c | --clone]:        Clone .flakes --branch=tmpfs and Symbolic nvim from flakes"
            echo -e "[-g | --gpg]:          Import ssh-to-pgp for sops"
            echo -e "[-s | --ssh]:          Unzip .ssh from usb"
            echo -e "[-w | --wallpapers]:   Clone wallpapers"
    end
end
