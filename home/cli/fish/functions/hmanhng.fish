set flake_dir ~/.flakes

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
            git clone https://github.com/hmanhng/.flakes $flake_dir
            symbolic_nvim
        case {,-}-n{vim,}
            symbolic_nvim
        case {,-}-g{pg,}
            nix develop $flake_dir/.#secret -c ssh-to-pgp -private-key -i ~/.ssh/id_rsa | gpg --import --quiet
        case {,-}-s{sh,}
            unzip /run/media/hmanhng/Ventoy/ssh.zip -d ~/.ssh
        case {,-}-w{allpapers,}
            git clone --depth 1 https://github.com/hmanhng/wallpapers ~/Pictures/wallpapers
        case {,-}-e{macs,}
            rm -rf ~/.emacs.d
            git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
            ~/.config/emacs/bin/doom sync
        case \*
            echo -e "\ahmanhng function:"
            echo -e "[-c | --clone]:        Clone .flakes --branch=tmpfs and Symbolic nvim from flakes"
            echo -e "[-e | --emacs]:        Clone doom-emacs && run doom sync"
            echo -e "[-g | --gpg]:          Import ssh-to-pgp for sops"
            echo -e "[-n | --nvim]:         Symbolic nvim"
            echo -e "[-s | --ssh]:          Unzip .ssh from usb"
            echo -e "[-w | --wallpapers]:   Clone wallpapers"
    end
end
