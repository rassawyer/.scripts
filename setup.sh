###############################################################################
## install neccesary packages
pacman -S --needed git
###############################################################################

###############################################################################
## git clone repo and all of the resources
git pull https://github.com/rassawyer/.scripts.git
###############################################################################

###############################################################################
## remove existing .bashrc, if any exists, and softlink to custom version
if [ ! -f $HOME/.bashrc ]; then
	rm -rfv $HOME/.bashrc
fi	
rm -rfv $HOME/.bashrc
ln -sf $HOME/.scripts/dotFiles/bashrc $HOME/.bashrc
###############################################################################

###############################################################################
## check if neccesary directories exist, create them if they do not, then
## create softlinks to custom files.
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
###############################################################################

###############################################################################
## remove existing sway config file, and replace with a softlink to custom 
## version
if [ ! -f $HOME/.config/sway/config ]; then
	rm -rfv $HOME/.config/sway/config
fi
rm -rfv $HOME/.config/sway/config
ln -sf $HOME/.scripts/dotFiles/sway $HOME/.config/sway/config
###############################################################################

###############################################################################
## setup Android build utilities and directories
curl https://storage.googleapis.com/git-repo-downloads/repo > $HOME/.scripts/repo
chmod a+x $HOME/.scripts/repo
###############################################################################

###############################################################################
## remove existing swayblocks config file, if present, and replace with softlink 
## to custom version.
## remove $HOME/.xinitrc and replace with softlink to custom version
if [ ! -f $HOME/.xinitrc ]; then
	rm -rfv $HOME/.xinitrc
fi
rm -rfv $HOME/.xinitrc
ln -sf $HOME/.scripts/dotFiles/xinitrc $HOME/.xinitrc
###############################################################################
