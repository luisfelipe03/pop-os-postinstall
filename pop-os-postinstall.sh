#!/usr/bin/env bash
#
# pos-os-postinstall.sh - Instalar e configurar programas no Pop!_OS (20.04 LTS ou superior)
#
# ------------------------------------------------------------------------ #
#
# COMO USAR?
#   $ ./pos-os-postinstall.sh
#
# ----------------------------- VARIÁVEIS ----------------------------- #
set -e

## URLs
URL_GOOGLE_CHROME="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
URL_OH_MY_ZSH="https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh"
URL_ASDF="https://github.com/asdf-vm/asdf.git"
URL_PGADMIN4="https://ftp.postgresql.org/pub/pgadmin/pgadmin4/v6.1/pip/pgadmin4-6.1-py3-none-any.whl"

## DIRETÓRIOS E ARQUIVOS
DIRETORIO_DOWNLOADS="$HOME/Downloads/programas"
FILE="$HOME/.config/gtk-3.0/bookmarks"

# CORES
VERMELHO='\e[1;91m'
VERDE='\e[1;92m'
SEM_COR='\e[0m'

# FUNÇÕES

# Atualizando repositório e fazendo atualização do sistema
apt_update() {
  sudo apt update && sudo apt dist-upgrade -y
}

# -------------------------------------------------------------------------------- #
# -------------------------------TESTES E REQUISITOS----------------------------------------- #

# Internet conectando?
testes_internet() {
  if ! ping -c 1 8.8.8.8 -q &> /dev/null; then
    echo -e "${VERMELHO}[ERROR] - Seu computador não tem conexão com a Internet. Verifique a rede.${SEM_COR}"
    exit 1
  else
    echo -e "${VERDE}[INFO] - Conexão com a Internet funcionando normalmente.${SEM_COR}"
  fi
}

# ------------------------------------------------------------------------------ #

# Removendo travas eventuais do apt
travas_apt() {
  sudo rm -rf /var/lib/dpkg/lock-frontend /var/cache/apt/archives/lock
}

# Adicionando/Confirmando arquitetura de 32 bits
add_archi386() {
  sudo dpkg --add-architecture i386
}

# Atualizando o repositório
just_apt_update() {
  sudo apt update -y
}

# Programas a serem instalados via apt
PROGRAMAS_PARA_INSTALAR=(
  snapd
  gparted
  vlc
  code
  git
  wget
  gnome-tweaks
  zsh
  curl
  docker.io
)

# ---------------------------------------------------------------------- #

# Download e instalação de programas externos
install_debs() {
  echo -e "${VERDE}[INFO] - Baixando pacotes .deb${SEM_COR}"

  mkdir -p "$DIRETORIO_DOWNLOADS"
  wget -c "$URL_GOOGLE_CHROME" -P "$DIRETORIO_DOWNLOADS"

  echo -e "${VERDE}[INFO] - Instalando pacotes .deb baixados${SEM_COR}"
  sudo dpkg -i $DIRETORIO_DOWNLOADS/*.deb
  sudo apt -f install -y

  echo -e "${VERDE}[INFO] - Instalando pacotes apt do repositório${SEM_COR}"
  for nome_do_programa in "${PROGRAMAS_PARA_INSTALAR[@]}"; do
    if ! dpkg -l | grep -q $nome_do_programa; then
      sudo apt install "$nome_do_programa" -y
    else
      echo "[INSTALADO] - $nome_do_programa"
    fi
  done
}

# Instalando pacotes Flatpak
install_flatpaks() {
  echo -e "${VERDE}[INFO] - Instalando pacotes flatpak${SEM_COR}"

  FLATPAK_PROGRAMS=(
    com.spotify.Client
    org.freedesktop.Piper
    org.gnome.Boxes
    org.onlyoffice.desktopeditors
    com.discordapp.Discord
    rest.insomnia.Insomnia
    io.dbeaver.DBeaverCommunity
    io.github.shiftey.Desktop
    org.gnome.gitlab.somas.Apostrophe
    de.haeckerfelix.Fragments
  )

  for program in "${FLATPAK_PROGRAMS[@]}"; do
    flatpak install flathub "$program" -y
  done
}

# Instalando pacotes Snap
install_snaps() {
  echo -e "${VERDE}[INFO] - Instalando pacotes snap${SEM_COR}"

  SNAP_PROGRAMS=(
    authy
    intellij-idea-ultimate --classic
    sublime-text --classic
    pgadmin4
  )

  for program in "${SNAP_PROGRAMS[@]}"; do
    sudo snap install $program
  done
}

# Configurando o Zsh com Oh My Zsh e tema Spaceship
config_zsh() {
  echo -e "${VERDE}[INFO] - Configurando o Zsh${SEM_COR}"

  # Instalar Oh My Zsh
  sh -c "$(wget $URL_OH_MY_ZSH -O -)"

  # Instalar Spaceship theme
  ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
  git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
  ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

  # Instalar plugins
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
  git clone https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
  git clone https://github.com/zsh-users/zsh-completions.git "$ZSH_CUSTOM/plugins/zsh-completions"

  # Configurar .zshrc
  sed -i 's/^ZSH_THEME=".*"/ZSH_THEME="spaceship"/' ~/.zshrc
  sed -i 's/^plugins=(git)/plugins=(git zsh-syntax-highlighting zsh-autosuggestions zsh-completions)/' ~/.zshrc

  # Aplicar as mudanças
  source ~/.zshrc

  # Definir Zsh como shell padrão
  chsh -s $(which zsh)
}

# Instalando e configurando asdf
install_asdf() {
  echo -e "${VERDE}[INFO] - Instalando asdf${SEM_COR}"

  git clone $URL_ASDF ~/.asdf --branch v0.10.2

  echo -e "\n. $HOME/.asdf/asdf.sh" >> ~/.zshrc
  echo -e "\n. $HOME/.asdf/completions/asdf.bash" >> ~/.zshrc
  source ~/.zshrc

  # Instalando plugins do asdf
  asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
  asdf plugin add java https://github.com/halcyon/asdf-java.git

  # Instalar chaves necessárias para o plugin de nodejs
  bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
}

# Instalando Docker e configurando usuário
install_docker() {
  echo -e "${VERDE}[INFO] - Instalando Docker${SEM_COR}"

  sudo apt install docker.io -y
  sudo systemctl start docker
  sudo systemctl enable docker
  sudo usermod -aG docker $USER

  # Instalar Docker Compose
  sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
}

# -------------------------------------------------------------------------- #
# ----------------------------- PÓS-INSTALAÇÃO ----------------------------- #

# Finalização, atualização e limpeza
system_clean() {
  apt_update
  flatpak update -y
  sudo apt autoclean -y
  sudo apt autoremove -y
  nautilus -q
}

# -------------------------------------------------------------------------- #
# -------------------------------EXECUÇÃO----------------------------------------- #

travas_apt
testes_internet
travas_apt
apt_update
travas_apt
add_archi386
just_apt_update
install_debs
install_flatpaks
install_snaps
config_zsh
install_asdf
install_docker
system_clean

echo -e "${VERDE}[INFO] - Script finalizado, instalação concluída! :)${SEM_COR}"

