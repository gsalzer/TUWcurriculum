# TUWcurriculum: a LaTeX class to typeset the curricula of TU Wien

**Note:** In the public repository, the folder `TUWcurriculum/TUWfonts`
is empty except for `README.txt`. If you have received this README as
part of `TUWcurriculum-with-fonts.zip`, the fonts are included.

## Installation

There are three possibilities.

1. *For a single curriculum:*
   - Move the *contents* of the folder `TUWcurriculum` (not the folder
     itself) into the folder with the main file of the curriculum.

2. *For several curricula:*
   - Move the *contents* of the folder `TUWcurriculum` (not the folder
     itself) into a folder *F* somewhere, where you want the common files to reside.
   - Copy the file *F*`/TUWcurriculum-link.cls` into each folder
     containing a curriculum and rename it to `TUWcurriculum.cls`.
     This file contains just an `\input` statement loading the real
     `TUWcurriculum.cls`. Adapt the path such that it reads, for example
     `\input{../../`*F*`}`.

3. *For general accessibility:*
   - Find out, where your TeX distribution searches for personal LaTeX
     packages. For TeXlive and Linux, this is the folder
     `$HOME/texmf/tex/latex`.
   - Move the entire folder `TUWcurriculum` there.
   
   If you want to use the TUW fonts as well:
   - Find out, where your TeX distribution searches for personal truetype
     fonts.  For TeXlive and Linux, this is the folder
     `$HOME/texmf/fonts/truetype`.
   - Move the folder `TUWcurriculum/TUWfonts` there (remember that you
     have moved it together with `TUWcurriculum` in the step above).
   - Update the font index. For TeXlive and Linux, run the
     command `updmap-user`.
     
