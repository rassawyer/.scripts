################################################################################
## install neccesary packages
pacman -S --needed git
################################################################################

################################################################################
## git clone repo and all of the resources
git pull https://github.com/rassawyer/.scripts.git
################################################################################

################################################################################
## check if neccesary directories exist, create them if they do not
if [ -d "$HOME/.config" ]; then
	echo "Backing up .config"
	mv "$HOME/.config" "$HOME/.config_$(date +%Y%m%d_%H%M%S).bak"
	echo "Deleting .config"
	rm -rf "$HOME/.config"
fi

if [ ! -L "$HOME/.config" ]; then
    echo "Creating symlink for ~/.config"
    ln -s "$HOME/.scripts/dotFiles" "$HOME/.config"
fi
################################################################################

################################################################################
## Create symlinks for the zsh config files.
ln -sf "$HOME/.scripts/dotFiles/zshenv" "$HOME/.zshenv"
################################################################################

################################################################################
## setup Android build utilities and directories
curl https://storage.googleapis.com/git-repo-downloads/repo > $HOME/.scripts/repo
chmod a+x "$HOME/.scripts/repo"
################################################################################
