#!/bin/sh

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
# Custom script wrapping around scp. For my (evaryont, Colin Shea) use only, 
# really.
if [ -e ~/bin/uproot ] ; then
	uproot arson-${Arson_Version}.tar.bz2 /pub/rambling/public/projects/
fi

# Mkdir for AUR dist
mkdir aur/
cp ../contrib/arch_aur/* -t aur/
cd aur/
cat PKGBUILD | sed "s/md5sums.*/$(makepkg -g 2>/dev/null)/" > PKGBUILD
makepkg --source
mv arson-${Arson_Version}-1.src.tar.gz ../arson.tar.gz
cd ..

rm -r aur/ arson/
