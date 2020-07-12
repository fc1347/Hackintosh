#!/bin/bash

mkdir ./dl

rm ~/.bash_profile

# Nodejs

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

cat << EOF >> ~/.bash_profile
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
EOF

nvm install node

# .vimrc

rm ~/.vimrc

cat << EOF >> ~/.vimrc
set nu
set mouse=a
syn on
EOF

# VSCode

unzip ./vscode/VSCode-darwin-stable.zip -d /Applications/

mkdir -p ~/Library/Application\ Support/Code/User
cp ./vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json

cat << EOF >> ~/.bash_profile
export PATH="\$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
EOF

# Rectangle

hdiutil attach ./dmg/Rectangle*.dmg
cp -r /Volumes/Rectangle*/Rectangle.app /Applications
hdiutil detach /Volumes/Rectangle*
open /Applications/Rectangle.app

# Discord

curl -L https://discord.com/api/download?platform=osx -o ./dl/Discord.dmg

hdiutil attach ./dmg/Discord.dmg
cp -r /Volumes/Discord/Discord.app /Applications
hdiutil detach /Volumes/Discord

# Steam

curl -L https://steamcdn-a.akamaihd.net/client/installer/steam.dmg -o ./dl/Steam.dmg
hdiutil attach ./dmg/Steam.dmg
cp -r /Volumes/Steam/Steam.app /Applications
hdiutil detach /Volumes/Steam

# iTerm2

curl -L https://iterm2.com/downloads/stable/latest -o ./dl/iTerm2.zip
unzip ./dl/iTerm2.zip -d /Applications

# eqMac2

hdiutil attach ./dmg/eqMac2.dmg
cp -r /Volumes/eqMac2/eqMac2.app /Applications
hdiutil detach /Volumes/eqMac2
open /Applications/eqMac2.app

# TheUnarchiver

curl -L https://dl.devmate.com/com.macpaw.site.theunarchiver/TheUnarchiver.dmg -o ./dl/TheUnarchiver.dmg
hdiutil attach ./dl/TheUnarchiver.dmg
cp -r /Volumes/The\ Unarchiver/The\ Unarchiver.app /Applications
hdiutil detach /Volumes/The\ Unarchiver

# Docker

curl -L https://download.docker.com/mac/stable/Docker.dmg -o ./dl/Docker.dmg
hdiutil attach ./dl/Docker.dmg
cp -r /Volumes/Docker/Docker.app /Applications
hdiutil detach /Volumes/Docker

# Slack

curl -L https://slack.com/ssb/download-osx -o ./dl/Slack.dmg
hdiutil attach ./dl/Slack.dmg
cp -r /Volumes/Slack.app/Slack.app /Applications
hdiutil detach /Volumes/Slack.app

# Spotify
# Tor
# VLC

rm -rf ./dl