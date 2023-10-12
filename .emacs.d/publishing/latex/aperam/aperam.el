(setq templateFile "aperam.sty")
(setq templateFolder (file-name-directory (or load-file-name buffer-file-name)))
(setq templatePath(concat templateFolder templateFile))
(setq template  (replace-regexp-in-string  "<TEMPLATEFOLDER>"  templateFolder (get-string-from-file templatePath)))

(provide 'aperam)

(add-to-list 'org-latex-classes
  `("aperam" ,template
	("\\section{%s}" . "\\section*{%s}")
	("\\subsection{%s}" . "\\subsection*{%s}")
	("\\subsubsection{%s}" . "\\subsubsection*{%s}")
	("\\paragraph{%s}" . "\\paragraph*{%s}")
	("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
)
	 
(setq org-latex-to-pdf-process 
  '("xelatex -interaction nonstopmode %f"
     "xelatex -interaction nonstopmode %f")) ;; for multiple passes