(provide 'tufte-book)
  
  
(add-to-list 'org-latex-classes
  '("tufte-book"
"
\\documentclass[a4paper, sfsidenotes, justified, notitlepage]{tufte-book}
\\usepackage[scaled=0.95]{roboto}
\\usepackage{mathpazo}
\\linespread{1.05}
\\usepackage{eulervm}
\\usepackage[usenames]{xcolor}

%% footnote color
\\renewcommand{\\thefootnote}{\\textcolor{Gray}{\\arabic{footnote}}}
\\makeatletter

%%
%% chapter number style
%%

\\usepackage{titlesec}
\\definecolor{gray75}{gray}{0.75}
\\newcommand{\\hsp}{\\hspace{0pt}}
\\titleformat{\\chapter}[hang]{\\flushright
\\fontseries{b}\\fontsize{60}{80}\\selectfont}{\\fontseries{b}\\fontsize{80}{110}\\selectfont
\\textcolor{gray75}\\thechapter\\hsp}{0pt}{\\\\
\\Huge\\bfseries}[]

% \\renewcommand{\\chapterNumber}{%
%  \\fontsize{70}{70}\\usefont{\\encodingdefault}{\\sfdefault}{b}{n}}

\\renewcommand\\@footnotetext[2][0pt]{%
  \\marginpar{%
    \\hbox{}\\vspace*{#1}%
    \\def\\baselinestretch {\\setspace@singlespace}%
    \\reset@font\\footnotesize%
    \\@tufte@margin@par% use parindent and parskip settings for marginal text
    \\vspace*{-1\\baselineskip}\\noindent%
    \\protected@edef\\@currentlabel{%
       \\csname p@footnote\\endcsname\\@thefnmark%
    }%
    \\color{Gray}
    % \\sffamily 
    \\color@begingroup%
       \\@makefntext{%
         \\ignorespaces#2%
       }%
    \\color@endgroup%
  }%
}%

\\makeatother

%%==============================================================================
%%                                 SECTIONS
%%==============================================================================
%% section numbering to subsection
\\setcounter{secnumdepth}{3}
\\renewcommand{\\thesection}{\\Roman{section}}
\\renewcommand{\\thesubsection}{\\thesection.\\Alph{subsection}}
\\renewcommand{\\thesubsubsection}{\\thesubsection\\arabic{subsubsection})}
\\renewcommand{\\theparagraph}{\\roman{paragraph}}
 
%%==============================================================================
%%                                 COLORS
%%==============================================================================
%% section format
\\titleformat{\\section}%
  {\\normalfont\\Large\\itshape\\color{Cerulean}}% format applied to label+text
  {\\llap{\\colorbox{Cerulean}{\\parbox{1.5cm}{\\hfill\\color{white}\\thesection}}}}% label
  {1em}% horizontal separation between label and title body
  {}% before the title body
  []% after the title body

% subsection format
\\titleformat{\\subsection}%
  {\\normalfont\\large\\itshape\\color{TealBlue}}% format applied to label+text
  {\\llap{\\colorbox{TealBlue}{\\parbox{1.5cm}{\\hfill\\color{white}\\thesubsection}}}}% label
  {1em}% horizontal separation between label and title body
  {}% before the title body
  []% after the title body

\\renewcommand{\\footnotesize}{\\scriptsize}
\\setcaptionfont{\\color{SeaGreen}\\footnotesize}
\\setsidenotefont{\\color{Gray}\\sffamily\\footnotesize}
\\setmarginnotefont{\\color{SeaGreen}\\itshape\\footnotesize}"

	("\\part{%s}" . "\\part*{%s}")
	("\\chapter{%s}" . "\\chapter*{%s}")
	("\\section{%s}" . "\\section*{%s}")
	("\\subsection{%s}" . "\\subsection*{%s}")))	 