#!/bin/bash

# Atualiza pacotes e instala dependências
sudo apt update && sudo apt upgrade -y
sudo apt install -y zsh git curl unzip gnome-tweaks gnome-shell-extensions

# Instalação do Zsh e configuração como shell padrão
if ! [ -x "$(command -v zsh)" ]; then
    echo "Zsh não está instalado. Instalando agora..."
    sudo apt install -y zsh
else
    echo "Zsh já está instalado."
fi
chsh -s $(which zsh)

# Instalação do Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Instalando Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "Oh My Zsh já está instalado."
fi

# Configurando tema Spaceship
SPACESHIP_PROMPT_DIR="$HOME/.oh-my-zsh/custom/themes/spaceship-prompt"
if [ ! -d "$SPACESHIP_PROMPT_DIR" ]; then
    echo "Instalando tema Spaceship..."
    git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$SPACESHIP_PROMPT_DIR"
    ln -s "$SPACESHIP_PROMPT_DIR/spaceship.zsh-theme" "$HOME/.oh-my-zsh/custom/themes/spaceship.zsh-theme"
else
    echo "Tema Spaceship já está instalado."
fi

# Instalando plugins zsh-autosuggestions e zsh-syntax-highlighting
PLUGINS_DIR="$HOME/.oh-my-zsh/custom/plugins"
if [ ! -d "$PLUGINS_DIR/zsh-autosuggestions" ]; then
    echo "Instalando plugin zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions "$PLUGINS_DIR/zsh-autosuggestions"
else
    echo "Plugin zsh-autosuggestions já está instalado."
fi

if [ ! -d "$PLUGINS_DIR/zsh-syntax-highlighting" ]; then
    echo "Instalando plugin zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$PLUGINS_DIR/zsh-syntax-highlighting"
else
    echo "Plugin zsh-syntax-highlighting já está instalado."
fi

# Instalando o plugin asdf para Zsh
if [ ! -d "$HOME/.asdf" ]; then
    echo "Instalando asdf..."
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.13.1
else
    echo "ASDF já está instalado."
fi

# Baixando e instalando a fonte Fira Code
FIRA_CODE_DIR="$HOME/.fonts"
FIRA_CODE_ZIP="/tmp/FiraCode.zip"
if [ ! -d "$FIRA_CODE_DIR" ]; then
    echo "Criando diretório .fonts..."
    mkdir -p "$FIRA_CODE_DIR"
fi

echo "Baixando a fonte Fira Code..."
curl -Lo "$FIRA_CODE_ZIP" https://github.com/tonsky/FiraCode/releases/download/6.2/Fira_Code_v6.2.zip

echo "Extraindo a fonte Fira Code..."
unzip -o "$FIRA_CODE_ZIP" -d "$FIRA_CODE_DIR"

echo "Atualizando o cache de fontes..."
fc-cache -f "$FIRA_CODE_DIR"

echo "Fonte Fira Code instalada com sucesso."

# Configurando .zshrc
echo "Configurando .zshrc..."
cat > ~/.zshrc <<EOL
export ZSH="\$HOME/.oh-my-zsh"
ZSH_THEME="spaceship"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting asdf)

# Spaceship configuration
SPACESHIP_PROMPT_ORDER=(
  user
  dir
  host
  git
  node
  python
  ruby
  docker
  kubectl
  exec_time
  line_sep
  battery
  jobs
  exit_code
  char
)
SPACESHIP_CHAR_SYMBOL="❯"
SPACESHIP_CHAR_SUFFIX=" "

source \$ZSH/oh-my-zsh.sh

# Alias úteis
alias ll='ls -la'
alias gs='git status'
alias ga='git add'
alias gp='git pull'
alias gc='git commit -m'
alias npmstart='npm start'

# Configuração de plugins
source \$ZSH/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source \$ZSH/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ASDF setup
. \$HOME/.asdf/asdf.sh
. \$HOME/.asdf/completions/asdf.bash

# Variáveis de ambiente do Java
export JAVA_HOME=\$(asdf where java)
export PATH="\$JAVA_HOME/bin:\$PATH"
EOL

# Mensagem final
echo -e "\nConfiguração concluída!"
echo "Ferramentas instaladas:"
echo "  - Zsh (shell padrão)"
echo "  - Oh My Zsh com tema Spaceship"
echo "  - Plugins: zsh-autosuggestions, zsh-syntax-highlighting, asdf"
echo "  - Fonte Fira Code"
echo "  - Gnome Tweaks e Gnome Extensions"
echo -e "\nReinicie o terminal ou use 'exec \$SHELL' para aplicar as configurações."
