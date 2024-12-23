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
if [ ! -d $HOME/.config ]; then
	mkdir $HOME/.config
fi
if [ ! -d $HOME/.config/sway ]; then
	mkdir $HOME/.config/sway
fi

if [ ! -d $HOME/.scripts ]; then
	mkdir $HOME/.scripts
fi

if [ ! -d $HOME/.bak ]; then
	mkdir $HOME/.bak
fi
################################################################################

################################################################################
## Create symlinks for the zsh config files.
ln -sf $HOME/.scripts/dotFiles/zsh/zshenv $HOME/.zshenv
ln -sf $HOME/.scripts/dotFiles/zsh/zshrc $HOME/.config/zsh.zshrc
ln -sf $HOME/.scripts/dotFiles/zsh/completion.zsh $HOME/.config/zsh/completions.zsh
################################################################################

################################################################################
## remove existing sway config file, and replace with a softlink to custom 
## version
if [ ! -f $HOME/.config/sway/config ]; then
	rm -rfv $HOME/.config/sway/config
fi
rm -rfv $HOME/.config/sway/config
ln -sf $HOME/.scripts/dotFiles/sway $HOME/.config/sway/config
################################################################################

################################################################################
## setup Android build utilities and directories
curl https://storage.googleapis.com/git-repo-downloads/repo > $HOME/.scripts/repo
chmod a+x $HOME/.scripts/repo
################################################################################
