(import-macros {
                : module
                : def-
                : def
                : defn-
                }
                :nfnl.macros.aniseed)
(import-macros {: if-let} :nfnl.macros)

(module :config.keymaps)

(local utils (require :utils.helpers))
(local harper (require :keymaps.harper))

(def- keymap vim.api.nvim_set_keymap)

(defn- setup-insert-mode-mappings []
  (do
    ;; jk --> Escape from insert mode without stretching your fingers
    (keymap "i" "jk" "<ESC>" {:desc "Escape insert mode" :noremap true})
    ;; Ctrl + d --> Delete text after the cusor position in insert mode.
    (keymap "i" "<C-d>" "<C-[>ld$A" {:desc "Delete text after cursor" :noremap true})

    (if-let [result (utils.is-linux?)]
      ;; Ctrl + v --> Paste from global register
      (keymap "i" "<C-v>" "<C-R>+" {:desc "Paste from global register" :noremap true :silent true})
      ;; Cmd + v --> do the same but for OS X
      (keymap "i" "<D-v>" "<C-R>+" {:desc "Paste from global register" :noremap true :silent true}))))

(defn- setup-terminal-mode-mappings []
  (do
    ;; Simulate i_CTRL-R for inserting the contents of a register
    (keymap "t" "<expr> <C-R>" "'<C-\\><C-N>\"' . nr2char(getchar()) . 'pi'" {:noremap true})

    ;; Exit terminal mode easily
    (keymap "t" "<Esc>"      "<C-\\><C-N>" {:desc "Escape term mode" :noremap true})
    (keymap "t" "<M-[>"      "<Esc>"       {:desc "Escape term mode" :noremap true})
    (keymap "t" "<C-v><Esc>" "<Esc>"       {:desc "Escape term mode" :noremap true})))

(defn- setup-mappings []
  (do
    ;; Easily switch to the last buffer
    (keymap "" "<leader><TAB>" ":b#<cr>" {:desc "Switch to previous buffer"})
    ;; Easily open a new tab
    (keymap "" "tc" ":tabnew<CR>" {:desc "Open new tab" :noremap true})
    ;; Clear search highlights 
    (keymap "n" "<leader>sz" ":nohlsearch<cr>" {:desc "Clear highlights"})
    ))

(do
  (setup-insert-mode-mappings)
  (setup-terminal-mode-mappings)
  (setup-mappings)
  (harper.setup-keymap))
