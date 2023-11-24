#!/usr/bin/sh
sudo apt install -y zsh
# 安装 Oh My Zsh
echo 'y'| sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

cat <<'EOF' | sudo tee -a ~/.zshrc
export EDITOR="nvim"
alias nv="nvim"
alias vim="nvim"
alias vi="nvim"
alias nvi="nvim"
alias nvimrc="cd ~/.config/nvim"
alias cat="batcat --style=plain"
alias exa="exa --icons"
alias tre="exa --long --tree --level=3"
alias ls="exa -s type"
alias ll="exa -all -l -s type"
alias d="docker"
alias dc="docker-compose"
alias fd="fdfind"
alias top="bpytop"
export PATH=$PATH:~/.local/bin
EOF

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

sed -i '/^plugins=(git)$/c\
plugins=(\
    git\
    git-auto-fetch\
    zsh-syntax-highlighting\
    zsh-autosuggestions\
    sudo\
    kubectl\
    helm\
)' ~/.zshrc

sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc

cd ~/.config/nvim/shell/
cp .p10k.zsh ~
echo '[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh' | tee -a ~/.zshrc
