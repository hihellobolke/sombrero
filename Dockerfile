FROM hihellobolke/sombrero:base
LABEL maintainer="hihellobolke@gmail.com"

RUN dnf install -y bind-utils net-tools iputils traceroute whois openssh-clients gnupg openssl kmod \
    && dnf -y clean all

RUN rm -rf /tmp/*

ENTRYPOINT ["bash"]
CMD ["--login"]
