;; Cross platform code for starting emacs full screen
;; has to be in the early-init file otherwise you get a flicker
(push '(fullscreen . maximized) default-frame-alist)
