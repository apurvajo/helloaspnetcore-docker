FROM microsoft/aspnetcore-build:1.1
MAINTAINER mikono@microsoft.com

WORKDIR /app

COPY . .

RUN dotnet restore \
  && dotnet publish -o /out

ENTRYPOINT [ "dotnet", "/out/helloaspnetcore.dll" ]
