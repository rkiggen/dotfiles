(provide 'mimore)

(add-to-list 'org-latex-classes  
			 '("mimore"  
				"\\\\documentclass{mimore}  
				[NO-DEFAULT-PACKAGES]  
				[PACKAGES]  
				[EXTRA]"  
				("\\section{%s}" . "\\section\*{%s}")  
				("\\subsection{%s}" . "\\subsection\*{%s}")  
				("\\subsubsection{%s}" . "\\subsubsection\*{%s}")  
				("\\paragraph{%s}" . "\\paragraph\*{%s}")  
				("\\subparagraph{%s}" . "\\subparagraph\*{%s}")))