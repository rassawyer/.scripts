# pull any missing sripts and dotfiles from github
git clone https://github.com/rassawyer/.scripts.git

# remove ~/.bashrc and replice it with a softlink to custom version.
rm -rfv ~/.bashrc
ln -sf ~/.scripts/dotFiles/bashrc ~/.bashrc

# remove existing i3 config file, and replace with a softlink to custom version 
rm -rfv ~/.config/i3/config
ln -sf ~/.scripts/dotFiles/i3 ~/.config/i3/config

# remove ~/.xinitrc and replace with softlink to custom version
rm -rfv ~/.xinitrc
ln -sf ~/.scripts/dotFiles/xinitrc ~/.xinitrc

# Create .bak directory under /home/$USER to store the backups of pacman db
mkdir /home/$USER/.bak
