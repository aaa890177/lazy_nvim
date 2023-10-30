hostname=$(hostname)
git config --global credential.helper store
git config --global user.name arthur
git config --global user.email $hostname
git config --global pull.rebase false

sudo cp -r ../JetBrainsMono /usr/share/fonts
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg
sudo mkdir -p /etc/apt/keyrings
cd ~/Documents
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
NODE_MAJOR=16
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
sudo apt-get update
sudo apt-get install nodejs -y


sudo apt-get install -y ninja-build gettext cmake unzip curl bpytop;
sudo apt install -y ripgrep fd-find bat tldr exa xclip

git clone -b stable http://github.com/neovim/neovim --depth=1 /tmp/neovim;
cd /tmp/neovim;
git checkout stable;
make CMAKE_BUILD_TYPE=RelWithDebInfo;
sudo make install


sudo pip3 install neovim
sudo npm install neovim
sudo apt install -y zsh
# 安装 Oh My Zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
