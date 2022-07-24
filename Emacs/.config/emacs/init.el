(defconst jl/config-file (expand-file-name (concat (getenv "XDG_CONFIG_HOME")
						   "/emacs/config.el")))
(defconst jl/config-file-org (expand-file-name (concat (getenv "XDG_CONFIG_HOME")
                                                       "/emacs/README.org")))

(setq custom-file (expand-file-name (concat (getenv "XDG_CONFIG_HOME")
					    "/emacs/custom.el"))
      gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024))

(cond ((file-readable-p jl/config-file) (load jl/config-file))
      ((file-readable-p jl/config-file-org)
       (require 'org)
       (org-babel-tangle-file jl/config-file-org)
       (load jl/config-file)))

(when (file-readable-p custom-file)
  (load custom-file))
