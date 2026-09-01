(import-macros {
                : module
                : defn 
                : def  
                } :nfnl.macros.aniseed)

(module :keymaps.harper)

(local {
        : concat 
        : count
        : distinct
        : get-in
        : kv-pairs
        : println 
        : pr-str
        : reduce
        } (require :nfnl.core))

(defn collect-flagged-words-in-selection []
  (let [bufnr (vim.api.nvim_get_current_buf)
        s (vim.fn.getpos "v")
        e (vim.fn.getpos ".")
        ;; Convert to 0-indexed line/col for vim.diagnostic
        sel-start {:line (- (. s 2) 1) :character (. s 3)}
        sel-end {:line (- (. e 2) 1) :character (. e 3)}
        diags (vim.diagnostic.get bufnr)
        ]
    (reduce (fn [words [_ diag]]
              (let [r (get-in diag [:user_data :lsp :range])
                    start-row (get-in r [:start :line])  
                    start-col (get-in r [:start :character])
                    end-row (get-in r [:end :line])
                    end-col (get-in r [:end :character])
                    ]
                ;; Check if the diagnostic overlaps with the selection. 
                (if (and start-row start-col end-row end-col 
                         (>= start-row sel-start.line) (<= start-row sel-end.line))
                  (let [word (vim.api.nvim_buf_get_text 
                               bufnr 
                               start-row start-col 
                               end-row end-col
                               {}
                               )]
                    (concat words word))
                  words))) 
             []
             (kv-pairs diags))))

;; Put result in a register and print
(defn put-results-in-register-and-report [unique-words]
  (let [result (pr-str unique-words)]
    (vim.fn.setreg "+" result)
    (println (.. "Flagged words (" (count unique-words) "): " result))))

;; Append to .harper-dictionary.txt
(defn append-to-dictionary []
  (let [dict-path (.. (vim.fn.getcwd) "/.harper-dictionary.txt")
        f (io.open dict-path :a)
        unique-words (distinct (collect-flagged-words-in-selection))]
    (put-results-in-register-and-report unique-words)
    (when f
      (each [_ w (ipairs unique-words)]
        (f:write (.. w "\n"))))
      (f:close)))

;; Map: v, then press <leader>hw to collect flagged words from selection
;; and add them to the workspace dictionary.
(defn setup-keymap []
  (vim.keymap.set :v "<leader>hw" append-to-dictionary))
