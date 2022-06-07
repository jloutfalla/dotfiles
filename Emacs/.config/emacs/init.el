(setq config-file
      (expand-file-name (concat (getenv "XDG_CONFIG_HOME")
                                "/emacs/config.el"))
      custom-file
      (expand-file-name (concat (getenv "XDG_CONFIG_HOME")
                                "/emacs/custom.el")))

(setq gc-cons-threshold (* 50 1000 1000))

(when (file-readable-p config-file)
  (load config-file))

(setq gc-cons-threshold (* 2 1000 1000))

(when (file-readable-p custom-file)
  (load custom-file))
