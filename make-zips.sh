#!/bin/bash

TUWCU=TUWcurriculum
FONTS=TUWfonts
BUILD=build
ZIP=TUWcurriculum.zip
ZIPF=TUWcurriculum-with-fonts.zip
ZIPFILES="$TUWCU $TUWCU-README.md"

[ -d "$TUWCU" ] || { echo "folder '$TUWCU' not found"; exit 1; }
[ ! -d "$BUILD" ] || { echo "remove '$BUILD' before running this script"; exit 1; }

rm -f "$ZIP" "$ZIPF"
mkdir "$BUILD"
cp -a "$TUWCU" "$BUILD"/"$TUWCU"
cp -a README.md "$BUILD"/"$TUWCU"-README.md
cd "$BUILD"
zip -r ../"$ZIP" $ZIPFILES
cp -a ../"$FONTS"/* "$TUWCU"/"$FONTS"
zip -r ../"$ZIPF" $ZIPFILES 
cd ..
rm -rf "$BUILD"
