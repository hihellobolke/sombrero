FROM fedora:latest
LABEL maintainer="hihellobolke@gmail.com"


COPY files /tmp/files
RUN dnf -y shell /tmp/files/dnf-transactions.txt

RUN cat /tmp/files/profile >> /etc/profile \
    && cat /tmp/files/bashrc >> /home/.bashrc

RUN cd /root \
    && git clone https://github.com/gpakosz/.tmux.git \
    && ln -s -f .tmux/.tmux.conf \
    && cp .tmux/.tmux.conf.local .

RUN curl https://sh.rustup.rs -sSf -o /bin/rustup-init \
    && chmod 755 /bin/rustup-init \
    && /bin/rustup-init -y

RUN curl https://dl.google.com/go/go1.10.1.linux-amd64.tar.gz -qLs -o /tmp/go.tar.gz \
    && tar -C /usr/local -xzf /tmp/go.tar.gz \
    && /usr/local/go/bin/go get -u github.com/justjanne/powerline-go

RUN curl -s https://install.zerotier.com/ -o /bin/zerotier-init -q -L -sS \
    && chmod 755 /bin/zerotier-init \
    && /bin/zerotier-init || exit 0

RUN rm -rf /tmp/*

ENTRYPOINT ["bash"]
CMD ["--login"]
