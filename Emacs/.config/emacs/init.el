(when (file-readable-p (concat (getenv "XDG_CONFIG_HOME") "/emacs/config.org"))
  (org-babel-load-file (expand-file-name (concat (getenv "XDG_CONFIG_HOME") "/emacs/config.org"))))
