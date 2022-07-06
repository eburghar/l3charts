\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{l3charts-doc}[2022/07/02 Customized LaTeX documentation class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ltxdoc}}
\ProcessOptions\relax
\LoadClass{ltxdoc}

% for ifpdf
\usepackage{iftex}
\usepackage{fontspec}
\usepackage[default]{raleway}
\setmonofont{MonoLisa_Regular}[ItalicFont=MonoLisa_RegularItalic, Scale=MatchLowercase, StylisticSet=2]

\def\MacroFont{\ttfamily\small}
\def\PackageFont{\ttfamily}

\usepackage[parfill]{parskip}
 % remove first paragraph line indentation
 \setlength{\parindent}{0pt}

\usepackage{xcolor}
 \definecolor{thered}    {rgb} {0.65,0.04,0.07}
 \definecolor{thegreen}  {rgb} {0.06,0.44,0.08}
 \definecolor{theblue}   {rgb} {0.02,0.04,0.48}
 \definecolor{sectioning}{gray}{0.44}
 \definecolor{thegrey}   {gray}{0.5}
 \definecolor{theframe}  {gray}{0.75}
 \definecolor{theshade}  {gray}{0.94}

\usepackage[bookmarks,pdfdisplaydoctitle,
  colorlinks,linkcolor=theblue,citecolor=theblue,urlcolor=thered,
  hyperindex=false,hyperfootnotes=false]{hyperref}
\usepackage{hyperxmp}% more attributes in hypersetup

\usepackage{booktabs}
\usepackage{array}
 \newcolumntype{L}[1]{p{#1}<{\raggedright}}

\usepackage{tabularx}
 \setlength\tabcolsep{2pt}

\usepackage{listings}
 \lstset{language=[LaTeX]TeX,basicstyle=\MacroFont\small,
  keywordstyle=[1]\color{thered},
  commentstyle=\color{thegrey}\itshape,
  morekeywords={NewDocumentCommand,colorbox,textcolor},
  frame=single,backgroundcolor=\color{theshade},rulecolor=\color{theframe},
  framerule=\fboxrule,xleftmargin=3.4pt,xrightmargin=3.4pt,belowskip=\smallskipamount,breaklines=true,
  breakatwhitespace=true
 }
 % redefine verbatim to be a listings
 \let\verbatim\relax
 \lstnewenvironment{verbatim}[1][]{\lstset{#1}}{}

\usepackage{geometry}

% Macros and environment
%% format property list for options
\NewDocumentEnvironment{props}{o}{%%
  \NewDocumentCommand\prop{mom}{\texttt{##1} & \IfValueT{##2}{\texttt{##2}} & ##3\\ \addlinespace}
  #1 is comma separated list of the following keywords :

  \begin{tabular}{lL{0.3\linewidth}L{0.4\linewidth}} \toprule
     Key & Default value & Description \\
     \midrule
} {
     \bottomrule
   \end{tabular}
}

\usepackage{xspace}
  \NewDocumentCommand\TikZ{}{Ti\textit{k}Z\xspace}% typeset TikZ

% title
\def\@maketitle{%
  \newpage\null
  \begin{center}\sffamily
    {\huge \@title\par\vskip 1em}%
    {\large\parbox{.33\textwidth}{\hfil\@author\hfil}%
     \parbox{.33\textwidth}{\hfil\@date\hfil}\par\vskip 1em
     \url{\githuburl}}%
    \vskip 2em\rule{\textwidth}{.4pt}%
  \end{center}\par\vskip 2em}

% headings
\headheight=15pt
\def\ps@MTheadings{%
  \def\@oddhead{%
    \hbox to\textwidth{\vbox{\hbox to\textwidth{%
      \footnotesize\sffamily{\leftmark\rightmark\strut}\hfill\thepage\strut}%
      \hrule height 0.4pt width\textwidth \vskip-0.4pt
    }}\hss}
  \let\@oddfoot\@empty
  \let\@mkboth\markboth
  \def\sectionmark##1{\markboth{\MakeUppercase{##1}}{}}
  \def\subsectionmark##1{\markright{\,: ##1}}}
\pagestyle{MTheadings}

% lists
\setlength\leftmargini{15pt}
\setlength\leftmarginii{12.5pt}
\setlength\leftmarginiii{10pt}
\def\@listi{\leftmargin \leftmargini
            \parsep 4.5pt plus 1pt minus 1pt
            \topsep 4.5pt plus 1pt minus 1pt
            \itemsep 0pt}
\let\@listI\@listi
\def\descriptionlabel#1{\hspace\labelsep\normalfont#1:}
\renewenvironment{itemize}
  {\ifnum \@itemdepth >\thr@@\@toodeep\else
    \advance\@itemdepth\@ne
    \edef\@itemitem{labelitem\romannumeral\the\@itemdepth}%
    \expandafter\list
      \csname\@itemitem\endcsname
      {\ifnum\@itemdepth=\@ne\leftmargin 0pt\fi
       \def\makelabel##1{\hss\llap{\color{sectioning}##1}}}%
   \fi}
  {\endlist}
\newenvironment{enum}[1][0]
  {\list\labelenumi
    {\usecounter{enumi}\setcounter{enumi}{#1}\addtocounter{enumi}{-1}%
     \renewcommand\labelenumi{\texttt{\theenumi}:}%
     \leftmargin 30pt
     \itemindent-15pt
     \labelwidth 15pt
     \labelsep 0pt
     \def\makelabel##1{##1\hss}}}
  {\endlist}
\newenvironment{options}
  {\list{}
    {\leftmargin 0pt
     \labelwidth 0pt
     \labelsep 1em
     \itemindent \labelsep
     \lstset{belowskip=0pt}}}
  {\endlist}

% Sections numbers colored and in the margin
\addtolength\textheight{\topskip}
\setlength\topmargin{5pt}
\def\@seccntformat#1{\llap{\csname the#1\endcsname\hskip\marginparsep}}
\def\MTsectionfont{\bfseries\sffamily\ralewaythin\color{sectioning}}
\patchcmd\section      {\bfseries}{\MTsectionfont}\relax\relax
\patchcmd\subsection   {\bfseries}{\MTsectionfont}\relax\relax
\patchcmd\subsubsection{\bfseries}{\MTsectionfont}\relax\relax
\def\paragraph{\@startsection{paragraph}{4}%
  {0pt}{8pt plus 2pt minus 1pt}{-1em}%
  {\normalfont\normalsize\itshape}}

% Change how Env and Macro appears in the margin by overriding doc package macros
\def\PrintDescribeEnv#1{\strut\MacroFont\bslash begin\{{\color{thegreen}#1}\}%
  \\*[.25\baselineskip]\strut\bslash end\{{\color{thegreen}#1}\}}
\def\PrintDescribeMacro#1{\strut\MacroFont\color{thegreen}\textbackslash\string #1}
\def\DescribeOption{\leavevmode\@bsphack
  \begingroup\MakePrivateLetters\Describe@Option}
\def\Describe@Option#1{\endgroup
  \marginpar{\raggedleft\PrintDescribeOption{#1}}%
  \SpecialOptionIndex{#1}\@esphack\ignorespaces}
\def\PrintDescribeOption#1{\strut\MacroFont\color{thered}#1}

% Colored index letters in the margin. 2 columns index
\setcounter{IndexColumns}{2}
\def\IndexMin{12\baselineskip}
\g@addto@macro\IndexParms{%
  \small
  \def\indexspace#1{%
    \end{multicols}
    \vspace{-20pt}%
    \begin{multicols}{2}
      \ifpdf{\let\bfseries\empty\let\hfil\empty\phantomsection\pdfbookmark[2]{#1}{#1}}\fi
      \setbox0\hbox{\sffamily\hss#1}%
      \ifdim\wd0<1em \setbox0\hbox to 1em{\sffamily\hss#1\hss}\fi
      \llap{\color{thegrey}\box0\hskip\marginparsep}%
      \vspace*{-\baselineskip}%
      \IndexParms %\rightskip 15pt
      \let\item\@idxitem
      \raggedcolumns}}
\IndexPrologue{\section{Index}%
  Numbers in upright shape refer to the \textit{page} where the corresponding entry
  is described (bold face) resp. occurs.
}
\DeclareRobustCommand\textoractual[2]{\ifpdf
  \pdfliteral direct{/Span<</ActualText(#2)>>BDC}#1\pdfliteral direct{EMC}%
  \else #1\fi}
% additional bells ...
\def\Describe#1#2#3{\noindent\csname Describe#1\endcsname{#2}%
  \DescribeValues{#1}{#3}}
\def\DescribeOption{\leavevmode\@bsphack
  \begingroup\MakePrivateLetters\Describe@Option}
\def\Describe@Option#1{\endgroup
  \marginpar{\raggedleft\PrintDescribeOption{#1}}%
  \SpecialOptionIndex{#1}\@esphack\ignorespaces}
\def\DescribePackage{\leavevmode\@bsphack
  \begingroup\MakePrivateLetters\Describe@Package}
\def\Describe@Package#1{\endgroup
  \marginpar{\raggedleft\PrintDescribeOption{#1.sty}}%
  \CatMainIndex{#1}{package}\@esphack\ignorespaces}
\def\DescribeValues#1#2{%
  \let\@tempa\@empty \let\Option@default\@empty
  \@for\@tempb:=#2\do{%
    \csname Special#1Value\expandafter\endcsname\@tempb\@nil
    \expandafter\g@addto@macro\expandafter\@tempa
      \expandafter{\csname #1Sep\endcsname}%
    \expandafter\g@addto@macro\expandafter\@tempa
      \expandafter{\@tempb}}%
  \@ifnextchar[\PrintValues{\PrintValues[\Option@default]}}
\def\SpecialOptionValue#1#2\@nil{%
  \if#1:\def\@tempb{\Variable{#2}}\else %                      : = variable
  \if#1!\def\@tempb{#2}\def\Option@default{#2}\else %          ! = default
  \if#1*\def\@tempb{#2}\def\Option@default{\MaybeDefault{#2}}% * = default (maybe)
  \fi\fi\fi}
\def\SpecialMacroValue#1#2\@nil{%
  \if#1?\def\@tempb{\normalsize[\Variable{#2}]}%  % ? = optional
   \else\def\@tempb{\normalsize\{\Variable{#1#2}\}}\fi}
\let\SpecialEnvValue\SpecialMacroValue
\DeclareRobustCommand\langlechar{<} % for makeindex
\DeclareRobustCommand\ranglechar{>}
\def\Variable#1{%
  \textoractual{$\langle$}{\langlechar}%
    {\rmfamily\itshape#1}%
  \textoractual{$\rangle$}{\ranglechar}}
\let\m@a\meta \def\meta#1{\textoractual{\m@a{#1}}{\langlechar#1\ranglechar}}
\def\MaybeDefault#1{\textrm{*}\,#1}
\def\OptionSep{{\rmfamily, }} \def\MacroSep{\,} \def\EnvironmentSep{\,}
\def\PrintValues[#1]{{\MacroFont\expandafter\@gobble\@tempa\hfill #1}\\*[.25\baselineskip]}
\def\CatIndex#1#2{\index{#1\actualchar{\protect\ttfamily #1} (#2)\encapchar hyperpage}}
\def\CatIndeX#1#2#3{\index{#2\actualchar#1\ (#3)\encapchar hyperpage}}
\def\CatMainIndex#1#2{\index{#1\actualchar{\protect\ttfamily #1} (#2)\encapchar docmain}}
\def\SpecialOptionIndex#1{\@bsphack
  \index{\quotechar/#1% sort options as `Symbols'
    \actualchar{\protect\ttfamily#1}\encapchar docmain}%
  \CatMainIndex{#1}{option}\@esphack}
\def\SpecialUsageIndex#1{\@bsphack
  \index{\quotechar1% sort commands as `Numbers'
    \actualchar\string\verb
      \quotechar*\verbatimchar\string#1\verbatimchar\encapchar docmain}%
  {\let\special@index\index\SpecialIndex@{#1}{\encapchar docmain}}\@esphack}
\def\SpecialEnvIndex#1{\CatMainIndex{#1}{environment}}
\def\cmd#1{\orig@cs{\expandafter\cmd@to@cs\string#1}}
\DeclareRobustCommand\orig@cs[1]{\texttt{\char`\\#1}}
\DeclareRobustCommand\cs[1]{\texttt{\char`\\#1}%
  {\let\special@index\index
   \expandafter\SpecialIndex@\expandafter{\csname#1\endcsname}{\encapchar hyperpage}}}
\DeclareRobustCommand\key[1]{\textcolor{thered}{\ttfamily#1}}
\DeclareRobustCommand\pkg[1]{{\PackageFont#1}\@bsphack\CatIndex{#1}{package}\@esphack}
\DeclareRobustCommand\cls[1]{{\PackageFont#1}\@bsphack\CatIndex{#1}{class}\@esphack}
\DeclareRobustCommand\opt[1]{{\ttfamily#1}\@bsphack\CatIndex{#1}{option}\@esphack}
\DeclareRobustCommand\file[1]{{\ttfamily#1}}
\DeclareRobustCommand\env[1]{{\ttfamily#1} (\emph{env})\@bsphack\CatIndex{#1}{environment}\@esphack}

\def\MTrmn#1{\ifrmnum{#1}{\rmntonum{#1}}{#1}}
% write references to the User manual intermediarily in roman numerals
% in order to separate them from those in the Implementation part
\def\@wrindex#1{\protected@write\@indexfile{\let\@roman\relax}{\string\indexentry{#1}{\@roman\thepage}}\endgroup\@esphack}
\def\HyInd@pagelink#1{\begingroup\toks@={}\edef\x{\MTrmn{#1} }\expandafter\HyInd@removespaces\x\@nil\endgroup}
\def\docmain#1{\textbf{\hyperpage{#1}}}
\let\doc@hyperpage\hyperpage

% History
\newenvironment{History}
 {\list\labelitemi
  {\leftmargin 0pt
   \parsep 0pt
   \def\refsection##1{[##1]}
   \def\makelabel##1{\hss\llap{\color{sectioning}##1}}}}
 {\endlist}
\newcommand\Version[2]{
 \vskip\topsep
 \pagebreak[2]
 \item[\textsf{\bfseries\color{sectioning}#1}]\textsf{\bfseries\color{sectioning}(#2)}
 \vskip\topsep
 \nopagebreak}
