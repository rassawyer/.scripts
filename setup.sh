# pull any missing sripts and dotfiles from github
git clone https://github.com/rassawyer/.scripts.git

# remove $HOME.bashrc and replice it with a softlink to custom version.
rm -rfv $HOME.bashrc
ln -sf $HOME.scripts/dotFiles/bashrc $HOME.bashrc

# remove existing i3 config file, and replace with a softlink to custom version 
rm -rfv $HOME.config/i3/config
ln -sf $HOME.scripts/dotFiles/i3 $HOME.config/i3/config

# remove $HOME.xinitrc and replace with softlink to custom version
rm -rfv $HOME.xinitrc
ln -sf $HOME.scripts/dotFiles/xinitrc $HOME.xinitrc

# Create .bak directory under $HOME to store the backups of pacman db
mkdir $HOME/.bak
