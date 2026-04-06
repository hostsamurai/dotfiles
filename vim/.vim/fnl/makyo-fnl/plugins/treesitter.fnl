;;; Configures everything dealing with Treesitter
(module makyo-fnl.plugins.treesitter
  {autoload {a aniseed.core
             nvim aniseed.nvim
             utils makyo-fnl.utils}
   import-macros [[ac :aniseed.macros.autocmds]]})

(defn- setup []
  "Configures treesitter"
  (let [ts (utils.safe-require "nvim-treesitter")
        ensure-installed ["lua"
                          "luap"
                          "vim"
                          "vimdoc"
                          "clojure"
                          "commonlisp"
                          "fennel"
                          "http"
                          "javascript"
                          "typescript"
                          "markdown"
                          "markdown_inline"
                          "html"
                          "css"
                          "scss"
                          "ruby"]]
    (do
      (ts.setup {:autotag {:enable true}})
      (ts.install ensure-installed)
      (ac.autocmd
        [:FileType] {:group (ac.augroup "treesitter.setup")
                     :callback (fn [args]
                                 (let [buf args.buf
                                       filetype args.match
                                       language (or (vim.treesitter.language.get_lang filetype) filetype)]
                                   ;; need some mechanism to avoid running on buffers that
                                   ;; do not correspond to a language.
                                   (if (vim.treesitter.language.add language)
                                     (do
                                       ;; replicate `fold = { enable = true }`
                                       (set nvim.wo.foldmethod "expr")
                                       (set nvim.wo.foldexpr "v:lua.vim.treesitter.foldexpr()")
                                       ;; replicate `highlight = { enable = true }`
                                       (vim.treesitter.start buf language)
                                       ;; replicate `indent = { enable = true }`
                                       (set nvim.bo.indentexpr "v:lua.require'nvim-treesitter'.indentexpr()")))))}))))

(defn init []
  (do
    (a.println "[makyo][plugins][treesitter] Setting up ...")
    (setup)
    (a.println "[makyo][plugins][treesitter] Done.")))
