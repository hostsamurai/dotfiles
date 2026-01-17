(module makyo-fnl.plugins.which-key.utils
  {require {s aniseed.string
            nvim aniseed.nvim}})

(defn fn? [sym]
  (= (type sym) "function"))

(defn prompt-and-run [prompt command]
  (let [user-input (nvim.fn.input prompt)]
    (nvim.fn.inputsave)
    (if (not (fn? command))
      (nvim.exec2 (.. command " " user-input) {})
      (command user-input))
    (nvim.fn.inputrestore)))
