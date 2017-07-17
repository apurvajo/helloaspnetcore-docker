FROM microsoft/aspnetcore-build:1.1
MAINTAINER mikono@microsoft.com

WORKDIR /app

COPY . .
COPY sshd_config /etc/ssh

RUN apt update \
  && apt install -y openssh-server \
  && echo "root:Docker!" | chpasswd

RUN chmod +x init_script.sh \
  && dotnet restore \
  && dotnet publish -o /out

EXPOSE 2222 80

CMD [ "/app/init_script.sh" ]
