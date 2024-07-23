# Pop!_OS Post-install Script

Este script automatiza a instalação e configuração de programas e ferramentas essenciais no Pop!_OS (20.04 LTS ou superior).

## Sumário

- [Recursos](#recursos)
- [Programas Instalados](#programas-instalados)
- [Requisitos](#requisitos)
- [Como Usar](#como-usar)
- [Créditos](#créditos)

## Recursos

- Atualiza e limpa o sistema.
- Instala programas via `apt`, `snap`, e `flatpak`.
- Configura o `zsh` com Oh My Zsh e tema Spaceship.
- Instala e configura `asdf` com plugins para Node.js e Java.
- Instala Docker e Docker Compose.

## Programas Instalados

### APT

- Snapd
- Gparted
- VLC
- VS Code
- Git
- Wget
- Gnome-Tweaks
- Zsh
- Curl
- Docker

### Snap

- Intellij
- Sublime-Text
- PgAdmin4

### Flatpak

- Spotify
- Gnome Boxes
- Onlyoffice
- Discord
- Insomnia
- DBeaver Community
- Github Desktop
- Apostrophe
- Fragments

### Ferramentas Adicionais

- Oh My Zsh
- Spaceship prompt
- asdf

## Requisitos

- Conexão com a Internet

## Como Usar

1. Clone este repositório:
    ```sh
    git clone https://github.com/luisfelipe03/pop-os-postinstall.git
    ```
2. Navegue até o diretório do script:
    ```sh
    cd nome-do-repositorio
    ```
3. Torne o script executável:
    ```sh
    chmod +x pos-os-postinstall.sh
    ```
4. Execute o script:
    ```sh
    ./pos-os-postinstall.sh
    ```

## Créditos

Este script foi baseado no [script de pós-instalação do Diolinux](https://github.com/Diolinux/pop-os-postinstall/tree/main). Agradecimentos especiais ao Diolinux.
