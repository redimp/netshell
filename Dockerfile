FROM debian:12.9-slim

RUN export DEBIAN_FRONTEND=noninteractive; \
    apt-get update -yy && \
    apt-get upgrade -yy && \
    apt-get install -yy --no-install-recommends \
    locales fish zsh ca-certificates \
    iputils-ping dnsutils curl wget jq netcat-openbsd ssh telnet nmap \
    micro vim \
    tmux screen && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    usermod -s /usr/bin/fish root && \
    sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# configure fish
COPY dotfiles/config.fish /root/.config/fish/config.fish
COPY dotfiles/fish_prompt.fish dotfiles/fish_right_prompt.fish \
    /root/.config/fish/functions/
COPY dotfiles/fish_history /root/.local/share/fish/fish_history

USER root
WORKDIR /root

CMD ["fish"]
