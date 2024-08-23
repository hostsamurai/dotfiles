(module makyo-fnl.plugins.which-key.utils
  {require {a aniseed.core
            nvim aniseed.nvim}})

(defn prompt-and-run [prompt command]
  (let [user-input (nvim.fn.input prompt)]
    (nvim.fn.inputsave)
    (a.println "Value from user: " user-input)
    (nvim.exec (.. command user-input) true)
    (nvim.fn.inputrestore)))
