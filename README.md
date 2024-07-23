
# Post-Install Script para Pop!_OS

Este script automatiza a instalação e configuração de programas no Pop!_OS (20.04 LTS ou superior). Ele cobre uma variedade de ferramentas úteis, desde a configuração de ambientes de desenvolvimento até a instalação de aplicativos de uso diário.

## Como Usar

1. **Clone o repositório:**

   ```bash
   git clone https://github.com/luisfelipe03/pop-os-postinstall.git
   cd seu-repositorio
   ```

2. **Dê permissão de execução ao script:**

   ```bash
   chmod +x pos-os-postinstall.sh
   ```

3. **Execute o script:**

   ```bash
   ./pos-os-postinstall.sh
   ```

## O Que o Script Faz

1. **Atualiza o Sistema:**
   - Atualiza a lista de pacotes e realiza uma atualização completa do sistema.

2. **Instala Programas com `apt`:**
   - `snapd`: Gerenciador de pacotes Snap.
   - `gparted`: Gerenciador de partições.
   - `vlc`: Reprodutor de mídia.
   - `git`: Sistema de controle de versões.
   - `wget`: Utilitário de download.
   - `gnome-tweaks`: Ferramenta para personalização do GNOME.
   - `zsh`: Shell Zsh.
   - `curl`: Ferramenta para transferências de dados.
   - `docker.io`: Docker Engine.

3. **Instala Pacotes `.deb`:**
   - `Google Chrome`: Navegador web.

4. **Instala Pacotes Flatpak:**
   - **Spotify:** Serviço de streaming de música.
   - **AnyDesk:** Software de acesso remoto.
   - **Remmina:** Cliente de desktop remoto.
   - **WhatIP:** Ferramenta para verificar seu IP público.
   - **GNOME Boxes:** Ferramenta de virtualização.
   - **OnlyOffice:** Suite de escritório (editor de texto, planilhas e apresentações).
   - **Discord:** Aplicativo de comunicação para gamers e comunidades.
   - **Insomnia:** Cliente REST API e GraphQL.
   - **DBeaver Community:** Ferramenta de administração de banco de dados.
   - **Shiftey Desktop:** Gerenciador de janelas para otimizar o fluxo de trabalho.
   - **Apostrophe:** Editor de texto Markdown.
   - **Fragments:** Gerenciador de Torrents.

5. **Instala Pacotes Snap:**
   - **IntelliJ IDEA Ultimate (`--classic`):** IDE para desenvolvimento Java e outras linguagens.
   - **Sublime Text (`--classic`):** Editor de texto avançado.
   - **PgAdmin4:** Ferramenta de administração para PostgreSQL.
   - **Visual Studio Code (`--classic`):** IDE para desenvolvimento com suporte a várias linguagens e extensões.

6. **Configura o Zsh:**
   - Instala e configura o Oh My Zsh com o tema Spaceship.
   - Adiciona plugins como `zsh-syntax-highlighting`, `zsh-autosuggestions`, e `zsh-completions`.
   - Define o Zsh como shell padrão.

7. **Instala e Configura o asdf:**
   - Instala o asdf e seus plugins para Node.js e Java.
   - Instala chaves necessárias para o plugin Node.js.

8. **Instala e Configura o Docker:**
   - Instala Docker e Docker Compose.
   - Adiciona o usuário ao grupo Docker.

9. **Limpeza e Atualização Final:**
   - Atualiza Flatpak e realiza a limpeza de pacotes.

## Créditos

Este script é baseado em um script do [Diolinux](https://github.com/Diolinux/pop-os-postinstall/tree/main), que foi adaptado e personalizado para atender às minhas necessidades específicas.

## Avisos

- **Snap com Confinamento Classic:** Alguns pacotes Snap como `intellij-idea-ultimate` e `sublime-text` requerem a opção `--classic`, pois eles precisam realizar alterações fora do sandbox de segurança padrão do Snap. Se solicitado, confirme a instalação com `--classic`.

- **Conexão com a Internet:** Certifique-se de que seu computador esteja conectado à internet antes de executar o script.

## Suporte

Se você encontrar problemas ou tiver dúvidas, sinta-se à vontade para abrir uma [issue](https://github.com/luisfelipe03/pop-os-postinstall/issues) no GitHub.
