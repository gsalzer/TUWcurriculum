%% TU Wien Curriculum 2023.8
%% Copyright 2023 G. Salzer
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   https://www.latex-project.org/lppl.txt
% and version 1.3c or later is part of all distributions of LaTeX
% version 2008 or later.
%
% This work has the LPPL maintenance status `maintained'.
% 
% The Current Maintainer of this work is G. Salzer, gernot.salzer@tuwien.ac.at
%
% This work consists of the file TUWcurriculum.cls.

% Make the path of the current file the new \input@path
\@ifundefined{currfiledir}{%
  \RequirePackage{currfile}
  \input{TUWcurriculum.cls}
  \endinput
}{}
\edef\input@path{{\currfiledir}{module/}{../shared/}{../../shared/}{../../../shared/}}

% Class stuff
\ProvidesClass{TUWcurriculum}[TU Wien Curriculum 2023.8]
\RequirePackage{xcolor}
\LoadClass[a4paper,12pt]{scrartcl}
\setcounter{tocdepth}{1}
\setkomafont{sectionentry}{}
\setkomafont{sectionentrypagenumber}{}
\newif\ifTUDECKBLATT
\newif\ifENTWURF
\newif\if@ENGLISCH
\newcommand\ifENGLISCHSPRACHIG[2]{\if@ENGLISCH#1\else#2\fi}
\newif\if@POSTFIXMARKE
\newcommand*\PostfixMarkierungen{\@POSTFIXMARKEtrue}
\newcommand*\PrefixMarkierungen{\@POSTFIXMARKEfalse}
\newif\if@DASEMINAR
\newcommand\ifDASEMINAR[2]{\if@DASEMINAR#1\else#2\fi}
\newif\if@Modulverantwortliche
\newcommand\ifModulverantwortliche[2]{\if@Modulverantwortliche#1\else#2\fi}
\newif\if@MSC
\newcommand\ifMSC[2]{\if@MSC#1\else\#2\fi}
\DeclareOption{Modulverantwortliche}{\@Modulverantwortlichetrue}
\DeclareOption{tudeckblatt}{\TUDECKBLATTtrue}
\DeclareOption{entwurf}{\ENTWURFtrue}
\DeclareOption{postfix}{\PostfixMarkierungen}
\DeclareOption{englischsprachig}{\@ENGLISCHtrue}
\DeclareOption{daseminar}{\@DASEMINARtrue}
\DeclareOption{msc}{\@MSCtrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}
\ProcessOptions\relax
\renewcommand\documentclass[2][]{}

%https://tex.stackexchange.com/questions/567526
\RequirePackage{etoolbox}
\apptocmd\appendix{\pretocmd\section{\clearpage}{}{}}{}{}

% Language, fonts, and encodings
\RequirePackage[english,naustrian]{babel}
\shorthandon{"}
\usepackage{iftex}
\ifTUDECKBLATT
  \ifPDFTeX
    \typeout{%
      ^^J
      ***************************************************^^J
      * Die Option "tudeckblatt" kann nicht zusammen \space\space\space*^^J
      * mit "pdflatex" verwendet werden. \space\space\space\space\space\space\space\space\space\space\space\space\space\space\space*^^J
      * Verwende stattdessen "xelatex" oder "lualatex", *^^J
      * oder entferne die Option "tudeckblatt". \space\space\space\space\space\space\space\space*^^J
      ***************************************************^^J
    }%
    \expandafter\expandafter\expandafter\stop
  \fi
\fi
\ifPDFTeX
  \RequirePackage[T1]{fontenc}
  \RequirePackage[utf8]{inputenc}
  \RequirePackage{lmodern}
\else
  \ifXeTeX
    \usepackage{fontspec}
  \else 
    \usepackage{luatextra}
  \fi
  \defaultfontfeatures{Ligatures=TeX}
\fi

\ifENTWURF
  \RequirePackage{pdfdraftcopy}
  \draftangle{65}
  \draftfontsize{180}
  \draftstring{ENTWURF}
\else
  \sloppy
\fi

\RequirePackage{microtype}

\RequirePackage{environ}
\RequirePackage{datetime}
\RequirePackage{enumitem}
\setlist[itemize]{noitemsep}
\setlist[itemize,1]{label={\scriptsize\raisebox{0.5ex}{\textbullet}}}
\RequirePackage{tikz}
\usetikzlibrary{positioning,shapes,calc}
\RequirePackage{csvsimple}
\RequirePackage{booktabs}
\RequirePackage{rotating}
\RequirePackage{tcolorbox}

% Kuerzerer Unterstrich beim Gendern
\RequirePackage{relsize}
\renewcommand{\_}{\textscale{.7}{\textunderscore}}

\RequirePackage{hyperref}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INFRASTRUKTUR
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% \applytolist{code for processing item}{something expanding to a comma-separated list of values}
\newcommand\applytolist[2]{%
  \def\@applytolist@list{}%
  \def\@processitem{#1}%
  \edef\@tmp{#2}%
  \expandafter\@applytolist\@tmp,\@end,%
  \@applytolist@list
}
\def\@end{\@end}
\newcommand*\@applytolist{}
\def\@applytolist#1,{%
  \ifx\@end#1\relax
    \let\@applytolist@next\relax
  \else
    \let\@applytolist@next\@applytolist
    \ifx\relax#1\relax
    \else
      \expandafter\g@addto@macro\expandafter\@applytolist@list\expandafter{\@processitem{#1}}%
      \expandafter\expandafter\expandafter
    \fi
  \fi
  \@applytolist@next
}

\newcommand\TUWdef[3]{\expandafter\gdef\csname TUW:#2:#3\endcsname{#1}}
\newcommand\TUWadd[3]{\expandafter\g@addto@macro\csname TUW:#2:#3\endcsname{#1}}
\newcommand*\TUWuse[2]{\csname TUW:#1:#2\endcsname}
\newcommand\TUWifdef[4]{%
  \expandafter\expandafter\expandafter\ifx\TUWuse{#1}{#2}\relax
    #4%
  \else
    \expandafter\expandafter\expandafter\ifx\TUWuse{#1}{#2}\empty
      #4%
    \else
      #3%
    \fi
  \fi
}

\newif\ifAtLeastOne
\newcommand\TUWifAtLeastOne[4]{%
  \AtLeastOnefalse
  \applytolist{\@TUWifAtLeastOne{#1}}{#2}%
  \ifAtLeastOne
    #3%
  \else
    #4%
  \fi
}
\newcommand*\@TUWifAtLeastOne[2]{%
  \expandafter\expandafter\expandafter\ifx\TUWuse{#1}{#2}\relax
  \else
    \expandafter\expandafter\expandafter\ifx\TUWuse{#1}{#2}\empty
    \else
      \AtLeastOnetrue
    \fi
  \fi
}

\newcommand\TUWdefifundef[3]{%
  \TUWifdef{#2}{#3}{%
    \ifx\relax#2\relax
      \@TUW@warning{Feld '#3' wird zum zweiten Mal definiert}%
    \else
      \@TUW@warning{Feld '#3' des Moduls '#2' wird zum zweiten Mal definiert}%
    \fi
  }{%
    \TUWdef{#1}{#2}{#3}%
  }%
}

\newcommand*\TUWuseifdef[2]{%
  \TUWifdef{#1}{#2}{%
    \TUWuse{#1}{#2}%
  }{%
    \ifx\relax#1\relax
      \@TUW@warning{Feld '#2' ist undefiniert}%
    \else
      \@TUW@warning{Feld '#2' des Moduls '#1' ist undefiniert}%
    \fi
  }%
}

\newcommand*\TUWnewcmd[3]{\expandafter\def\csname #3\endcsname##1{\TUWdef{##1}{#1}{#2#3}}}
\newcommand*\TUWnewenv[3]{\TUWifdef{#1}{#2#3}{}{\TUWdef{}{#1}{#2#3}}\NewEnviron{#3}{\expandafter\TUWadd\expandafter{\BODY}{#1}{#2#3}}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MODULE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand*\MODdefthis{\xdef\MODthis}
\newcommand*\MODnewcmd[1][]{\TUWnewcmd\MODthis{#1}}
\newcommand*\MODnewenv[1][]{\TUWnewenv\MODthis{#1}}
\newcommand*\MVAR{\TUWuseifdef{\MODthis}}
\newcommand*\ifMDEF{\TUWifAtLeastOne{\MODthis}}
\newcommand*\MODmarkAsUsed[1]{%
  \TUWdef{yes}{#1}{@used}%
  \immediate\write\@mainaux{\string\TUWdef{yes}{#1}{@used}}%
}

\newenvironment{Modul}{
  \ModulBeginHook
  \MODnewcmd{Titel}
  \MODnewcmd{Ects}
  \MODnewcmd{Redaktion}
  \MODnewcmd{Version}
  \MODnewenv{Kurzbeschreibung}
  \newenvironment{Kompetenzen}{
    \MODnewenv[Kompetenzen]{Intro}
    \MODnewenv[Kompetenzen]{FachlichMethodisch}
    \MODnewenv[Kompetenzen]{KognitivPraktisch}
    \MODnewenv[Kompetenzen]{SozialSelbst}
  }{}
  \MODnewenv{Inhalt}
  \newenvironment{ErwarteteVorkenntnisse}{
    \MODnewenv[Vorkenntnisse]{Intro}
    \MODnewenv[Vorkenntnisse]{FachlichMethodisch}
    \MODnewenv[Vorkenntnisse]{KognitivPraktisch}
    \MODnewenv[Vorkenntnisse]{SozialSelbst}
    \MODnewenv{Vormodule}
  }{}
  \MODnewenv{VerpflichtendeVoraussetzungen}
  \MODnewenv{LehrLernformenBeurteilung}
  \MODnewenv{Lehrveranstaltungen}
}{
  \aftergroup\ModulEndHook
}

\newcommand*\ModulBeginHook{\MODdefthis{\jobname}}
\newcommand*\ModulEndHook{
  \LVcsv{lvas.csv}
  \renewcommand*\@MODTitel[2]{$\langle$Titel des Moduls "`##2"'$\rangle$}
  \MODmarkAsUsed{\MODthis}
  \begin{document}
    \noindent
    \MODTitelEcts{\MODthis}

    \noindent\rule{\textwidth}{1pt}

    \MODKurzbeschreibung{\MODthis}

    \noindent\rule{\textwidth}{1pt}

    \MODLangbeschreibung{\MODthis}
  \end{document}
}

\newcommand*\MODTitelEcts[2][]{%
  \smallskip
  \applytolist{\par\noindent\@MODTitelEcts{#1}}{#2}%
  \par
}
\newcommand*\@MODTitelEcts[2]{%
  \TUWifdef{#2}{Titel}{%
    \@MODTitelOhneEcts{#1}{#2}%
    \TUWifdef{#2}{Ects}{%
      \ (\ECTS{\TUWuse{#2}{Ects}})%
    }{}%
  }{%
    \@TUW@error{Modul '#2' unbekannt}%
    ?????? (\ECTS{??})%
  }%
}

\newcommand*\MODTitelOhneEcts[2][]{%
  \smallskip
  \applytolist{\par\noindent\@MODTitelOhneEcts{#1}}{#2}%
  \par
}

\newcommand*\MODTitelOhneEctsA[2][]{%
  \applytolist{\par\noindent\@MODTitelOhneEcts{#1}}{#2}%
}

\newif\ifInSammleMODs
\newenvironment{SammleMODs}{%
  \gdef\MODSammlung{}%
  \InSammleMODstrue
}{}
\newcommand*\addto@MODSammlung[1]{%
  \g@addto@macro\MODSammlung{,#1}%
}

\newcommand*\@MODTitelOhneEcts[2]{%
  \TUWifdef{#2}{Titel}{%
    \MODmarkAsUsed{#2}%
    \ifInSammleMODs
      \TUWdef{#1}{#2}{Marke}%
      \addto@MODSammlung{#2}%
    \fi
    \if@POSTFIXMARKE\else
      \makebox[0em][r]{#1}%
    \fi
    \TUWuse{#2}{Titel}%
    \if@POSTFIXMARKE
      #1%
    \fi
  }{%
    \@TUW@error{Modul '#2' unbekannt}%
    ??????%
  }%
}

\newcommand*\MODTitel[2][]{%
  \def\@sep{\def\@sep{, }}%
  \applytolist{\@sep\@MODTitel{#1}}{#2}%
}
\newcommand*\@MODTitel[2]{%
  \TUWifdef{#2}{Titel}{%
    \MODmarkAsUsed{#2}%
    \if@POSTFIXMARKE\else#1\fi
    \TUWuse{#2}{Titel}%
    \if@POSTFIXMARKE#1\fi
  }{%
    \@TUW@error{Modul '#2' unbekannt}%
    ??????%
  }%
}

\newcommand*\MODEcts[2][]{%
  \TUWifdef{#2}{Ects}{%
    \if@POSTFIXMARKE\else#1\fi
    \TUWuse{#2}{Ects}%
    \if@POSTFIXMARKE#1\fi
  }{%
    \@TUW@error{Modul '#2' unbekannt}%
    ??????%
  }%
}

\newcommand*\MODKurzbeschreibung[2][]{%
  \applytolist{\@MODKurz{#1}}{#2}%
}
\newcommand*\@MODKurz[2]{%
  \TUWifdef{#2}{@used}{%
    \medskip\par\noindent
    {\bfseries\boldmath
     \@MODTitelEcts{#1}{#2}%
    }%
   \ 
   \TUWifdef{#2}{Kurzbeschreibung}{%
     \TUWuse{#2}{Kurzbeschreibung}%
   }{
     \TUWifdef{#2}{KompetenzenIntro}{%
       \TUWuse{#2}{KompetenzenIntro}%
     }{
       \TUWuse{#2}{KompetenzenFachlichMethodisch}%
     }%
   }%
    \par
  }{%
    \@TUW@warning{Modul '#2' scheint nicht verwendet zu werden, daher wird keine Kurzbeschreibung generiert. Falls diese Meldung beim nächsten Durchlauf nicht verschwindet, liegt ein Problem vor, dem du nachgehen solltest.}%    
  }%
}

\newcommand*\MODLangbeschreibung[2][]{%
  \applytolist{\@MODLang{#1}}{#2}%
}
\newcommand*\@MODLang[2]{%
  \TUWifdef{#2}{@used}{%
    \MODdefthis{#2}%
    \@TUW@info{Langbeschreibung '#2'}%
    \input{TUWmodul}%
  }{%
    \@TUW@warning{Modul '#2' scheint nicht verwendet zu werden, daher wird keine Langbeschreibung generiert. Falls diese Meldung beim nächsten Durchlauf nicht verschwindet, liegt ein Problem vor, dem du nachgehen solltest.}%    
  }%
}

\newcommand*\LadeModule[1]{%
  \def\@LadeModule{}%
  \applytolist\@@LadeModule{#1}%
  \@LadeModule
}
\newcommand\@@LadeModule[1]{%
  \g@addto@macro\@LadeModule{\LadeModul{#1}}%
}
\newcommand*\LadeModul[1]{\MODdefthis{#1}\input{#1.tex}}

\renewcommand*\paragraph[1]%
  {\medskip\par\noindent\textbf{#1}\ \nopagebreak}
\renewcommand*\subparagraph[1]%
  {\smallskip\par\noindent\textit{#1}\ \nopagebreak}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CURRICULUM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand*\CURnewcmd[1][]{\TUWnewcmd{}{#1}}
\newcommand*\CURnewenv[1][]{\TUWnewenv{}{#1}}
\newcommand*\VAR{\TUWuseifdef{}}
\newcommand*\ifDEF{\TUWifAtLeastOne{}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PRUEFUNGSFACH
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcounter{pf}
\newcommand*\PFSammlung{}
\newcommand*\addto@PFSammlung[1]{\g@addto@macro\PFSammlung{,#1}}

\newenvironment{Pruefungsfach}[2][]{%
  \stepcounter{pf}%
  \edef\PFthis{@pf\roman{pf}}%
  \expandafter\addto@PFSammlung\expandafter{\PFthis}%
  \TUWdef{#1}{\PFthis}{Marke}%
  \TUWdef{#2}{\PFthis}{Titel}%
  \@Pruefungsfach
}{%
  \end{SammleMODs}%
  \expandafter\TUWdef\expandafter{\MODSammlung}{\PFthis}{Module}%
}

\newcommand\@Pruefungsfach[1][]{%
  \TUWdef{#1}{\PFthis}{Ects}%
  \subsubsection*{%
      \boldmath
      \if@POSTFIXMARKE\else
        \makebox[0em][r]{\TUWuse{\PFthis}{Marke}}%
      \fi
      \TUWuse{\PFthis}{Titel}%
      \if@POSTFIXMARKE
        \TUWuse{\PFthis}{Marke}%
      \fi
      \TUWifdef{\PFthis}{Ects}{\ (\ECTS{\TUWuse{\PFthis}{Ects}})}{}%
   }%
  \begin{SammleMODs}%
}

\newcommand*\doPF[1]{%
  \subsection*{%
    Prüfungsfach "`\TUWuse{#1}{Titel}"'%
    \TUWifdef{#1}{Ects}{\ (\ECTS{\TUWuse{#1}{Ects}})}{}%
  }
  \applytolist{\doMOD}{\TUWuse{#1}{Module}}
}

\newcommand*\doMOD[1]{%
  \medskip\par\noindent
  \textbf{\sffamily
    \if@POSTFIXMARKE\else
      \makebox[0em][r]{\TUWuse{#1}{Marke}}%
    \fi
    Modul "`\TUWuse{#1}{Titel}"'%
    \if@POSTFIXMARKE
      \TUWuse{#1}{Marke}%
    \fi
    \TUWifdef{#1}{Ects}{\ (\ECTS{\TUWuse{#1}{Ects}})}{}%
  }%
  \nopagebreak
  \LVEctsSstTypTitel{\TUWuse{#1}{LVs}}
}

\newcommand*\PFsMODsLVs{\applytolist{\doPF}{\PFSammlung}}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BACHELOR
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newenvironment{Bachelor}[1][TUWbachelor]{
  \gdef\TUWbachelor{#1}
  \BachelorBeginHook
  \CURnewcmd{Titel}
  \CURnewcmd{Kennzahl}
  \CURnewcmd{Ects}
  \CURnewcmd{Dauer}
  \CURnewcmd{Art}
  \CURnewcmd{GueltigAb}
  \CURnewcmd{Beschlossen}
  \CURnewcmd{Version}
  \CURnewcmd{Redaktion}
  \CURnewcmd{Fakultaet}
  \CURnewcmd{Module}
  \CURnewcmd{ExterneModule}
  \newenvironment{Qualifikationsprofil}{%
    \CURnewenv{Intro}
    \CURnewenv{Taetigkeiten}
    \CURnewenv{FachlichMethodisch}
    \CURnewenv{KognitivPraktisch}
    \CURnewenv{SozialSelbst}
    \CURnewenv{Vertiefungen}
  }{}
  \CURnewenv{Zulassung}
  \CURnewenv{Pruefungsfaecher}
  \CURnewenv{Modulkurzbeschreibungen}
  \CURnewenv{Modullangbeschreibungen}
  \CURnewenv{PruefungsordnungAbschlusszeugnis}
  \CURnewenv{PruefungsordnungVertiefungen}
  \CURnewenv{Teilgenommen}
  \CURnewenv{EinstiegSommer}
  \CURnewenv{Mobilitaet}
  \CURnewenv{Studierbarkeit}
  \CURnewenv{Steop}
  \CURnewenv{AlleVerpflichtendenVoraussetzungen}
  \CURnewenv{Bachelorarbeit}
  \CURnewenv{Qualitaetsmanagement}
  \CURnewenv{Semestereinteilung}
  \CURnewenv{SemestereinteilungSchief}
  \CURnewenv{Uebergangsbestimmungen}
  \CURnewenv{Anhang}
}{
  \aftergroup\BachelorEndHook
}

\newcommand*\BachelorBeginHook{
  \global\let\ModulBeginHook\relax
  \global\let\ModulEndHook\relax
}
\newcommand*\BachelorEndHook{
  \ifDEF{Module}{\LadeModule{\VAR{Module}}}{}
  \ifDEF{ExterneModule}{\LadeModule{\VAR{ExterneModule}}}{}
  \LVcsv{lvas.csv}
  \input{\TUWbachelor}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MASTER
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newenvironment{Master}[1][TUWmaster]{
  \gdef\TUWmaster{#1}
  \MasterBeginHook
  \CURnewcmd{Titel}
  \CURnewcmd{Kennzahl}
  \CURnewcmd{Ects}
  \CURnewcmd{Dauer}
  \CURnewcmd{Art}
  \CURnewcmd{GueltigAb}
  \CURnewcmd{Beschlossen}
  \CURnewcmd{Version}
  \CURnewcmd{Redaktion}
  \CURnewcmd{Fakultaet}
  \CURnewcmd{Module}
  \CURnewcmd{ExterneModule}
  \newenvironment{Qualifikationsprofil}{%
    \CURnewenv{Intro}
    \CURnewenv{Taetigkeiten}
    \CURnewenv{FachlichMethodisch}
    \CURnewenv{KognitivPraktisch}
    \CURnewenv{SozialSelbst}
    \CURnewenv{Vertiefungen}
  }{}
  \CURnewenv{FachlichInFrageKommendeBachelorstudien}
  \CURnewenv{VerwendungAuflagen}
  \CURnewenv{Zulassung}
  \CURnewenv{Pruefungsfaecher}
  \CURnewenv{Modulkurzbeschreibungen}
  \CURnewenv{Modullangbeschreibungen}
  \newenvironment{Pruefungsordnung}{%
    \CURnewenv{Diplompruefung}
    \CURnewenv{Abschlusspruefung}    
    \CURnewenv{Abschlusszeugnis}
    \CURnewenv{ExtraTextAbschlusszeugnis}
    \CURnewenv{Teilgenommen}
    \CURnewenv{Extra}
  }{}
  \CURnewenv{EinstiegSommer}
  \CURnewenv{Mobilitaet}
  \CURnewenv{Studierbarkeit}
  \CURnewenv{AlleVerpflichtendenVoraussetzungen}
  \CURnewenv{Diplomarbeit}
  \CURnewenv{Qualitaetsmanagement}
  \CURnewenv{Semestereinteilung}
  \CURnewenv{SemestereinteilungSchief}
  \CURnewenv{Uebergangsbestimmungen}
  \CURnewenv{Anhang}
}{
  \aftergroup\MasterEndHook
}

\newcommand*\MasterBeginHook{
  \global\let\ModulBeginHook\relax
  \global\let\ModulEndHook\relax
}
\newcommand*\MasterEndHook{
  \ifDEF{Module}{\LadeModule{\VAR{Module}}}{}
  \ifDEF{ExterneModule}{\LadeModule{\VAR{ExterneModule}}}{}
  \LVcsv{lvas.csv}
  \input{\TUWmaster}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LEHRVERANSTALTUNGEN
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcounter{lv} % Zähler für anonyme Lehrveranstaltungen
\newcommand*\LVSammlung{}
\newcommand*\addto@LVSammlung[1]{\g@addto@macro\LVSammlung{,#1}}
\newenvironment{SammleLVs}{%
  \gdef\LVSammlung{}%
}{%
  \expandafter\TUWdef\expandafter{\LVSammlung}{\MODthis}{LVs}%
}

\newcommand*\LVdef[2]{\expandafter\gdef\csname LV:#1\endcsname{#2}}
\newcommand*\LVaux[2]{\immediate\write\@mainaux{\unexpanded{\LVdef{#1}{#2}}}}
\newcommand*\LVuse[1]{\csname LV:#1\endcsname}
\newcommand*\LV[5][]{%
  \@LVEctsSstTypTitel{#2}{#3}{#4}{#5}{#1}%
  \@ifnextchar[{%
    \@LV{#2}{#3}{#4}{#5}%
  }{%
    \stepcounter{lv}%
    \@LV{#2}{#3}{#4}{#5}[@lv\roman{lv}]%
  }%
}
\newcommand*\@LV{}
\def\@LV#1#2#3#4[#5]{%
  \edef\@LVtmp{#5}%
  \expandafter\LVdef\expandafter{\@LVtmp}{{#1}{#2}{#3}{#4}}%
  \expandafter\LVaux\expandafter{\@LVtmp}{{#1}{#2}{#3}{#4}}%
  \expandafter\addto@LVSammlung\expandafter{\@LVtmp}%
}
\newlength\ectswidth
\newlength\typwidth
\newlength\ectsTypwidth
\newlength\ectsSstTypwidth
\settowidth\ectswidth{88,8}
\settowidth\typwidth{VU}
\settowidth\ectsTypwidth{88,8\ VU\ }
\newcommand*\@LVref[2]{%
  \ifcsname LV:#2\endcsname
    \edef\@tmp{\LVuse{#2}}%
    \expandafter\@LVdisplay\@tmp{#1}%
    \addto@LVSammlung{#2}%
  \else
    \@TUW@warning{Keine Lehrveranstaltung mit der Bezeichnung '#2' bekannt}%
    \@LVdisplay{??}{??}{??}{????? ????? ?????}{#1}%
  \fi
}
\newcommand*\LVEctsTypTitel[2][]{%
  \smallskip
  \let\@LVdisplay\@LVEctsTypTitel
  \applytolist{\@LVref{#1}}{#2}%
  \smallskip\par
}
\newcommand*\@LVEctsTypTitel[5]{%
  \par\noindent
  \if@POSTFIXMARKE\else
    \makebox[0em][r]{#5}%
  \fi
  \makebox[\ectswidth][r]{#1}\ 
  \makebox[\typwidth][l]{#3}\ 
  \parbox[t]{\dimexpr\linewidth-\ectsTypwidth}{#4\if@POSTFIXMARKE#5\fi\strut}%
}
\newcommand*\LVEctsSstTypTitel[2][]{%
  \smallskip
  \let\@LVdisplay\@LVEctsSstTypTitel
  \applytolist{\@LVref{#1}}{#2}%
  \smallskip\par
}
\newcommand*\@LVEctsSstTypTitel[5]{%
  \par\noindent
  \settowidth\ectsSstTypwidth{88,8/#2\ VU\ }%
  \if@POSTFIXMARKE\else
    \makebox[0em][r]{#5}%
  \fi
  \makebox[\ectswidth][r]{#1}/#2\ 
  \makebox[\typwidth][l]{#3}\ 
  \parbox[t]{\dimexpr\linewidth-\ectsSstTypwidth}{#4\if@POSTFIXMARKE#5\fi\strut}%
}
\let\LVref\LVEctsSstTypTitel

\newcommand*\LVEcts {\def\@LVdisplay##1##2##3##4##5{##1}\@@LVref{}}
\newcommand*\LVSst  {\def\@LVdisplay##1##2##3##4##5{##2}\@@LVref{}}
\newcommand*\LVTyp  {\def\@LVdisplay##1##2##3##4##5{##3}\@@LVref{}}
\newcommand*\LVTitel{\def\@LVdisplay##1##2##3##4##5{##4}\@@LVref{}}
\newcommand*\@@LVref[2]{%
  \ifcsname LV:#2\endcsname
    \edef\@tmp{\LVuse{#2}}%
    \expandafter\@LVdisplay\@tmp{#1}%
  \else
    \@TUW@warning{Keine Lehrveranstaltung mit der Bezeichnung '#2' bekannt}%
    \@LVdisplay{??}{??}{??}{????? ????? ?????}{#1}%
  \fi
}

\newcommand*\LVcsv[1]{%
  \IfFileExists{#1}{%
    \csvreader[head to column names,separator=semicolon]{#1}{}{%
      \edef\@LVcsv{\noexpand\LVdef{\id}{{\ects}{\sst}{\typ}{\titel}}}%
      \@LVcsv
    }%
  }{}%
}

\newcommand*\ECTS[1]{#1\allowbreak\,ECTS}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DECKBLATT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand*\DECKBLATT{%
  \ifTUDECKBLATT
    \input{TUWdeckblatt}
  \else
    \begin{titlepage}
      \begin{center}
        \includegraphics[scale=0.2]{TUWlogo}
      \end{center}
      \vspace*{\fill}
      \begin{center}\Huge\sffamily\bfseries
        {\large Studienplan (Curriculum) für \ArtikelAkkusativStudienart}\\[1ex]
        \Studienart\\[.5ex]
        \VAR{Titel}\\[1ex]
        {\large an der Technischen Universität Wien}\\[2ex]
        {\large Gültig ab \VAR{GueltigAb}}
      \end{center}
      \vspace*{\fill}
      \ifENTWURF
        \begin{center}\large\sffamily\bfseries
          Version: \TUWuse{}{Version}\\
          Redaktion: \TUWuse{}{Redaktion}
        \end{center}
      \fi
      \vspace*{\fill}
    \end{titlepage}
  \fi
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FEHLERMELDUNGEN
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\everypar{\@TUW@error{Text außerhalb des entsprechenden \protect\begin-\protect\end-Blocks}}

\newcommand\@TUW@info[1]{%
   \GenericInfo{%
      \space\space\space\@spaces\@spaces\@spaces
   }{%
      TUW Curriculum Info: #1%
   }%
}
\newcommand\@TUW@warning[1]{%
   \GenericWarning{%
      \space\space\space\@spaces\@spaces\@spaces
   }{%
      TUW Curriculum Warnung: #1%
   }%
}
\newcommand\@TUW@error[1]{%
   \GenericError{%
      \space\space\space\@spaces\@spaces\@spaces
   }{%
      TUW Curriculum Fehler: #1%
   }{%
      Weitere Infos: Gernot.Salzer@tuwien.ac.at oder https://github.com/gsalzer/TUWcurriculum%
   }{}%
}

\endinput
