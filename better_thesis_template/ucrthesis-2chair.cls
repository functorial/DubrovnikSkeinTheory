%% ucthesis.cls
%% Copyright (C) 1988-2004 Daniel Gildea, BBF, Ethan Munson.
%%
%% ucr.cls
%% Rewritten by Charles Yang at UC Riverside, 08/01/2007
%%
%% ucr.cls
%% Slightly modified for a dissertation committee with two chairpersons
%% - Jason Wong at UC Riverside, 03/12/2009
%%
%% Slightly modified by Blake Pollard to actually doublespace 09/01/2017
%%
%% Modified by Alexander M. Henderson to rely more on the defaults in
%% commonly used packages, to use the default `report` documentclass, to
%% better meet the requirements of UCR's formatting guidelines, and to
%% slightly improve the human-readability of some source files. 06/12/2020
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX
% version 2003/12/01 or later.
%
% This work has the LPPL maintenance status "unmaintained".
%
% This work consists of the files
% * ucrthesis-1chair.cls	(for a committee with one chair)
% * ucrthesis-2chair.cls	(for a committee with two co-chairs)
% * thesis-1chair.tex		(minimal working example with one chair)
% * thesis-2chair.tex		(minimal working example with two co-chairs)
% * bibliography.ltb		(minimal bibliography for use with amsrefs)
% * frontmatter/*			(example files for frontmatter)
% * chapters/*				(example chapters)
%
%%% ====================================================================
%%%  @LaTeX-class-file{
%%%     filename        = "ucr.cls",
%%%     version         = "4.0",
%%%     date            = "12 June 2020",
%%%     license         = "LPPL",
%%%     codetable       = "ISO/ASCII",
%%%     keywords        = "LaTeX, ucthesis",
%%%     docstring       = "This file is the main file for the ucr
%%%                        class, which is intended to meet the requirements
%%%                        for University of California Riverside Ph.D. dissertations.
%%%			   It is a direct port to LaTeX2e from UCTHESIS
%%%			   v2.7 by Ethan V. Munson, with no changes other
%%%			   than those for compatibility.  The major modifictions
%%%			   are in the font selection commands in the option
%%%			   files uct1x.clo.
%%%
%%%			   UCTHESIS.STY v2.7 is based on the standard
%%%			   report.sty as modified by Mittelbach and Schopf in
%%%			   Jan 1992.  The primary differences are (1) the use
%%%			   of pseudo-double-spacing, except in certain special
%%%                        environments; and (2) the use of a 6 inch line
%%%                        with 4em paragraph indentation.  It is only
%%%			   intended for single-sided printing.  Double-sided
%%%			   printing may be possible, but you're on
%%%			   your own.
%%%
%%%                        I know of no bugs in this implementation,
%%%                        but would be happy to hear of any problems
%%%                        that arise with it.
%%%
%%%			   Version 2.x fixes a bug in the previous
%%%			   version of 20 Jun 1988.  The bug was that
%%%			   "draft" optional mode didn't work because of
%%%			   problems in handling optional arguments.
%%%                        This file does not seem to work with earlier
%%%                        versions of LaTeX (pre-Jan 1992).
%%%
%%%			   Version 2.3 includes a single-spaced
%%%			   tabular* environment.
%%%
%%%			   Version 2.4 sets \evensidemargin correctly
%%%			   for two-sided style.  It also adds new
%%%			   environments (\smalltabular and
%%%			   \scriptsizetabular) which produce tables
%%%			   with smaller fonts.  The obvious methods
%%%			   of producing small-font tables don't work
%%%			   in ucthesis style.
%%%
%%%			   Version 2.5 adds support for the \maketitle
%%%			   macro.
%%%
%%%			   Version 2.6 adds support for complete and
%%%			   correct front matter.  Some dead code was
%%%			   removed, too.
%%%
%%%                        Version 2.7 adds front matter support for
%%%                        thesis committees of more than 3 people
%%%                        and for a labeled signature line on the
%%%                        abstract page.
%%%
%%%			   Version 3.0 is a direct port of version 2.7
%%%			   to LaTeX2e.  The major revisions in ucthesis.cls
%%%			   are converting option processing to LaTeX2e
%%%			   conventions.  The uct1x files have been revised
%%%			   to use the new font selection commands.
%%%
%%%			   Version 3.1 makes the following changes:
%%%				``U of C at CAMPUS'' is now ``U of C, CAMPUS''
%%%				new degreesemester variable
%%%				roman numeral frontmatter begins with page i,
%%%					not iii
%%%				``acknowledgments'' not ``acknowledgements''
%%%
%%%			   Version 3.2 explicitly states the license as LPPL.
%%%
%%%			   Some users have had problems with the
%%%			   margins ending up too small on one side.
%%%			   This appears to be a DVI-to-PostScript
%%%			   driver or printer-adjustment problem.
%%%			   If you have such trouble, make small adjustments
%%%			   to the \textwidth and \oddsidemargin
%%%			   settings in your document preamble.
%%%
%%%			   Another problem some people have had is
%%%			   that you can't use \pagestyle{headings}
%%%			   and \markboth if you use \part.  The solution
%%%			   is to get the headerfooter style, which is
%%%	   	           nice and simple to use."
%%%
%%%			   I commented out the definition of \dsp using
%%%                          1.37 instead of 2 and moved the other \dsp
%%%			   definition and command inside the initialization. - Blake Pollard (2017)
%%%
%%%				v 4.0  Simplified certain parts of the class file,
%%%				provided additional example chapters, significantly
%%%				increased the widow and orphan penalties, other quality-
%%%				of-life improvements.  A M Henderson, 2020
%%%
%%%  }
%%% ====================================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ucrthesis}[2018/01/26 UCR Thesis Format]

\LoadClass[11pt,letterpaper]{report}

\RequirePackage{etex}
\RequirePackage[top=1.5in,left=1.5in,bottom=1in,right=1in]{geometry}
\RequirePackage{setspace}
\RequirePackage{etoolbox}
\RequirePackage{multido}
\RequirePackage{amsmath,amssymb,amsthm}
\RequirePackage{graphicx}

\def\ssp{\def\baselinestretch{1.0}\large\normalsize}
\def\dsp{\def\baselinestretch{1.37}\large\normalsize}

%    ****************************************
%    *             FRONT MATTER             *
%    ****************************************
%

% DECLARATIONS
%
% These macros are used to declare arguments needed for the
% construction of the front matter.

\def\degreemonth#1{\gdef\@degreemonth{#1}}
% The year the degree will be officially conferred
\def\degreeyear#1{\gdef\@degreeyear{#1}}

% The semester (Fall or Spring) the degree will be officially conferred
\def\degreesemester#1{\gdef\@degreesemester{#1}}

% The full (unabbreviated) name of the degree
\def\degree#1{\gdef\@degree{#1}}

% All previous degrees: one per line in chronological order
\def\prevdegrees#1{\gdef\@prevdegrees{#1}}

% The name of your committee's chairs
\def\chairA#1{\gdef\@chairA{#1}}
\def\chairB#1{\gdef\@chairB{#1}}

% The names of your other committe members, one per line
\def\othermembers#1{\gdef\@othermembers{#1}}

% The number of committee members, which affects both the
% number of lines and the amount of space between lines
% on the approval page.
\def\@numberofmembers{1}
\def\@approvalspace{3em}
\def\numberofmembers#1{\gdef\@numberofmembers{#1}
\ifnum \@numberofmembers > 1
\gdef\@approvalspace{2em}
\fi}

% The name of your degree's field (e.g. Psychology, Computer Science)
\def\field#1{\gdef\@field{#1}}

% You have to define the campus name twice because I can't figure out
% how to get the TeX \uppercase macro to work for me (EVM, 9/21/94)

% The name of your UC Campus CAPITALIZED (e.g. Berkeley, Los Angeles)
\def\campus#1{\gdef\@campus{#1}}

% \alwayssingle and \endalwayssingle
%
% These macros define an environment for front matter that is always
% single column even in a double-column document.

\def\alwayssingle{\@restonecolfalse\if@twocolumn\@restonecoltrue\onecolumn
     \else \newpage \fi}

\def\endalwayssingle{\if@restonecol\twocolumn \else \newpage \fi}

% \maketitle outputs the complete titlepage.  It requires all the
% above macros except \campuscap.  It is probably not correct for
% joint (e.g. UCSD/SDSU) degrees.

% Set the font that will be used in the front matter headings
\def\fmfont{\fontsize\@xiipt{14.5}\selectfont}
\def\fmsmallfont{\fontsize\@xiipt{14pt}\selectfont}

\def\maketitle{
{\ssp
\begin{alwayssingle}
    \let\footnotesize\small
    \let\footnoterule\relax
    \thispagestyle{empty}
    \setcounter{page}{1}

    \null\vfil
  \begin{center}
    \fmfont
    UNIVERSITY OF CALIFORNIA \par {\expandafter\uppercase\expandafter{\@campus}} \par
\vspace{6ex}
    \bigskip \medskip
%    {\bfseries {\@title} \par}
    {{\@title} \par}
    \bigskip \medskip
%    by \par
%    \bigskip \medskip
%    {\@author} \par
%\vspace{6ex}
%    {\@prevdegrees} \par
\vspace{6ex}
    A Dissertation submitted in partial satisfaction \par
    of the requirements for the degree of \par
\vspace{6ex}
    {\@degree} \par
    \bigskip \medskip
    in \par
    \bigskip \medskip
    {\@field}\par
    \bigskip \medskip
    by \par
    \bigskip \medskip
    {\@author} \par
    \bigskip \medskip
%    September {\@degreeyear}
    {\@degreemonth} {\@degreeyear}
%    in the \par
%    \bigskip \medskip
%    GRADUATE DIVISION \par
%\smallskip
%    of the \par
%\smallskip
%    UNIVERSITY OF CALIFORNIA \par {\expandafter\uppercase\expandafter{\@campus}}
  \end{center}
{
\vspace{6ex}
    \bigskip \medskip
\fmsmallfont
  Dissertation Committee:
\begin{quote}
{\@chairA}, Co-Chairperson\newline
{\@chairB}, Co-Chairperson\newline
{\@othermembers}
\end{quote}
%  \begin{center}
%    {\@degreemonth} {\@degreeyear}
%  \end{center}
}
    \vfil\null
\end{alwayssingle}

\setcounter{footnote}{0}
}}

% COPYRIGHTPAGE
%
% While it's technically optional, you probably want a copyright page.
% This is a macro, not an environment, because it can be generated
% with the \title, \author, and \year macros.


\def\copyrightpage{
\begin{alwayssingle}
\thispagestyle{empty}
\null\vfill\ssp

\begin{center}
	Copyright by\\
	{\@author}\\
	{\@degreeyear}
\end{center}

\end{alwayssingle}}


% APPROVALPAGE
%
% The \approvalpage macro emits a UC-approved approval page ready for
% your committee's signature.  It is not an automatic part of the
% output because there's really no point in printing it until you are
% ready to get signatures.  It requires the the \numberofmembers,
% \author, and \campus macros have been defined.

\def\approvalpage{
\begin{alwayssingle}
\thispagestyle{empty}
\null\vfill
The Dissertation of {\@author} is approved:

\begin{center}
	\begin{minipage}[]{3.5in}
	\multido{}{\@numberofmembers}{%
		\vskip\@approvalspace
		\rule{\textwidth}{0.5pt}
	}

	\vskip\@approvalspace
	\rule{\textwidth}{0.5pt}
	\vskip-1em\hfill Committee Co-Chairperson

	\vskip\@approvalspace
	\rule{\textwidth}{0.5pt}
	\vskip-1em\hfill Committee Co-Chairperson

	\end{minipage}
	\vfill
	University of California, {\@campus}
\end{center}
\vfill\null
\end{alwayssingle}
}


% ACKNOWLEDGEMENTS
%
% The acknowledgements environment puts a large, bold, centered
% "Acknowledgements" label at the top of the page.

\newenvironment{acknowledgements}
{\begin{alwayssingle}
\setcounter{page}{4}
\begin{center}
{\large \bfseries Acknowledgements}
\end{center}
}
{\end{alwayssingle}}

% DEDICATION
%
% The dedication environment just makes sure the dedication gets its
% own page.

\newenvironment{dedication}
{\begin{alwayssingle}}
{\end{alwayssingle}}


% ABSTRACT
%
% The ABSTRACT environment allows for multi-page abstracts which,
% in accordance with UC rules, is numbered separately from the rest
% of the rest of the dissertation in Arabic.  It requires definition
% of the \title, \author, \degree, \field, \campus, and \chair macros.


\def\abstract{
\begin{alwayssingle}
\pagestyle{plain}
\thispagestyle{plain}
% \thispagestyle{myheadings}
% \setcounter{page}{1}
\begin{center}
{\fmfont
{\expandafter\uppercase\expandafter{\abstractname}} OF THE DISSERTATION\par
\vspace{.5in}
\ssp\@title\par
\vspace{.25in}
by\par
\vspace{.25in}
\@author\par
\vspace{.25in}
{\@degree}, Graduate Program in \@field\par
University of California, {\@campus}, {\@degreemonth} {\@degreeyear}\par
{\@chairA}, Co-Chairperson\par
{\@chairB}, Co-Chairperson
}
\vspace{.25in}
\ssp\end{center}}

\def\endabstract{\par\vfil\null\end{alwayssingle}
}

\def\abstractsignature{
\hspace*{\fill}
\begin{minipage}[t]{3.25in}
\addtolength{\baselineskip}{-.5\baselineskip}
\vspace{1.7cm}
\rule{3.2in}{.5pt}\\
\@chair\\
Dissertation Committee Chair
\end{minipage}}


% FRONTMATTER environment
%
% The FRONTMATTER environment makes sure that page numbering is set
% correctly (roman, lower-case, starting at 3) for the front matter
% that follows the abstract.  It also resets page-numbering for
% the remainder of the dissertation (arabic, starting at 1).

\newenvironment{frontmatter}
{\setcounter{page}{1}\renewcommand{\thepage}{\roman{page}}}
{\newpage\renewcommand{\thepage}{\arabic{page}}\setcounter{page}{1}}

%    ****************************************
%    *         TABLE OF CONTENTS, ETC.      *
%    ****************************************
%
% A \subsection command writes a
%       \contentsline{subsection}{TITLE}{PAGE}
% command on the .toc file, where TITLE contains the contents of the
% entry and PAGE is the page number.  If subsections are being numbered,
% then TITLE will be of the form
%       \numberline{NUM}{HEADING}
% where NUM is the number produced by \thesubsection.  Other sectioning
% commands work similarly.
%
% A \caption command in a 'figure' environment writes
%    \contentsline{figure}{\numberline{NUM}{CAPTION}}{PAGE}
% on the .lof file, where NUM is the number produced by \thefigure and
% CAPTION is the figure caption.  It works similarly for a 'table'
% environment.
%
% The command \contentsline{NAME} expands to \l@NAME.  So, to specify
% the table of contents, we must define \l@chapter, \l@section,
% \l@subsection, ... ; to specify the list of figures, we must define
% \l@figure; and so on.  Most of these can be defined with the
% \@dottedtocline command, which works as follows.
%
% \@dottedtocline{LEVEL}{INDENT}{NUMWIDTH}{TITLE}{PAGE}
%    LEVEL    : An entry is produced only if LEVEL < or = value of
%               'tocdepth' counter.  Note, \chapter is level 0, \section
%               is level 1, etc.
%    INDENT   : The indentation from the outer left margin of the start
%               of the contents line.
%    NUMWIDTH : The width of a box in which the section number is to go,
%               if TITLE includes a \numberline command.
%
% This command uses the following three parameters, which are set
% with a \def (so em's can be used to make them depend upon the font).
%   \@pnumwidth : The width of a box in which the page number is put.
%   \@tocrmarg  : The right margin for multiple line entries.  One
%                 wants \@tocrmarg > or = \@pnumwidth
%   \@dotsep    : Separation between dots, in mu units.  Should be
%                 \def'd to a number like 2 or 1.7

\def\@pnumwidth{1.55em}
\def\@tocrmarg {2.55em}
\def\@dotsep{1}
\setcounter{tocdepth}{3}
\setcounter{secnumdepth}{1}

% TABLEOFCONTENTS
%  In ucthesis style, \tableofcontents, \listoffigures, etc. are always
%  set in single-column style.  @restonecol

\def\tableofcontents{\@restonecolfalse
  \if@twocolumn\@restonecoltrue\onecolumn\fi
  \chapter*{\contentsname
        \@mkboth{\uppercase{\contentsname}}{\uppercase{\contentsname}}}%
  {\ssp\@starttoc{toc}}\if@restonecol\twocolumn\fi}

\def\l@part#1#2{\addpenalty{-\@highpenalty}%
   \addvspace{2.25em plus\p@}% space above part line
   \begingroup
   \@tempdima 3em         % width of box holding part number, used by
     \parindent \z@ \rightskip \@pnumwidth             %% \numberline
     \parfillskip -\@pnumwidth
     {\large \bfseries          % set line in \large boldface
     \leavevmode          % TeX command to enter horizontal mode.
     #1\hfil \hbox to\@pnumwidth{\hss #2}}\par
     \nobreak             % Never break after part entry
    \global\@nobreaktrue                        %% Added 24 May 89 as
    \everypar{\global\@nobreakfalse\everypar{}}%% suggested by
                                               %% Jerry Leichter
   \endgroup}

%% First line of l@chapter changed 24 May 89, as suggested
%% by Jerry Leichter.
%%
\def\l@chapter#1#2{\addpenalty{-\@highpenalty}%
   \vskip 1.0em plus\p@   % space above chapter line
   \@tempdima 1.5em       % width of box holding chapter number
   \begingroup
     \parindent \z@ \rightskip \@pnumwidth
     \parfillskip -\@pnumwidth
     \bfseries                  % Boldface.
     \leavevmode          % TeX command to enter horizontal mode.
      \advance\leftskip\@tempdima  %% added 5 Feb 88 to conform to
      \hskip -\leftskip            %% 25 Jan 88 change to \numberline
     #1\nobreak\hfil \nobreak\hbox to\@pnumwidth{\hss #2}\par
     \penalty\@highpenalty %% added 24 May 89, suggested by J. Leichter
   \endgroup}

\def\l@section{\@dottedtocline{1}{1.5em}{2.3em}}
\def\l@subsection{\@dottedtocline{2}{7em}{3.2em}}
\def\l@subsubsection{\@dottedtocline{3}{7.0em}{4.1em}}
\def\l@paragraph{\@dottedtocline{4}{10em}{5em}}
\def\l@subparagraph{\@dottedtocline{5}{12em}{6em}}

% LIST OF FIGURES
%
% Single-space list of figures, add it to the table of contents.
\def\listoffigures{\@restonecolfalse
  \if@twocolumn\@restonecoltrue\onecolumn\fi
  \chapter*{\listfigurename\@mkboth{\uppercase{\listfigurename}}%
{\uppercase{\listfigurename}}}
   \addcontentsline{toc}{chapter}{\listfigurename}
   {\ssp\@starttoc{lof}}\if@restonecol
    \twocolumn\fi}

\def\l@figure{\@dottedtocline{1}{1.5em}{2.3em}}

% LIST OF TABLES
%
\def\listoftables{\@restonecolfalse
  \if@twocolumn\@restonecoltrue\onecolumn\fi
  \chapter*{\listtablename\@mkboth{\uppercase{\listtablename}}%
   {\uppercase{\listtablename}}}\@starttoc{lot}\if@restonecol
  \twocolumn\fi}
\def\listoftables{\@restonecolfalse
  \if@twocolumn\@restonecoltrue\onecolumn\fi
  \chapter*{\listtablename\@mkboth{\uppercase{\listtablename}}%
{\uppercase{\listtablename}}}
   \addcontentsline{toc}{chapter}{\listtablename}
   {\ssp\@starttoc{lot}}\if@restonecol
  \twocolumn\fi}

\let\l@table\l@figure

\doublespacing

\AtBeginEnvironment{biblist}{%
	\singlespacing
}

\widowpenalty=10000
\clubpenalty=10000

\endinput
