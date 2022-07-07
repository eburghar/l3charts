\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{l3charts-doc}[2022/07/02 Customized LaTeX documentation class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ltxdoc}}
\ProcessOptions\relax
\LoadClass{ltxdoc}

\usepackage{geometry}
	% bigger left margin for doc pages
	\geometry{
		paper=a4paper,
		vmargin={2cm,2cm},
		hmargin={4.5cm,1cm},
		% showframe % Uncomment to show how the type block is set on the page
	}

% for ifpdf
\usepackage{iftex}
\usepackage{fontspec}
\usepackage[default]{raleway}
% you need a license for this (https://www.monolisa.dev)
\setmonofont{MonoLisa_Regular}[
	ItalicFont=MonoLisa_RegularItalic,
	ItalicFeatures={StylisticSet=2},
	BoldFont=MonoLisa_Bold,
	BoldItalicFont=MonoLisa_BoldItalic,
	BoldItalicFeatures={StylisticSet=2},
	Scale=MatchLowercase]

\def\MacroFont{\ttfamily\small}
\def\PackageFont{\ttfamily}

% space between paragraphs. Remove first line indent
\usepackage[indent=0]{parskip}

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

% Define an example environment. Borrowed from skdoc.cls
\usepackage{moreverb}
\usepackage{minted}
\setminted{breaklines=true}
\setminted{breakanywhere=true}
\setminted{fontsize=\small}
% \setminted{bgcolor=theshade}
\usepackage{needspace}
\ExplSyntaxOn
\bool_new:N\g__skdoc_use_minted_bool
\bool_gset_true:N\g__skdoc_use_minted_bool
\bool_new:N\g__skdoc_no_index_bool
\bool_gset_false:N\g__skdoc_no_index_bool
\bool_new:N\g__skdoc_in_example_bool
\bool_gset_true:N\g__skdoc_in_example_bool
\bool_new:N\g__skdoc_with_implementation_bool
\bool_gset_true:N\g__skdoc_with_implementation_bool
\bool_new:N\g__skdoc_in_implementation_bool
\bool_gset_false:N\g__skdoc_in_implementation_bool
\bool_new:N\g__skdoc_negative_space_bool
\bool_gset_false:N\g__skdoc_negative_space_bool
\prg_new_conditional:Nnn\__skdoc_if_print_code:{p,T,F,TF}{
	\bool_if:nTF{
		\g__skdoc_in_implementation_bool &&
		!\g__skdoc_with_implementation_bool
	}{
		\prg_return_false:
	}{
		\prg_return_true:
	}
}
\tl_new:N\skdoc@temptl
\ior_new:N\skdoc@input
\iow_new:N\skdoc@output

\clist_new:N\l__skdoc_keys
\DeclareDocumentEnvironment{skdoc@verbatim}{m}{%
	\clist_set:Nn\l__skdoc_keys{#1}
	\clist_map_inline:Nn\l__skdoc_keys{
		\int_if_exist:cTF{skdoc@output@##1@line}{}{
			\msg_critical:nnn{skdoc}{key-nexists}{##1}
		}%
		\int_compare:nNnT{\int_use:c{skdoc@output@##1@line}}=\c_zero_int%
			{\int_gincr:c{skdoc@output@##1@line}}%
	}
	\__skdoc_if_print_code:T{
		\bool_if:NTF\g__skdoc_use_minted_bool{
			\bool_if:NF\g__skdoc_in_example_bool{
				\setkeys{minted@opt@g}{linenos}
			}%
			\exp_args:Nnx\setkeys{FV}{
				firstnumber=\int_use:c{skdoc@output@#1@line}
			}%
			\iow_open:Nn\minted@code{\jobname.pyg}%
			\Needspace*{2\baselineskip}%
		}{
			\bool_if:NF\g__skdoc_in_example_bool{\@bsphack}%
		}
		\bool_if:NF\g__skdoc_in_example_bool{
			\marginnote{
				\leavevmode
				\llap{
					\scriptsize\color{gray}
					$\langle$#1$\rangle$
					\makebox[2ex]{\strut}
				}
			}
		}
	}
	\def\verbatim@processline{%
		\clist_map_inline:Nn\l__skdoc_keys{
			\tl_gput_right:cx{skdoc@output@####1}{\the\verbatim@line\iow_newline:}%
		}
		\__skdoc_if_print_code:T{
			\bool_if:NTF\g__skdoc_use_minted_bool{
				\iow_now:Nx\minted@code{\the\verbatim@line}%
			}{
				\noindent\leavevmode%
				\bool_if:NF\g__skdoc_in_example_bool{\hspace*{-5ex}}
				\begin{minipage}[c][1ex]{\textwidth}
					\bool_if:nF{
						\g__skdoc_in_example_bool &&
						!\int_compare_p:nNn{\clist_count:N\l__skdoc_keys}>\c_one_int
					}{
						\makebox[4ex]{%
							\leavevmode
							\sffamily\tiny\color{lightgray}\hfill%
							\clist_map_inline:Nn\l__skdoc_keys{
								\oldstylenums{\int_use:c{skdoc@output@####1@line}}%
							}
						}%
						\hspace*{1ex}%
					}
					{
						\verbatim@font
						\the\verbatim@line
					}
				\end{minipage}
				\par
			}
		}
		\clist_map_inline:Nn\l__skdoc_keys{
			\int_gincr:c{skdoc@output@####1@line}%
		}
	}%
	\group_begin:
	\let\do\@makeother\dospecials\catcode`\^^M\active%
	\bool_if:nT{
		\__skdoc_if_print_code_p: &&
		!\g__skdoc_use_minted_bool
	}{
		\frenchspacing\@vobeyspaces
	}
	\verbatim@start%
}{%
	\group_end:
	\__skdoc_if_print_code:T{
		\bool_if:NTF\g__skdoc_use_minted_bool{
			\iow_close:N\minted@code%
			\bool_if:NF\g__skdoc_in_example_bool{
				\vspace*{-\topsep}
				\vspace*{-\partopsep}
				\vspace*{-\parskip}
			}
			\small % surely not the best place for this
			\minted@pygmentize{latex}%
			\DeleteFile{\jobname.pyg}%
			\vspace*{-\topsep}
			\vspace*{-\partopsep}
		}{
			\bool_if:NF\g__skdoc_in_example_bool{\@esphack}%
		}
	}%
}

\dim_const:Nn\c__skdoc_example_margin_dim{0.5\baselineskip}
\dim_const:Nn\c__skdoc_example_linewidth_dim{1pt}
\coffin_new:N\l__skdoc_example_code_coffin
\coffin_new:N\l__skdoc_example_divider_coffin
\coffin_new:N\l__skdoc_example_result_coffin
\DeclareDocumentEnvironment{example}{}{
	\bool_gset_true:N\g__skdoc_in_example_bool%
	%\minisec{Example:}%
	\int_zero_new:c{skdoc@output@skdoc@private@example@line}%
	\tl_if_exist:cTF{skdoc@output@skdoc@private@example}{
		\tl_clear:c{skdoc@output@skdoc@private@example}
	}{
		\tl_new:c{skdoc@output@skdoc@private@example}
	}
	\dim_set:Nn\l_tmpa_dim{ \textwidth/2
		-\c__skdoc_example_margin_dim
		-\c__skdoc_example_linewidth_dim/2}
	\coffin_clear:N\l__skdoc_example_code_coffin
	\vcoffin_set:Nnw\l__skdoc_example_code_coffin{\l_tmpa_dim}
	\skdoc@verbatim{skdoc@private@example}
}{
	\endskdoc@verbatim
	\vcoffin_set_end:
	\coffin_clear:N\l__skdoc_example_result_coffin
	\vcoffin_set:Nnw\l__skdoc_example_result_coffin{\l_tmpa_dim}
	\iow_open:Nn\skdoc@output{\jobname.skdoc.tmp}
	\iow_now:Nx\skdoc@output{\tl_to_str:c{skdoc@output@skdoc@private@example}}
	\iow_close:N\skdoc@output
	\input{\jobname.skdoc.tmp}
	\vcoffin_set_end:
	\coffin_clear:N\l__skdoc_example_divider_coffin
	\dim_set:Nn\l_tmpa_dim{
		\dim_max:nn{\coffin_ht:N\l__skdoc_example_code_coffin}%
			{\coffin_ht:N\l__skdoc_example_result_coffin}
		+ 2\c__skdoc_example_margin_dim}
	\hcoffin_set:Nn\l__skdoc_example_divider_coffin{
		\color{lightgray}
		\hspace*{\c__skdoc_example_margin_dim}
		\rule{\c__skdoc_example_linewidth_dim}{\l_tmpa_dim}
		\hspace*{\c__skdoc_example_margin_dim}
	}
	\coffin_clear:N\l_tmpa_coffin
	\coffin_set_eq:NN\l_tmpa_coffin\l__skdoc_example_divider_coffin
	\coffin_join:NnnNnnnn\l_tmpa_coffin{l}{vc}%
						 \l__skdoc_example_result_coffin{r}{vc}%
						 {0pt}{0pt}
	\coffin_join:NnnNnnnn\l_tmpa_coffin{r}{vc}%
						 \l__skdoc_example_code_coffin{l}{vc}%
						 {0pt}{0pt}
	\coffin_typeset:Nnnnn\l_tmpa_coffin{T}{l}{0pt}{0pt}
	\bool_gset_false:N\g__skdoc_in_example_bool%
	\vspace*{\c__skdoc_example_margin_dim}\par
}
\ExplSyntaxOff


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

\NewDocumentCommand\TikZ{}{Ti\textit{k}Z}% typeset TikZ

% title
\def\@maketitle{%
	% \newpage\null
	\begin{center}\sffamily
		{\huge \@title\par\vskip 1em}%
		{\large\parbox{.33\textwidth}{\hfil\@author\hfil}%
		 \parbox{.33\textwidth}{\hfil\@date\hfil}\par\vskip 1em
		 \url{\githuburl}}%
		\vskip 2em\rule{\textwidth}{.4pt}%
	\end{center}\par\vskip 2em}

% headings
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
%
\renewenvironment{itemize}{%
	\ifnum \@itemdepth >\thr@@\@toodeep\else
		\advance\@itemdepth\@ne
		\edef\@itemitem{labelitem\romannumeral\the\@itemdepth}%
		\expandafter\list
		\csname\@itemitem\endcsname
		{\ifnum\@itemdepth=\@ne\leftmargin 0pt\fi
			 \def\makelabel##1{\hss\llap{\color{sectioning}##1}}}%
	\fi
}{\endlist}
%
\newenvironment{enum}[1][0]{%
	\list\labelenumi
		{\usecounter{enumi}\setcounter{enumi}{#1}\addtocounter{enumi}{-1}%
		 \renewcommand\labelenumi{\texttt{\theenumi}:}%
		 \leftmargin 30pt
		 \itemindent-15pt
		 \labelwidth 15pt
		 \labelsep 0pt
		 \def\makelabel##1{##1\hss}}
}{\endlist}
%
\newenvironment{options}{%
	\list{}
		{\leftmargin 0pt
		 \labelwidth 0pt
		 \labelsep 1em
		 \itemindent \labelsep
		 \lstset{belowskip=0pt}}
}{\endlist}

% Sections numbers colored and in the margin
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
\newenvironment{History}{%
	\newcommand\Version[2]{
		\vskip\topsep
		\pagebreak[2]
		\item[\textsf{\bfseries\color{sectioning}#1}]\textsf{\bfseries\color{sectioning}(#2)}
		\vskip\topsep
		\nopagebreak}
	\list\labelitemi
		{\leftmargin 0pt
			\parsep 0pt
			\def\refsection##1{[##1]}
			\def\makelabel##1{\hss\llap{\color{sectioning}##1}}}
}{\endlist}
