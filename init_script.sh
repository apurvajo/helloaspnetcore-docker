#!/bin/bash

service ssh start

DIR=/out
DLL=`ls -1 *.csproj | head -1 | sed -e 's/\.csproj$/.dll/'`

if [ -z DLL ]; then
  echo Could not find .csproj. Using default value.
  DLL=helloaspnetcore.dll
fi

echo Launching: $DIR/$DLL

exec dotnet $DIR/$DLL
