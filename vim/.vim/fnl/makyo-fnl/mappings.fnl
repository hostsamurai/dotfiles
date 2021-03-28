;;;; General user mappings not necessarily tied to any layers
(module makyo-fnl.mappings
  {require {a aniseed.core
            nvim aniseed.nvim
            which_key_config makyo-fnl.plugins.which-key}})

(defn- setup_better_regexes []
  (let [keymap vim.api.nvim_set_keymap]
    (keymap "n" "/" "/\\v" {:noremap true})
    (keymap "n" "?" "?\\v" {:noremap true})
    
    (keymap "c" "s/" "s/\\v" {:noremap true})
    (keymap "c" "%s/" "%s/\\v" {:noremap true})
    
    (keymap "v" "/" "/\\v" {:noremap true})
    (keymap "v" "/" "/\\v" {:noremap true})))

(defn- setup_normal_mode_mappings []
  (let [keymap vim.api.nvim_set_keymap]
    ;; Easier window navigation
    (keymap "n" "<C-h>" "<C-w>h" {:noremap true})
    (keymap "n" "<C-j>" "<C-w>j" {:noremap true})
    (keymap "n" "<C-k>" "<C-w>k" {:noremap true})
    (keymap "n" "<C-l>" "<C-w>l" {:noremap true})))

(defn- setup_command_mode_mappings []
  (let [keymap vim.api.nvim_set_keymap]
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

(defn- setup_insert_mode_mappings []
  (let [keymap vim.api.nvim_set_keymap]
    (keymap "i" "<C-l>" "<Plug>(coc-snippets-expand)" {})
    (keymap "i" "<C-j>" "<Plug>(coc-snippets-expand-jump)" {})

    ;; jk --> Escape from insert mode without stretching your fingers
    (keymap "i" "jk" "<ESC>" {:noremap true})
    ;; Ctrl + U --> CTRL-U in insert mode deletes a lot. Use CTRL-G u to first break undo
    (keymap "i" "<C-U>" "<C-G>u<C-U>" {:noremap true})
    ;; Ctrl + d --> Delete text after the cusor position in insert mode.
    (keymap "i" "<C-d>" "<C-[>ld$A" {:noremap true})))

(defn- setup_visual_mode_mappings []
  (let [keymap vim.api.nvim_set_keymap]
    (keymap "v" "<enter>" "<Plug>(EasyAlign)" {})
    (keymap "v" "<C-j>" "<Plug>(coc-snippets-select)" {})

    (keymap "v" "<leader>*" ":<C-u>call VisualStarSearchSet('/', 'raw')<CR>:call ag#Ag('grep' '--literal ' . shellescape(@/))<CR>" {:noremap true})

    ;; LISP mode visual mappings
    (keymap "v" "<leader>mlc" ":execute 'normal gv' . maplocalleader . 'Ea('<CR>" {:noremap true})
    (keymap "v" "<leader>mlE" ":execute 'normal gv' . maplocalleader . 'E'<CR>"   {:noremap true})
    (keymap "v" "<leader>mlw" ":execute 'normal gv' . maplocalleader . 'Eiw'<CR>" {:noremap true})))

(defn- setup_terminal_mode_mappings []
  (let [keymap vim.api.nvim_set_keymap]
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

(defn- setup_mappings []
  (let [keymap vim.api.nvim_set_keymap]
    (keymap "" ";" "<Plug>(clever-f-repeat-forward)" {})
    (keymap "" "," "<Plug>(clever-f-repeat-back)" {})

    (keymap "" "<Leader><TAB>" ":b#<cr>" {})

    ;; Easier navigation on line-wrapped text
    (keymap "" "j" "gj" {:noremap true})
    (keymap "" "k" "gk" {:noremap true})
    (keymap "" "gj" "j" {:noremap true})
    (keymap "" "gk" "k" {:noremap true})

    (keymap "" "tc" ":tabnew<CR>" {:noremap true})))

;; NOTE: Resetting these mappings currently does not work.
;; Mappings need to be unbound before being able to set again.
;; It would be ideal to have a diff of what changed, so as to 
;; only reset the affected mappings.
(defn- setup_which_key_mappings []
  (let [svar vim.api.nvim_set_var
        keymap vim.api.nvim_set_keymap]
    (svar "mapleader" " ")
    (svar "maplocalleader" ",")
    (svar "which_key_map" (which_key_config.setup))

    (keymap "n" "<leader>" ":<c-u>WhichKey '<Space>'<cr>" {:noremap true})
    (keymap "v" "<leader>" ":<c-u>WhichKeyVisual '<Space>'<cr>" {:noremap true})))

(defn init []
  (do 
    (a.println "[makyo] 🗝 Applying custom mappings...")

    (setup_better_regexes)
    (setup_normal_mode_mappings)
    (setup_command_mode_mappings)
    (setup_insert_mode_mappings)
    (setup_visual_mode_mappings)
    (setup_terminal_mode_mappings)
    (setup_mappings)
    (setup_which_key_mappings)

    (a.println "[makyo] 🗝 Done.")))
