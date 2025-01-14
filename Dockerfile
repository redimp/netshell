FROM debian:12.9-slim

RUN export DEBIAN_FRONTEND=noninteractive; \
    apt-get update -yy && \
    apt-get upgrade -yy && \
    apt-get install -yy --no-install-recommends iputils-ping dnsutils curl wget jq netcat-openbsd ssh telnet fish zsh ca-certificates nmap \
    micro vim \
    tmux screen && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    usermod -s /usr/bin/fish root

# configure fish
COPY dotfiles/config.fish /root/.config/fish/config.fish
COPY dotfiles/fish_prompt.fish dotfiles/fish_right_prompt.fish \
    /root/.config/fish/functions/
COPY dotfiles/fish_history /root/.local/share/fish/fish_history

USER root
WORKDIR /root

CMD ["fish"]
