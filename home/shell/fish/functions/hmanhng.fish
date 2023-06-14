set flakeDir ~/.flakes
set nvimDir $flakeDir/home/editors/nvim
set nvimConf ~/.config/nvim
function hmanhng -d "hmanhng function"
  switch "$argv"
    case {,-}-s{sh,}
        unzip /run/media/hmanhng/Ventoy/ssh.zip -d ~/.ssh
    case {,-}-g{pg,}
        nix develop $flakeDir/.#secret -c ssh-to-pgp -private-key -i ~/.ssh/id_rsa | gpg --import --quiet

    case {,-}-c{lone,}
        git clone https://github.com/hmanhng/.flakes $flakeDir --branch=tmpfs

    case {,-}-n{vim,}
        rm -rf $nvimConf ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim
        mkdir $nvimConf || true
        set item lua init.lua stylua.toml
        for i in $item
            ln -vsn $nvimDir/$i $nvimConf/$i
        end

    case \*
        echo -e "\ahmanhng function:"
        echo -e "[-s | --ssh]:          Unzip .ssh from usb"
        echo -e "[-c | --clone]:        Clone .flakes --branch=tmpfs"
        echo -e "[-g | --gpg]:          ssh-to-pgp for sops"
        echo -e "[-n | --nvim]:         Symbolic nvim from flakes"
  end
end
