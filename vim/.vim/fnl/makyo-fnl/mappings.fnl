;;;; General user mappings not necessarily tied to any layers
(module makyo-fnl.mappings
  {require {a aniseed.core
            nvim aniseed.nvim
            {: normal-mode-layers
             : visual-mode-layers} makyo-fnl.plugins.which-key}})

(local keymap nvim.set_keymap)
(local svar nvim.set_var)

(defn- setup-better-regexes []
  (do
    (keymap "n" "/" "/\\v" {:noremap true})
    (keymap "n" "?" "?\\v" {:noremap true})

    (keymap "c" "s/" "s/\\v" {:noremap true})
    (keymap "c" "%s/" "%s/\\v" {:noremap true})

    (keymap "v" "/" "/\\v" {:noremap true})
    (keymap "v" "/" "/\\v" {:noremap true})))

(defn- setup-normal-mode-mappings []
  (do
    ;; Easier window navigation
    (keymap "n" "<C-h>" "<C-w>h" {:noremap true})
    (keymap "n" "<C-j>" "<C-w>j" {:noremap true})
    (keymap "n" "<C-k>" "<C-w>k" {:noremap true})
    (keymap "n" "<C-l>" "<C-w>l" {:noremap true})

    ;; Easier navigation on line-wrapped text
    (keymap "n" "j" "gj" {:noremap true})
    (keymap "n" "k" "gk" {:noremap true})
    (keymap "n" "gj" "j" {:noremap true})
    (keymap "n" "gk" "k" {:noremap true})))

(defn- setup-command-mode-mappings []
  (do
    ;; Heretical mappings
    ;; Ctrl + a --> Jump to beginning of line
    ;; Ctrl + b --> Back one character
    ;; Ctrl + d --> Delete one character
    ;; Ctrl + e --> Jump to end of line
    ;; Ctrl + f --> Forward one character
    ;; Ctrl + n --> Go forwards in history to the a newer entry
    ;; Ctrl + p --> Go backwards in history to an older entry
    (keymap "c" "<C-A>" "<Home>"  {:noremap true})
    (keymap "c" "<C-B>" "<Left>"  {:noremap true})
    (keymap "c" "<C-D>" "<Del>"   {:noremap true})
    (keymap "c" "<C-E>" "<End>"   {:noremap true})
    (keymap "c" "<C-F>" "<Right>" {:noremap true})
    (keymap "c" "<C-N>" "<Down>"  {:noremap true})
    (keymap "c" "<C-P>" "<Up>"    {:noremap true})))

(defn- setup-insert-mode-mappings []
  (do
    (keymap "i" "<C-l>" "<Plug>(coc-snippets-expand)" {})
    (keymap "i" "<C-j>" "<Plug>(coc-snippets-expand-jump)" {})

    ;; jk --> Escape from insert mode without stretching your fingers
    (keymap "i" "jk" "<ESC>" {:noremap true})
    ;; Ctrl + U --> CTRL-U in insert mode deletes a lot. Use CTRL-G u to first break undo
    (keymap "i" "<C-U>" "<C-G>u<C-U>" {:noremap true})
    ;; Ctrl + d --> Delete text after the cusor position in insert mode.
    (keymap "i" "<C-d>" "<C-[>ld$A" {:noremap true})))

(defn- setup-visual-mode-mappings []
  (do
    (keymap "v" "<enter>" "<Plug>(EasyAlign)" {})
    (keymap "v" "<C-j>" "<Plug>(coc-snippets-select)" {})

    (keymap "v" "<leader>*" ":<C-u>call VisualStarSearchSet('/', 'raw')<CR>:call ag#Ag('grep' '--literal ' . shellescape(@/))<CR>" {:noremap true})

    ;; LISP mode visual mappings
    (keymap "v" "<leader>mlc" ":execute 'normal gv' . maplocalleader . 'Ea('<CR>" {:noremap true})
    (keymap "v" "<leader>mlE" ":execute 'normal gv' . maplocalleader . 'E'<CR>"   {:noremap true})
    (keymap "v" "<leader>mlw" ":execute 'normal gv' . maplocalleader . 'Eiw'<CR>" {:noremap true})))

(defn- setup-terminal-mode-mappings []
  (do
    ;; Navigate windows from the terminal using Alt + h/j/k/l
    (keymap "t" "<A-h>" "<C-><C-N><C-w>h" {:noremap true})
    (keymap "t" "<A-j>" "<C-><C-N><C-w>j" {:noremap true})
    (keymap "t" "<A-k>" "<C-><C-N><C-w>k" {:noremap true})
    (keymap "t" "<A-l>" "<C-><C-N><C-w>l" {:noremap true})

    ;; Simulate i_CTRL-R for inserting the contents of a register
    (keymap "t" "<expr> <C-R>" "'<C-\\><C-N>\"' . nr2char(getchar()) . 'pi'" {:noremap true})

    ;; Exit terminal mode easily
    (keymap "t" "<Esc>"      "<C-\\><C-N>" {:noremap true})
    (keymap "t" "<M-[>"      "<Esc>"       {:noremap true})
    (keymap "t" "<C-v><Esc>" "<Esc>"       {:noremap true})))

(defn- setup-mappings []
  (do
    (keymap "" ";" "<Plug>(clever-f-repeat-forward)" {})
    (keymap "" "," "<Plug>(clever-f-repeat-back)" {})

    (keymap "" "<Leader><TAB>" ":b#<cr>" {})

    (keymap "" "tc" ":tabnew<CR>" {:noremap true})))

(defn- setup-which-key-mappings []
  (do
    (svar "mapleader" " ")
    (svar "maplocalleader" ",")
    (svar "which_key_map" normal-mode-layers)
    (svar "which_key_map_visual" visual-mode-layers)

    (keymap "n" "<leader>" ":<c-u>WhichKey '<Space>'<CR>" {:silent true :noremap true})
    (keymap "v" "<leader>" ":<c-u>WhichKeyVisual '<Space>'<CR>" {:silent true :noremap true})

    (nvim.call_function "which_key#register" ["<Space>" "g:which_key_map" "n"])
    (nvim.call_function "which_key#register" ["<Space>" "g:which_key_map_visual" "v"])))

(defn init []
  (do
    (a.println "[makyo] 🗝 Applying custom mappings...")

    (setup-better-regexes)
    (setup-normal-mode-mappings)
    (setup-command-mode-mappings)
    (setup-insert-mode-mappings)
    (setup-visual-mode-mappings)
    (setup-terminal-mode-mappings)
    (setup-mappings)
    (setup-which-key-mappings)

    (a.println "[makyo] 🗝 Done.")))
