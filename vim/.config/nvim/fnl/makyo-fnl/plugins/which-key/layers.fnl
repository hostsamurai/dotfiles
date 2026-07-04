;;;; Layer definitions

(import-macros {: module
                : def}
               :nfnl.macros.aniseed)

(module makyo-fnl.plugins.which-key.layers)

(local {: merge} (require :nfnl.core))
(local utils (require :makyo-fnl.plugins.which-key.utils))

(local {: root-mappings} (require :makyo-fnl.plugins.which-key.layers.normal.root))
(local {: application-layer} (require :makyo-fnl.plugins.which-key.layers.normal.application))
(local {: buffer-layer} (require :makyo-fnl.plugins.which-key.layers.normal.buffer))
(local {: comment-and-compile-layer} (require :makyo-fnl.plugins.which-key.layers.normal.comment-and-compile))
(local {: file-layer} (require :makyo-fnl.plugins.which-key.layers.normal.file))
(local {: fzf-layer} (require :makyo-fnl.plugins.which-key.layers.normal.fzf))
(local {: version-control-layer} (require :makyo-fnl.plugins.which-key.layers.normal.version-control))
(local {: insertion-layer} (require :makyo-fnl.plugins.which-key.layers.normal.insertion))
(local {: jumps-and-folds-layer} (require :makyo-fnl.plugins.which-key.layers.normal.jump-and-folds))
(local {: modes-layer} (require :makyo-fnl.plugins.which-key.layers.normal.modes))
(local {: notifications-layer} (require :makyo-fnl.plugins.which-key.layers.normal.notifications))
(local {: project-layer} (require :makyo-fnl.plugins.which-key.layers.normal.project))
(local {: plugins-layer} (require :makyo-fnl.plugins.which-key.layers.normal.plugins))
(local {: search-layer} (require :makyo-fnl.plugins.which-key.layers.normal.search))
(local {: spelling-layer} (require :makyo-fnl.plugins.which-key.layers.normal.spelling))
(local {: toggles-layer} (require :makyo-fnl.plugins.which-key.layers.normal.toggles))
(local {: windows-layer} (require :makyo-fnl.plugins.which-key.layers.normal.windows))
(local {: text-layer} (require :makyo-fnl.plugins.which-key.layers.normal.text))
(local {: visual-fzf-layer} (require :makyo-fnl.plugins.which-key.layers.visual.fzf))
(local {: visual-modes-layer} (require :makyo-fnl.plugins.which-key.layers.visual.modes))
(local {: visual-comment-and-compile-layer} (require :makyo-fnl.plugins.which-key.layers.visual.comment-and-compile))
(local {: visual-version-control-layer} (require :makyo-fnl.plugins.which-key.layers.visual.version-control))

(def normal-mode-layers
  (merge
      root-mappings
      application-layer
      buffer-layer
      comment-and-compile-layer
      file-layer
      fzf-layer
      version-control-layer
      insertion-layer
      jumps-and-folds-layer
      modes-layer
      notifications-layer
      project-layer
      plugins-layer
      search-layer
      spelling-layer
      toggles-layer
      windows-layer
      text-layer
      ))

(def visual-mode-layers
  (merge
      visual-fzf-layer
      visual-modes-layer
      visual-comment-and-compile-layer
      visual-version-control-layer
      ))
