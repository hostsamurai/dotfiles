;;;; Layer definitions

(module makyo-fnl.plugins.which-key.layers
  {require {a aniseed.core}
   autoload {utils makyo-fnl.plugins.which-key.utils
             {: root-mappings} makyo-fnl.plugins.which-key.layers.normal.root
             {: application-layer} makyo-fnl.plugins.which-key.layers.normal.application
             {: buffer-layer} makyo-fnl.plugins.which-key.layers.normal.buffer
             {: comment-and-compile-layer} makyo-fnl.plugins.which-key.layers.normal.comment-and-compile
             {: file-layer} makyo-fnl.plugins.which-key.layers.normal.file
             {: fzf-layer} makyo-fnl.plugins.which-key.layers.normal.fzf
             {: version-control-layer} makyo-fnl.plugins.which-key.layers.normal.version-control
             {: insertion-layer} makyo-fnl.plugins.which-key.layers.normal.insertion
             {: jumps-and-folds-layer} makyo-fnl.plugins.which-key.layers.normal.jump-and-folds
             {: modes-layer} makyo-fnl.plugins.which-key.layers.normal.modes
             {: project-layer} makyo-fnl.plugins.which-key.layers.normal.project
             {: plugins-layer} makyo-fnl.plugins.which-key.layers.normal.plugins
             {: search-layer} makyo-fnl.plugins.which-key.layers.normal.search
             {: spelling-layer} makyo-fnl.plugins.which-key.layers.normal.spelling
             {: toggles-layer} makyo-fnl.plugins.which-key.layers.normal.toggles
             {: windows-layer} makyo-fnl.plugins.which-key.layers.normal.windows
             {: text-layer} makyo-fnl.plugins.which-key.layers.normal.text
             {: visual-modes-layers} makyo-fnl.plugins.which-key.layers.visual.modes
             {: visual-comment-and-compile-layer} makyo-fnl.plugins.which-key.layers.visual.comment-and-compile
             {: visual-version-control-layer} makyo-fnl.plugins.which-key.layers.visual.version-control}})

(def normal-mode-layers
  (a.merge
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
      project-layer
      plugins-layer
      search-layer
      spelling-layer
      toggles-layer
      windows-layer
      text-layer
      ))

(def visual-mode-layers
  (a.merge
      visual-modes-layers
      visual-comment-and-compile-layer
      visual-version-control-layer
      ))
