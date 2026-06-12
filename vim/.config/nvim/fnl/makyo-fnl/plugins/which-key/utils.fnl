(import-macros {: module
                : def
                : defn
                }
                :nfnl.macros.aniseed)

(module makyo-fnl.plugins.which-key.utils)

(defn fn? [sym]
  (= (type sym) "function"))

(defn prompt-and-run [prompt command]
  (vim.ui.input {:prompt prompt} (fn [user-input]
                                   (let [input (vim.fn.shellescape user-input)]
                                     (if (not (fn? command))
                                       (vim.api.nvim_exec2 (.. command " " input) {:output true})
                                       (command input))))))
