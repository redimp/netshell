FROM debian:12-slim

RUN export DEBIAN_FRONTEND=noninteractive; \
    apt-get update -yy && \
    apt-get upgrade -yy && \
    apt-get install -yy --no-install-recommends \
    locales ca-certificates gpg \
    iputils-ping dnsutils iproute2 net-tools tcpdump \
    curl wget jq netcat-openbsd ssh telnet nmap yq \
    less micro vim \
    tmux screen tshark swaks && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    usermod -s /usr/bin/fish root && \
    sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

RUN export DEBIAN_FRONTEND=noninteractive; \
    curl -SsL https://packages.httpie.io/deb/KEY.gpg | gpg --dearmor -o /usr/share/keyrings/httpie.gpg && \
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/httpie.gpg] https://packages.httpie.io/deb ./" >/etc/apt/sources.list.d/httpie.list && \
    apt-get update -yy && \
    apt-get install -yy --no-install-recommends httpie && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN export DEBIAN_FRONTEND=noninteractive; \
    curl -fsSL https://download.opensuse.org/repositories/shells:fish:release:4/Debian_12/Release.key | gpg --dearmor -o /etc/apt/trusted.gpg.d/shells_fish_release_4.gpg && \
    echo "deb http://download.opensuse.org/repositories/shells:/fish:/release:/4/Debian_12/ /" > /etc/apt/sources.list.d/shells:fish:release:4.list && \
    apt-get update -yy && \
    apt-get install -yy --no-install-recommends fish && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN curl -sSL -o /usr/local/bin/kubectl "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/$(dpkg --print-architecture)/kubectl" && \
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/$(dpkg --print-architecture)/kubectl.sha256" && \
    echo "$(cat kubectl.sha256) /usr/local/bin/kubectl" | sha256sum --check && \
    chmod +x /usr/local/bin/kubectl && \
    rm -f kubectl.sha256


ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV EDITOR=vim

# configure fish
COPY dotfiles/config.fish /root/.config/fish/config.fish
COPY dotfiles/fish_prompt.fish dotfiles/fish_right_prompt.fish \
    /root/.config/fish/functions/
# configure bash
COPY dotfiles/bash_history /root/.bash_history
COPY dotfiles/bashrc /root/.bashrc
# configure tools / helper
# curl timings
COPY dotfiles/curl-timings.txt /root/.curl-timings.txt
# motd
COPY motd /etc/motd
COPY --chmod=755 entrypoint.sh /entrypoint.sh

# generate fish_history
RUN cat /root/.bash_history | while read LINE; do \
    echo "- cmd:" $LINE >> /root/.config/fish/fish_history && \
    echo "  when:" $(date "+%s") >> /root/.config/fish/fish_history; \
    done

USER root
WORKDIR /root

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/bin/fish"]
