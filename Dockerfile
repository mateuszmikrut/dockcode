FROM ubuntu:latest
RUN apt-get update && apt-get install -y wget
RUN wget https://packages.microsoft.com/config/debian/10/packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN apt-get update && apt-get install -y zsh curl python3-pip git powershell net-tools
RUN wget https://github.com/coder/code-server/releases/download/v4.9.0/code-server_4.9.0_amd64.deb -O /tmp/code.deb
RUN dpkg -i /tmp/code.deb && rm /tmp/code.deb
RUN useradd -m -s /bin/zsh dockcode
ENV DOCKCODEPASS=P@$$w0rd
COPY entrypoint /
RUN chmod +x /entrypoint
EXPOSE 8080/tcp
USER dockcode
WORKDIR /home/dockcode
RUN mkdir -p  .config/code-server/
ENTRYPOINT ["/entrypoint"]
