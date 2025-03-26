% Adapted from https://www.overleaf.com/latex/templates/tu-delft-dissertation/mfbtwcrcgmvy

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tudelft}[2022/11/26 v3.0 TU Delft dissertation class]

\newif\if@fourier
\DeclareOption{fourier}{\@fouriertrue}
\newif\if@print
\DeclareOption{print}{\@printtrue}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrbook}}
\ProcessOptions*
\LoadClass[10pt]{scrbook}

\RequirePackage{ifpdf}
\RequirePackage{ifxetex}
\ifxetex
    % English is the default language, but Dutch is used for some sections.
    \RequirePackage{polyglossia}
    \setdefaultlanguage[variant=british]{english}
    \setotherlanguage{dutch}
    \RequirePackage{xltxtra}
    \RequirePackage{microtype}
\else
    % English is the default language, but Dutch is used for some sections.
    \RequirePackage[dutch,english]{babel}
\fi

\if@fourier
    \RequirePackage[fourier]{fonts-tudelft}
\else
    \RequirePackage{fonts-tudelft}
\fi
\RequirePackage[headsepline=true,footsepline=false]{scrlayer-scrpage}

\RequirePackage{geometry}
\RequirePackage{graphicx}
\RequirePackage{hyperref}

\DeclareMathOperator{\sinc}{sinc}

\RequirePackage{calc}
\RequirePackage{etaremune}
\RequirePackage[obeyFinal,textsize=footnotesize]{todonotes}
\RequirePackage[nameinlink]{cleveref}
\RequirePackage{lettrine}
\RequirePackage{metalogo}
\RequirePackage{xpatch}


% make "et al" italic
\xpatchbibmacro{name:andothers}{%
  \bibstring{andothers}%
}{%
  \bibstring[\emph]{andothers}%
}{}{}

% command for fullcite with all authors
\newcommand{\printpublication}[1]{\AtNextCite{\defcounter{maxnames}{99}}\fullcite{#1}}

\RequirePackage{tikz}
\RequirePackage{xcolor}
\RequirePackage{booktabs}
\RequirePackage{rotating}
\RequirePackage{dpfloat}
\RequirePackage{thumbindices}
\RequirePackage{csquotes}
% control where floats can go: only after their definition in sourcecode
\RequirePackage{flafter}

% Bottom-placed floats may fill all of the page
\renewcommand{\bottomfraction}{1}
% Top-placed floats may fill all of the page
\renewcommand{\topfraction}{1}
% No text at all needs to be present on a page
\renewcommand{\textfraction}{0}
% Set the maximum number of floats allowed ...
% - at the top of a text page (the default is 2)
\setcounter{topnumber}{8}
% - at the bottom of a text page (the default is 1)
\setcounter{bottomnumber}{8}
% - on any one text page (the default is 3)
\setcounter{totalnumber}{8}

% set default figure and table placement to be `ht'
\renewcommand*{\fps@figure}{ht}
\renewcommand*{\fps@table}{ht}
% set float content centered
\g@addto@macro\@floatboxreset{\centering}

\RequirePackage{color-tudelft}

%% Set the paper size to 17 by 24 cm, approximately halfway between A4 and A5.
\if@print
    %% In print mode we add a 3 mm bleed on the outside of the page.
    \geometry{
        papersize = {173mm,246mm},
        layoutsize = {167mm,240mm},
        layoutoffset = {3mm,3mm},
        bindingoffset = -3mm
    }
\else
    \geometry{papersize={170mm,240mm}}
\fi
%% We decrease the margins slightly from the default (scale = 0.7).
\geometry{hscale=0.75,vscale=0.8}
\setlength{\marginparwidth}{20mm}

%% Redefine the title command to accept an optional subtitle.
\renewcommand*\title[2][]{%
    \def\@subtitle{#1}%
    \def\@title{#2}%
    %% Add the title to the PDF meta data.
    \hypersetup{pdftitle=#2}%
}

%% function to extract one initial
\def\getnextinitial#1#2 #3|{% space and pipe are delimiters;
    % #1 is one token, #2 everything up to the first space, #3 all the rest up to the pipe
    \xdef\@initials{\@initials#1.}% Append the first character to the initials
    \xdef\remainingnames{#3}}% Store the remaining names

% %% Redefine the author command to accept a first and last name, and to add the
% %% full name to the PDF meta data.
% \renewcommand*\author[2]{%
%     \def\@firstnames{#1}%
%     \def\@lastname{#2}%
%     % gather initials from first names
%     \def\@initials{}%
%     \xdef\remainingnames{\@firstnames{} }% space is needed, else it will not work for the last name
%     \loop
%         \expandafter\getnextinitial \remainingnames|%
%     \unless\ifx\remainingnames\empty\repeat% If no more names are remaining, exit the loop
%     \hypersetup{pdfauthor=#1\ #2}%
% }

%% Remove the header and page number on empty pages.
\def\cleardoublepage{%
    \clearpage%
    \if@twoside%
        \ifodd\c@page%
        \else%
            \thispagestyle{empty}%
            \vspace*{\fill}%
            \newpage%
        \fi%
    \fi%
}


%% Color the bullets of the itemize environment and make the symbol of the third
%% level a diamond instead of an asterisk.
\renewcommand*\labelitemi{\color{title}\textbullet}
\renewcommand*\labelitemii{\color{title}--}
\renewcommand*\labelitemiii{\color{title}$\diamond$}
\renewcommand*\labelitemiv{\color{title}\textperiodcentered}

%% Define an unnumbered footnote command.
\newcommand\blfootnote[1]{%
  \begin{NoHyper}
  \renewcommand\thefootnote{}\footnote{#1}%
  \addtocounter{footnote}{-1}%
  \end{NoHyper}
}

% Define a drop command which can be used to generate drop caps at the
% beginning of a section.
\renewcommand*\LettrineTextFont{\titleshape}
\newcommand*\dropcap[2]{
    \lettrine[lines=2,findent=0.2em,nindent=0pt,loversize=.05]{\color{title} \smash{#1}}{#2}%
}

%% Create an unnumbered reference section.
%\addto\captionsenglish{\renewcommand*\bibname{\color{title}References}}
%\newcommand*\references[1]{%
%    \bibliographystyle{dissertation}%
%    \bibliography{#1}%
%}
\newcommand{\printreferences}{\printbibliography[title=references]}

% add double question mark to broken citations
\protected\def\abx@missing#1{%
  \mbox{\reset@font\bfseries#1??}}

%% Hyperlinks are cyan, except in print mode, when they are all black.
\hypersetup{
    colorlinks = true,
    citecolor = title,
    linkcolor = title,
    urlcolor = title,
    bookmarksopen = true,
}


%\KOMAoptions{numbers=endperiod}
\renewcommand\chapterlinesformat[3]{\Ifstr{#2}{}{}{#2\\[12pt]}#3}
\addtokomafont{disposition}{\color{title}\rmfamily\scshape\mdseries}
\addtokomafont{chapter}{\bfseries\Huge}
\addtokomafont{paragraph}{\upshape\bfseries\color{black}}
\addtokomafont{subparagraph}{\itshape\color{black}}
\addtokomafont{pageheadfoot}{\upshape\scshape\color{title}}

\if@fourier
    %% The style for titles is small caps.
    \def\titlefont{\rmfamily}
    \def\titleshape{\scshape}
    \def\titlestyle{\titlefont\titleshape\bfseries}
    \def\headerstyle{\titlestyle}
\else
    %% The default style for titles is serif.
    \addtokomafont{disposition}{\color{title}\robotoslab\scshape\mdseries}
    \def\titlefont{\robotoslab}
    \def\titleshape{}
    \def\titlestyle{\titlefont\titleshape\bfseries}
    \def\headerstyle{\titlefont\titleshape}
\fi

% Chapter titles have the same layout as parts.
\renewcommand*{\raggedpart}{\raggedleft}
\renewcommand*{\partformat}{%
  {\fontsize{96pt}{96pt}\selectfont\bfseries\color{black}\thepart}\enskip}
\renewcommand*{\raggedchapter}{\raggedleft}
\renewcommand*{\chapterformat}{%
  {\fontsize{96pt}{96pt}\selectfont\bfseries\color{black}\thechapter}\enskip}

% ((Sub)sub)section titles start with the number in bold, followed by the name printed
% in the title color.
\renewcommand*{\sectionformat}{\textbf{\textcolor{black}{\thesection.}}\enskip}
\renewcommand*{\subsectionformat}{\textbf{\textcolor{black}{\thesubsection.}}\enskip}
\renewcommand*{\subsubsectionformat}{\textbf{\textcolor{black}{\thesubsubsection.}}\enskip}

\RedeclareSectionCommands[
  afterskip=.2\baselineskip,
  tocentrynumberformat=\color{black},
]{section,subsection,subsubsection}

\RedeclareSectionCommands[
  tocentrypagenumberformat=\color{black}\bfseries,
  tocentrynumberformat=\color{black}\bfseries,
  tocentryformat=\bfseries,
]{chapter,part}

\RedeclareSectionCommands[
  tocentryformat=\scshape\bfseries\large,
%  tocindent=-2em,
%  tocnumwidth=2em,
]{part}

% Page header/footer styles
\newif\ifmainmatter
\mainmattertrue

% Print the current chapter and section at the top of the page in cyan.
\renewcommand{\sectionmark}[1]{\markright{\ifmainmatter\textcolor{black}{\thesection.}\fi\ #1}{}}
\renewcommand{\chaptermark}[1]{\markboth{\ifmainmatter\textcolor{black}{\thechapter.}\fi\ #1}{}}

\let\oldfrontmatter\frontmatter
\renewcommand{\frontmatter}{\oldfrontmatter\mainmatterfalse}
\let\oldmainmatter\mainmatter
\renewcommand{\mainmatter}{\oldmainmatter\mainmattertrue}
\let\oldbackmatter\backmatter
\renewcommand{\backmatter}{\oldbackmatter\mainmatterfalse}

% Draw the line below the header in the title color.
\setkomafont{headsepline}{\color{title}}
\setkomafont{footsepline}{\color{title}}

% Page numbers on the top left and top right.
\lehead{\cropmarks\lthumb\textcolor{black}{\thepage}}
\rohead{\cropmarks\rthumb\textcolor{black}{\thepage}}

% Section name on inner (left) side of the right (odd) page.
\lohead{\rightmark}
% Chapter name on inner (right) side of the the left (even) page.
\rehead{\leftmark}

\lefoot{}
\lofoot{}
\refoot{}
\rofoot[]{}
\cfoot[\textcolor{black}{\thepage}]{}

% Draw the line above a footnote in the title color as well.
\setfootnoterule{0.5\textwidth}
\addtokomafont{footnoterule}{\color{title}}

%% The dedication is vertically centered on a separate page and flushed to the
%% right.
\renewcommand\dedication[1]{%
    \thispagestyle{empty}%
    \vspace*{\fill}%
    \begin{flushright}%
        #1%
    \end{flushright}%
    \vspace*{\fill}%
    \cleardoublepage%
}

%% The authors environment is used to display the authors of a chapter on the
%% title page. This is only necessary if multiple people contributed
%% significantly to the chapter.
\newcommand*\authors[1]{%
    \begin{center}%
        {\Large\bfseries #1}%
    \end{center}%
    \vspace{2\baselineskip}%
}

%% The epigraph environment can be used to to add a quote to the title page of
%% a chapter.
\newcommand\epigraph[3][2\baselineskip]{%
    \begin{flushright}%
        {\rmfamily\itshape #2}%
        \vskip 0.5\baselineskip%
        #3%
    \end{flushright}%
    \vspace{#1}%
}

%% The abstract environment is used for the abstract of a chapter.
\newenvironment{abstract}{%
    \list{}{\leftmargin\rightmargin}%
    \item%
    \relax%
    \rmfamily\itshape%
}{%
    \endlist%
}

\if@print%
  \newcommand*\cropmarks{%
    \ifodd\c@page%
    \begin{tikzpicture}[remember picture,overlay]
    \draw ($(current page.north east)+(0mm,-3mm)$) -- ($(current page.north east)+(-2mm,-3mm)$);
    \draw ($(current page.north east)+(-3mm,0mm)$) -- ($(current page.north east)+(-3mm,-2mm)$);
    \draw ($(current page.south east)+(0mm,3mm)$) -- ($(current page.south east)+(-2mm,3mm)$);
    \draw ($(current page.south east)+(-3mm,0mm)$) -- ($(current page.south east)+(-3mm,2mm)$);
    \end{tikzpicture}%
    \else%
    \begin{tikzpicture}[remember picture,overlay]
    \draw ($(current page.north west)+(0mm,-3mm)$) -- ($(current page.north west)+(2mm,-3mm)$);
    \draw ($(current page.north west)+(3mm,0mm)$) -- ($(current page.north west)+(3mm,-2mm)$);
    \draw ($(current page.south west)+(0mm,3mm)$) -- ($(current page.south west)+(2mm,3mm)$);
    \draw ($(current page.south west)+(3mm,0mm)$) -- ($(current page.south west)+(3mm,2mm)$);
    \end{tikzpicture}%
    \fi%
  }
\else
  \newcommand*\cropmarks{}
\fi%
