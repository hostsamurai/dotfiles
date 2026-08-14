(import-macros {
                : module
                : def
                : defn-
                }
               :nfnl.macros.aniseed)

(module :config.options)

(local {: trimr} (require :nfnl.string))
(local {
        : run-command 
        : is-darwin?
        : is-linux?
        } (require :utils.helpers))

(defn- set-global-options []
  (let [o vim.o 
        nvim-config-dir (vim.fn.stdpath "config")
        backup-dir (.. nvim-config-dir "/backups")]
    ;; Keep backups of files when necessary
    (set o.backup true)
    (set o.backupdir backup-dir)
    (set o.writebackup true)
    (set o.matchpairs "(:),{:},[:],<:>")
    (vim.opt.sessionoptions:append ["localoptions" "winpos"])))

(defn- set-ui-options []
  (let [o vim.o
        g vim.g]
    ;; NOTE: There are various other fonts that look good here:
    ;; -  Iosevka NFM:h11.0 - Ioskeley Mono is derived from it, but
    ;;                        Iosesvka features much tighter tracking
    ;;                        and is more compact, which is good for
    ;;                        small screens.
    ;; - Maple Mono NF Thin:h11.0 - The thin variant looks the best of
    ;;                              the three available variants.
    ;; - Lilex Nerd Font Mono:h10.5 - A little larger than the other
    ;;                                fonts, so downsizing it a bit
    ;;                                helps make it look better.
    (when is-darwin?
      (set o.guifont "FiraCode Nerd Font:h12.5"))
    (when (and g.neovide is-linux?)
      (set o.guifont "IoskeleyMono Nerd Font SemiCondensed Medium:h11.5:b")
      (set g.neovide_text_gamma 0.9)
      (set g.neovide_text_contrast 0.1))
    (set o.linespace 3)))

(do 
  (set-global-options)
  (set-ui-options))
