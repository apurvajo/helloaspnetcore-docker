FROM microsoft/aspnetcore-build:1.1
MAINTAINER mikono@microsoft.com

WORKDIR /app

COPY . .

RUN chmod +x init_script.sh \
  && dotnet restore \
  && dotnet publish -o /out

EXPOSE 80

CMD [ "/app/init_script.sh" ]
