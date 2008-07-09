#!/bin/zsh

# Using the files currently in the directory, this script tars up all the files into 2: arson-<version>.tar.bz2 and arson.tar.gz. arson-<version> has the core distribution while arson.tar.gz is a file ready to upload to AUR.

if [ ! -d release ] ; then
	mkdir release
fi
cd release
Arson_Version=$(ruby -e"load '../bin/arson'; puts ARSON_VERSION.join('.')")

# Mkdir for core
mkdir arson
cp ../bin/arson ../ChangeLog ../contrib/completion/arson.fish -t arson/
tar -cjf arson-${Arson_Version}.tar.bz2 arson/
if [ -e ~/bin/uproot ] ; then # Custom upload which sends to my server
	uproot arson-${Arson_Version}.tar.bz2 /pub/rambling/public/projects/
fi

# Mkdir for AUR dist
mkdir aur/
cp ../contrib/arch_aur/PKGBUILD ../contrib/arch_aur/arson.install -t aur/
cd aur/
makepkg -g &>/dev/null 1>file
cat file
rm file
echo "Using that string, please update the PKGBUILD, then press enter"
read
cp -f ../../contrib/arch_aur/PKGBUILD -t .
makepkg --source
mv arson-*.src.tar.gz ../arson.tar.gz
cd ..

rm -r aur/ arson/
