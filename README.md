# Sample ASP.NET Core 1.1 app for App Service on Linux

Sample docker image is at https://hub.docker.com/r/michimune/helloaspnetcore/

## Overview

This is an example web application to learn the following three scenarios how to use App Service on Linux:
1. Build a custom Docker image and deploy it to your web app with Azure CLI
1. Enable CI/CD for the web app
1. Use SSH session from Advanced Tools (aka Kudu)

## Prerequisites

1. Install Docker
1. Install VS Code
1. Install Azure Extension Pack and Docker extension to VS Code (https://marketplace.visualstudio.com/items?itemName=ms-vscode.vscode-azureextensionpack)
1. Make sure multi-factor authentication (MFA) works on your local machine

## Build and Deploy a Custom Docker Image

1. Clone the repository to your local machine.
1. Open the project with VS Code.
1. Build the project by typing Ctrl+Shift+P **docker:build**, choose **Dockerfile**.
1. Publish the docker image by typing Ctrl+Shif+P **docker:publish**, and a tag (e.g. michimune/helloaspnetcore:latest).
1. Launch Docker Azure CLI extension by typing Ctrl+Shift+P **Docker:Azure CLI**. This will launch a docker container with Azure CLI configured.
1. Type `az login`. You will be prompted to navigate to http://aka.ms/devicelogin. Browse the page and copy and paste the code shown (~10 length characters) to the login page to complete the sign-in. When successful, you will see the list of subscriptions in your terminal.
1. Create a web app: `az webapp create --plan {AppServicePlanName} -g {ResourceGroupName} --name {SiteName}`
1. Set the docker container name to the web app: `az webapp config set -g {ResourceGroupName} --linux-fx-version "DOCKER|michimune/helloaspnetcore:latest" --name {SiteName}`
1. Browse the site by launching http://{SiteName}.azurewebsites.net/.

## Enable CI/CD

1. In Azure CLI window, enable CI/CD: `az webapp config appsettings set -g {ResourceGroupName} --settings DOCKER_ENABLE_CI=true --name {SiteName}`
1. Set deployment username and password (If needed): `az webapp deployment user set --user-name {Username}`
1. Browse http://dockerhub.com and navigate to the repository.
1. Choose Settings, add webhook:
  - Name: anything (e.g. docker)
  - Link: `https://{Username}:{Password}@{SiteName}.scm.azurewebsites.net/docker/hook`
5. Update **message.txt** (For example, append one character) and save it.
1. Type Ctrl+Shift+P **docker:build**, choose Dockerfile. Type or choose the same tag.
1. Type Ctrl+Shift+P **docker:publish**, choose the same tag.
1. Wait for a while and refresh the page to confirm that the text is updated.

## SSH

1. Log in to the Azure portal at https://portal.azure.com/. Navigate to App Services and choose the web app that was created during the above scenario.
1. Choose **Advanced Tools**, and click **Go**. A new Kudu session is opened.
1. Choose **Debug console** followed by **SSH**.
1. Type `apt-get install vim -y` to install vim.
1. Type `vi message.txt`, edit the contents (e.g. append `!` by typing `A!<ESC>`) and type `ZZ` to save and exit.
1. Refresh the page.
