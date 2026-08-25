#!/usr/bin/env bb

(ns lsp
  (:require
   [babashka.fs :as fs]
   [babashka.process :as process]))

;; We're going to bootstrap the necessary dependencies to get our 
;; lesser-known LISP LSPs set up and working. First, we start out 
;; with the easiest, the Racket language server.
(defn install-racket-langserver
  "Installs the racket language server with the `raco pkg install` 
  command. Run the server with `racket -l racket-langserver`."
  []
  (process/shell {:continue true} "raco pkg install racket-langserver"))

;; Now, we set up the one for the different Scheme flavors. First, 
;; Chicken Scheme.
(defn install-chicken-language-server
  "Installs the language server for Chicken Scheme, along with its 
  dependencies."
  []
  (process/shell "chicken-install -s r7rs apropos chicken-doc srfi-18 lsp-server"))

;; For Guile, we use guix. We set it up if not already installed.
(defn install-guix
  "Installs the guix package mananger to manage the Guile LSP."
  []
  (let [install-dir (str fs/xdg-cache-home "/guix")]
    (process/shell (str "mkdir " install-dir))
    (process/shell {:dir install-dir} "wget https://guix.gnu.org/guix-install.sh")
    (process/shell {:dir install-dir} "chmod +x guix-install.sh")
    (process/shell {:dir install-dir} "sudo ./guix-install.sh")))

(defn install-guile-lsp-server
  "Installs the Guile LSP using guix."
  []
  (install-guix)
  (process/shell "guix install guile-lsp-server"))

;; Finally, we set up the language server for Common Lisp.
(defn install-qlot
  "Installs the first dependency for the Common Lisp LSP."
  []
  (process/shell "ros install fukamachi/qlot"))

(defn install-lem
  "Manually installs lem since using roswell to do so is no longer 
  supported."
  []
  (let [roswell-dir (str fs/home "/.roswell/local-projects")
        lem-tmp-dir (str roswell-dir "/lem")]
    (process/shell {:dir roswell-dir} "git clone https://github.com/lem-project/lem.git")
    (process/shell {:dir lem-tmp-dir} "make ncurses")))

(defn install-cl-lsp-and-dependencies
  "Installs all dependencies needed by cl-lsp before installing the 
  language server itself."
  []
  ;; NOTE: The async-process dep may need to be installed manually.
  (process/shell "ros install lem-project/async-process lem-project/micros cxxxr/cl-lsp"))

(defn install-cl-lsp
  "Runs through all of the necessary steps to get cl-lsp up and
  running. See https://aliquote.org/post/cl-lsp/ for more info."
  []
  (install-qlot)
  (install-lem)
  (install-cl-lsp-and-dependencies))

(defn -main
  []
  (println "Installing language server for Racket...")
  (install-racket-langserver)

  (println "Installing language server for Chicken Scheme...")
  (install-chicken-language-server)

  (println "Installing language server for Guile...")
  (install-guile-lsp-server)

  (println "Installing language server for Common Lisp...")
  (install-cl-lsp))
