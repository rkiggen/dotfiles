(setq templateFile "essentialit.sty")
(setq templateFolder (file-name-directory (or load-file-name buffer-file-name)))
(setq templatePath(concat templateFolder templateFile))

;; Replace <templatefolder> string with actual path
;; (replace-regexp-in-string "REGEXP" REP "STRING" &optional FIXEDCASE LITERAL SUBEXP START)
;; set FIXEDCASE argument to t for turning of emacs smart case-sensitity system
(setq template  (replace-regexp-in-string  "<templatefolder>"  templateFolder (get-string-from-file templatePath) t t))

(provide 'essentialit)

(add-to-list 'org-latex-classes
  `("essentialit" ,template
	("\\section{%s}" . "\\section*{%s}")
	("\\subsection{%s}" . "\\subsection*{%s}")
	("\\subsubsection{%s}" . "\\subsubsection*{%s}")
	("\\paragraph{%s}" . "\\paragraph*{%s}")
	("\\subparagraph{%s}" . "\\subparagraph*{%s}") )
)
	 
(setq org-latex-to-pdf-process 
  '("xelatex -interaction nonstopmode %f"
     "xelatex -interaction nonstopmode %f")) ;; for multiple passes