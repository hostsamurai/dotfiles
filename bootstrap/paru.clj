#!/usr/bin/env bb

(ns paru
  (:require
   [babashka.fs :as fs]
   [babashka.process :as process]))

;; Bootstrap paru for installing dependencies that pacman, through 
;; mise, won't be able to handle.

(def PARU-DIR (str (fs/xdg-cache-home) "/paru-build"))

(defn clone-paru
  "Clones `paru` into a temporary directory to install it."
  []
  (if (not (fs/exists? PARU-DIR))
    (process/shell {:dir (fs/xdg-cache-home)}
                   "git clone https://aur.archlinux.org/paru.git paru-build")
    (process/shell {:dir PARU-DIR} "git pull")))

(defn make-paru
  "Runs makepkg"
  []
  (process/shell {:dir PARU-DIR} "makepkg --verifysource")
  (process/shell {:dir PARU-DIR} "makepkg -sic"))

(defn verify-paru
  "Runs the paru command to print out its version"
  []
  (process/process {:out :inherit :err :inherit} "paru --version"))

(defn -main [& _args]
  (clone-paru)
  (make-paru)
  (verify-paru))
