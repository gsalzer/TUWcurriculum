#!/bin/bash

VERSION="$1"
TUWCU=TUWcurriculum

[ "$VERSION" ] || { echo "please specify version"; exit 1; }
[ -d "$TUWCU" ] || { echo "folder '$TUWCU' not found"; exit 1; }

YEAR="${VERSION/.*/}"

cd "$TUWCU"
for f in ModuleExample.tex ModuleTemplate.tex TUWbachelor.tex TUWcurriculum.cls TUWdeckblatt.tex TUWmaster.tex TUWmodul.tex TUWAoMaster.tex; do
    echo
    echo "*** $f ***"
    sed "s/TU Wien Curriculum [0-9.]*/TU Wien Curriculum $VERSION/" "$f" > tmp
    diff "$f" tmp
    mv tmp "$f"
done
