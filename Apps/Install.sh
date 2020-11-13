#!/bin/bash

sudo whoami 1&>/dev/null

rm -rf ./dl
mkdir ./dl

macOSVersion=$(sw_vers -productVersion)

if [[ $macOSVersion =~ "10.15" || $macOSVersion =~ "11.0" ]]
then
	profile="$HOME/.zprofile"
	systemAppsFolder="/System/Applications"
else
	profile="$HOME/.bash_profile"
	systemAppsFolder="/Applications"
fi

rm $profile 2&>/dev/null

# Remove current apps

echo "Killing and removing current apps..."

kill -9 $(pgrep Chrome) 2&>/dev/null
kill -9 $(pgrep Spotify) 2&>/dev/null
kill -9 $(pgrep Discord) 2&>/dev/null
kill -9 $(pgrep iTerm2) 2&>/dev/null
kill -9 $(pgrep Slack) 2&>/dev/null
kill -9 $(pgrep Docker) 2&>/dev/null
kill -9 $(pgrep eqMac2) 2&>/dev/null
kill -9 $(pgrep Steam) 2&>/dev/null
kill -9 $(pgrep Rectangle) 2&>/dev/null
kill -9 $(pgrep Code) 2&>/dev/null
kill -9 $(pgrep The\ Unarchiver) 2&>/dev/null

rm -rf /Applications/Google\ Chrome.app
rm -rf /Applications/iTerm.app
rm -rf /Applications/Discord.app
rm -rf /Applications/Slack.app
rm -rf /Applications/Visual\ Studio\ Code.app
rm -rf /Applications/Rectangle.app
rm -rf /Applications/Steam.app
rm -rf /Applications/eqMac2.app
rm -rf /Applications/The\ Unarchiver.app
rm -rf /Applications/Docker.app
rm -rf /Applications/Spotify.app

echo "Configuring Dock..."

defaults delete com.apple.dock; killall Dock
sleep 6
defaults delete com.apple.dock persistent-apps; killall Dock
sleep 6
defaults write com.apple.dock show-recents -bool FALSE; killall Dock
sleep 6
defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>$systemAppsFolder/Launchpad.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"

# Google Chrome

echo "Downloading and installing Google Chrome..."

curl -L https://dl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg -o ./dl/googlechrome.dmg 1&>/dev/null

hdiutil attach ./dl/googlechrome.dmg -quiet
cp -r /Volumes/Google\ Chrome/Google\ Chrome.app /Applications
hdiutil detach /Volumes/Google\ Chrome -quiet

defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Google Chrome.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"

# Discord

echo "Downloading and installing Discord..."

curl -L https://discord.com/api/download?platform=osx -o ./dl/Discord.dmg 1&>/dev/null

hdiutil attach ./dl/Discord.dmg -quiet
cp -r /Volumes/Discord/Discord.app /Applications
hdiutil detach /Volumes/Discord -quiet

defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Discord.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"

# Slack

echo "Downloading and installing Slack..."

curl -L https://slack.com/ssb/download-osx -o ./dl/Slack.dmg 1&>/dev/null

hdiutil attach ./dl/Slack.dmg -quiet
cp -r /Volumes/Slack.app/Slack.app /Applications
hdiutil detach /Volumes/Slack.app -quiet

defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Slack.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"

# Spotify

echo "Downloading and installing Spotify..."

curl -L https://download.scdn.co/SpotifyInstaller.zip -o ./dl/SpotifyInstaller.zip 1&>/dev/null

unzip -qq ./dl/SpotifyInstaller.zip -d dl
open ./dl/Install\ Spotify.app

echo "Waiting for Spotify Installer..."

while [[ $(pgrep Install\ Spotify) ]]
do
sleep 1
done

defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Spotify.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"

# VSCode

echo "Downloading and installing VSCode..."

curl -L https://go.microsoft.com/fwlink/?LinkID=620882 -o ./dl/VSCode-darwin-stable.zip 1&>/dev/null

unzip -qq ./dl/VSCode-darwin-stable.zip -d /Applications/

mkdir -p ~/Library/Application\ Support/Code/User
cp ./settings/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json

cat << EOF >> $profile
export PATH="\$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
EOF

defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Visual Studio Code.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"

# iTerm2

echo "Downloading and installing iTerm2..."

curl -L https://iterm2.com/downloads/stable/latest -o ./dl/iTerm2.zip 1&>/dev/null

unzip -qq ./dl/iTerm2.zip -d /Applications

cp ./settings/iterm/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist

defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/iTerm.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"

# Steam

echo "Downloading and installing Steam..."

curl -L https://steamcdn-a.akamaihd.net/client/installer/steam.dmg -o ./dl/Steam.dmg 1&>/dev/null

hdiutil attach ./dl/Steam.dmg -quiet
cp -r /Volumes/Steam/Steam.app /Applications
hdiutil detach /Volumes/Steam -quiet

# Rectangle

echo "Downloading and installing Rectangle..."

curl -L -o ./dl/Rectangle.dmg $(curl -s https://api.github.com/repos/rxhanson/Rectangle/releases/latest | grep "browser_download_url.*dmg" | cut -d '"' -f 4) 1&>/dev/null

hdiutil attach ./dl/Rectangle.dmg -quiet
cp -r /Volumes/Rectangle*/Rectangle.app /Applications
hdiutil detach /Volumes/Rectangle* -quiet
open /Applications/Rectangle.app

# eqMac2

echo "Downloading and installing eqMac2..."

hdiutil attach ./dmg/eqMac2.dmg -quiet
cp -r /Volumes/eqMac2/eqMac2.app /Applications
hdiutil detach /Volumes/eqMac2 -quiet
open /Applications/eqMac2.app

# Docker

echo "Downloading and installing Docker..."

curl -L https://download.docker.com/mac/stable/Docker.dmg -o ./dl/Docker.dmg 1&>/dev/null

hdiutil attach ./dl/Docker.dmg -quiet
cp -r /Volumes/Docker/Docker.app /Applications
hdiutil detach /Volumes/Docker -quiet

# The Unarchiver

echo "Downloading and installing The Unarchiver..."

curl -L https://dl.devmate.com/com.macpaw.site.theunarchiver/TheUnarchiver.dmg -o ./dl/TheUnarchiver.dmg 1&>/dev/null

hdiutil attach ./dl/TheUnarchiver.dmg -quiet
cp -r /Volumes/The\ Unarchiver/The\ Unarchiver.app /Applications
hdiutil detach /Volumes/The\ Unarchiver -quiet

# Nodejs

echo "Downloading and installing NVM..."

curl -o ./dl/nvm_install.sh https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh 1&>/dev/null
bash ./dl/nvm_install.sh 1&>/dev/null

cat << EOF >> $profile
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
EOF

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

echo "Installinsg NodeJS with NVM..."

nvm install node 1&>/dev/null
nvm install 12.13.1 1&>/dev/null
nvm alias default 12.13.1 1&>/dev/null

# youtube-dl

echo "Downloading and installing youtube-dl..."

sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
sudo chmod a+rx /usr/local/bin/youtube-dl

# .vimrc

echo "Writing .vimrc..."

rm ~/.vimrc

cat << EOF >> ~/.vimrc
set nu
set mouse=a
syn on
EOF

# Tor
# VLC

defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>$systemAppsFolder/System Preferences.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"

echo "Restarting Dock..."

killall Dock

rm -rf ./dl
