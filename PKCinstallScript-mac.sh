#!/bin/bash

echo -e $'\e[100m\e[39m'
echo -e $'\e[40m\n\n\t\e[39m\n\n\t +×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×+ \t\n\t +-------------------------------------------------+ \t\n\t | ×---------------------------------------------× | \t\n\t | |]                                           [| | \t\n\t | [|     \e[1m×--    Project Key Code     --×\e[21m       [| | \t\n\t | [|                                           [| | \t\n\t | [|          \e[1mCyborg Art Collective\e[21m            [| | \t\n\t | [|           \e[4mhttp://cyarco.com\e[24m               [| | \t\n\t | [|     \e[4mfacebook.com/cyborgartcollective\e[24m      [| | \t\n\t | [|     \e[4minstagram.com/cyborgartcollective\e[24m     [| | \t\n\t | |]                                           [| | \t\n\t | ×---------------------------------------------× | \t\n\t +-------------------------------------------------+ \t\n\t +×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×+\n\n\e[39m\e[100m'

mkdir log-files
mkdir saved-files

touch log-files/installation-Log.txt
touch log-files/configuration-Log.txt
touch log-files/run-Log.txt

OS=`uname -s`
REV=`uname -r`
MACH=`uname -m`
if [ "${OS}" = "Darwin" ]
    then
    OIFS="$IFS"
    IFS=$'\n'
    set `sw_vers` > /dev/null
    DIST=`echo $1 | tr "\n" ' ' | sed 's/ProductName:[ ]*//'`
    VERSION=`echo $2 | tr "\n" ' ' | sed 's/ProductVersion:[ ]*//'`
    BUILD=`echo $3 | tr "\n" ' ' | sed 's/BuildVersion:[ ]*//'`
    OSSTR="${OS} ${DIST} ${REV}(SORRY_NO_PSEUDONAME ${BUILD} ${MACH})"
    IFS="$OIFS"
fi

echo $'\n\n' >> log-files/installation-Log.txt
date '+%Y-%m-%d %H:%M:%S' >> log-files/installation-Log.txt
echo $'\n\n' >> log-files/installation-Log.txt
echo ${OSSTR} >> log-files/installation-Log.txt


echo -e $'\n\n\e[41m\e[90m\e[1m\t\e[39m!!\e[90m Make sure the MIDI kabel is \e[39mNOT\e[90m connected while installing \e[39m!!\e[90m\e[21m\e[39m\e[100m\n\n '

echo -e $'\n\e[41m\e[90m\e[1m\t --- Type your computers password to start the installation --- \e[21m\e[39m\e[100m\n '
sudo touch log-files/sudo-Log.txt
sudo rm -rf log-files/sudo-Log.txt

echo '------------------------------------------------' >> log-files/installation-Log.txt

echo $'\n Preparing installation...\n'
echo $'\n------ Preparing installation...  ------ \n' >> log-files/installation-Log.txt

echo '------------------------------------------------'
echo '================================================'
echo 'Unpacking Project Key Code script'
echo '================================================'

if [ $(find ./ -name PKC | wc -l) -gt 0 ]
then

  echo $'\n\t ------ Project Key Code script already unpacked ------ \n ' 2>&1 | tee -a log-files/installation-Log.txt
else

  echo $'\n\t ------ Unpacking Project Key Code script ------ \n ' >> log-files/installation-Log.txt
  tar xvzf PKC.tar.gz 2>&1 | tee -a log-files/installation-Log.txt

fi

mv PKC/run_program.command ./ 2>&1 | tee -a log-files/installation-Log.txt
mv PKC/update.sh ./ 2>&1 | tee -a log-files/installation-Log.txt
mv PKC/uninstall.sh ./ 2>&1 | tee -a log-files/installation-Log.txt
mv PKC/Passport.txt ./saved-files 2>&1 | tee -a log-files/installation-Log.txt
mv PKC/CyArCo-dict ./saved-files 2>&1 | tee -a log-files/installation-Log.txt

chmod 755 run_program.command 2>&1 | tee -a log-files/installation-Log.txt
chmod 755 PKC/PKC-keyboardconfiguration.py 2>&1 | tee -a log-files/installation-Log.txt
chmod 755 PKC/ProjectKeyCode.py 2>&1 | tee -a log-files/installation-Log.txt
chmod 755 PKC/_httprootPKC/server.js 2>&1 | tee -a log-files/installation-Log.txt
chmod 755 update.sh 2>&1 | tee -a log-files/installation-Log.txt
chmod 755 uninstall.sh 2>&1 | tee -a log-files/installation-Log.txt

echo '------------------------------------------------'
echo '================================================'
echo 'installing homebrew...'
echo '================================================'
echo $'\n\t ------ Homebrew  ------ \n' >> log-files/installation-Log.txt

if [ $(find /usr/local/bin -name brew | wc -l) -gt 0 ]
then
   echo $'\n\tHomebrew already installed\n'
   echo $'Homebrew already installed' >> log-files/installation-Log.txt
   brew --version 2>&1 | tee -a log-files/installation-Log.txt
else
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" 2>&1 | tee -a log-files/installation-Log.txt
  export PATH="/usr/local/bin:$PATH" >> ~/.bash_profile
fi

brew update 2>&1 | tee -a log-files/installation-Log.txt
brew doctor 2>&1 | tee -a log-files/installation-Log.txt

echo '------------------------------------------------'
echo '================================================'
echo 'installing python2...'
echo '================================================'
echo $'\n\t ------ python2 ------ \n' >> log-files/installation-Log.txt

if [ $(find /usr/local/bin -name python2 | wc -l) -gt 0 ]
then
   echo $'\n\tPython2 already installed\n'
   echo $'Python2 already installed' >> log-files/installation-Log.txt
   python2 --version 2>&1 | tee -a log-files/installation-Log.txt
else
  yes | brew install python2 2>&1 | tee -a log-files/installation-Log.txt
  sudo yes | python -m ensurepip 2>&1 | tee -a log-files/installation-Log.txt
fi

echo '------------------------------------------------'
echo '================================================'
echo 'installing pygame...'
echo '================================================'
echo $'\n\t ------ pygame ------ \n' >> log-files/installation-Log.txt

if [ $(brew list | grep -F sdl | wc -l) -gt 0 ]
  then
  echo $'\n\tSDL already installed\n'
  echo $'SDL already installed' >> log-files/installation-Log.txt
  brew list | grep -F sdl 2>&1 | tee -a log-files/installation-Log.txt
else
  yes | brew install sdl 2>&1 | tee -a log-files/installation-Log.txt
fi

if [ $(brew list | grep -F sdl_image | wc -l) -gt 0 ]
  then
  echo $'\SDL_image check'
else
  yes | brew install sdl_image 2>&1 | tee -a log-files/installation-Log.txt
fi

if [ $(brew list | grep -F sdl_mixer | wc -l) -gt 0 ]
  then
  echo $'\SDL_mixer check'
else
  yes | brew install sdl_mixer 2>&1 | tee -a log-files/installation-Log.txt
fi

if [ $(brew list | grep -F sdl_ttf | wc -l) -gt 0 ]
  then
  echo $'\SDL_ttf check'
else
  yes | brew install sdl_ttf 2>&1 | tee -a log-files/installation-Log.txt
fi

if [ $(brew list | grep -F portmidi | wc -l) -gt 0 ]
  then
  echo $'\tportmidi already installed'
  echo $'portmidi already installed' >> log-files/installation-Log.txt
  brew list | grep -F portmidi 2>&1 | tee -a log-files/installation-Log.txt
else
  yes | brew install portmidi 2>&1 | tee -a log-files/installation-Log.txt
fi

if [ $(brew list | grep -F mercurial | wc -l) -gt 0 ]
  then
  echo $'\tmercurial already installed'
  echo $'mercurial already installed' >> log-files/installation-Log.txt
  brew list | grep -F mercurial 2>&1 | tee -a log-files/installation-Log.txt
else
  yes | brew install mercurial 2>&1 | tee -a log-files/installation-Log.txt
fi

if [ $(pip2 list | grep -F pygame | wc -l) -gt 0 ]
  then
  echo $'\tpygame already installed'
  echo $'pygame already installed' >> log-files/installation-Log.txt
  pip2 list | grep -F pygame 2>&1 | tee -a log-files/installation-Log.txt
else
  sudo yes | pip2 install hg+http://bitbucket.org/pygame/pygame 2>&1 | tee -a log-files/installation-Log.txt
  sudo yes | pip2 install numpy 2>&1 | tee -a log-files/installation-Log.txt
fi

echo '------------------------------------------------'
echo '================================================'
echo 'installing jack...'
echo '================================================'
echo $'\n\t ------ jack ------ \n' >> log-files/installation-Log.txt

if [ $(brew list | grep -F jack | wc -l) -gt 0 ]
  then
  echo $'\n\tjack already installed\n'
  echo $'jack already installed' >> log-files/installation-Log.txt
  brew list | grep -F jack 2>&1 | tee -a log-files/installation-Log.txt
else
  yes | brew install jack 2>&1 | tee -a log-files/installation-Log.txt
fi
echo '------------------------------------------------'
echo '================================================'
echo 'installing Socketio_client...'
echo '================================================'
echo $'\n\t ------ Socketio_client ------ \n' >> log-files/installation-Log.txt

if [ $(pip2 list | grep -F socketIO-client | wc -l) -gt 0 ]
  then
    echo $'\n\tSocketio_client already installed\n'
    echo $'Socketio_client already installed' >> log-files/installation-Log.txt
    pip2 list | grep -F socketIO-client 2>&1 | tee -a log-files/installation-Log.txt
else
  sudo yes | pip2 install Socketio_client 2>&1 | tee -a log-files/installation-Log.txt
fi

echo '------------------------------------------------'
echo '================================================'
echo 'installing NodeJS...'
echo '================================================'
echo $'\n\t ------ NodeJS ------ \n' >> log-files/installation-Log.txt

if [ $(find /usr/local/bin -name node | wc -l) -gt 0 ]
then
   echo $'\n\tNodeJS already installed\n'
   echo $'NodeJS already installed' >> log-files/installation-Log.txt
   node -v  2>&1 | tee -a log-files/installation-Log.txt
   npm -v  2>&1 | tee -a log-files/installation-Log.txt
else
  cd PKC/_httprootPKC
  yes | brew install node 2>&1 | tee -a ../../log-files/installation-Log.txt
  npm install --save express@4.16.3 2>&1 | tee -a ../../log-files/installation-Log.txt
  npm install --save fs 2>&1 | tee -a ../../log-files/installation-Log.txt
  npm install --save socket.io@1.7.2 2>&1 | tee -a ../../log-files/installation-Log.txt
  cd ../..
fi

echo $'\n\t ------ Shortcut ------ ' >> log-files/installation-Log.txt
echo '------------------------------------------------'
echo -e '================================================\e[41m\e[90m\e[1m'
echo -n "Do you want a shortcut to Project Key Code on your Desktop [y/n]?"
read answer
if [ "$answer" != "${answer#[Yy]}" ]
  then
  echo -e '\e[21m\e[39m\e[100m'
  echo $'\n\tYes' >> log-files/installation-Log.txt
  echo '================================================'
  echo $'\t~/Desktop/run_program.command To '$PWD >> log-files/installation-Log.txt
  echo $'\n\tlink FROM:~/Desktop/run_program.command\n\tTo '$PWD
  (
    echo $'#!/bin/bash\n'
    echo "$PWD"$'/run_program.command' | sed 's/ /\\ /g'
  ) > ~/Desktop/run_Project-Key-Code.command
  chmod 755 ~/Desktop/run_Project-Key-Code.command 2>&1 | tee -a log-files/installation-Log.txt
else
  echo -e '\e[21m\e[39m\e[100m'
  echo $'\n\tNo' >> log-files/installation-Log.txt
  echo '================================================'
fi

echo $'\n------------------------------------------------'
echo '================================================'
echo $'all done,\n\n\tProject_Key_Code-run >\t\tto start program \n\t-first time it will start the keyboard configuration-\n\n\tPKC_keyboard_configuration >\tto re-configur keyboard settings\n\tPKC_alphabet_configuration >\tto re-configur the alphabet for chord-character translation'
echo '================================================'

echo $'\n\t ------ Brew modual list ------ ' >> log-files/installation-Log.txt
brew list 2>&1 | tee -a log-files/installation-Log.txt

echo $'\n\t ------ Python modual list ------ ' >> log-files/installation-Log.txt
pip2 list 2>&1 | tee -a log-files/installation-Log.txt

echo $'\n\t ------ NodeJS modual list ------ ' >> log-files/installation-Log.txt
cd PKC/_httprootPKC
npm list 2>&1 | tee -a ../../log-files/installation-Log.txt
cd ../..

echo -e $'\n\n\e[41m\e[90m\e[1m\t---!! Connect the MIDI kabel before starting the program !!---\e[21m\e[39m\e[100m\n\n\\e[41m\e[90m\e[1m'

echo -n "Do you want to start Project Key Code [y/n]?"
read answer
if [ "$answer" != "${answer#[Yy]}" ]
  then
  echo -e '\e[21m\e[39m\e[100m'
  ./run_program.command
else
  echo -e '\e[21m\e[39m\e[100m'
  osascript -e 'tell application "Terminal" to quit'
fi
