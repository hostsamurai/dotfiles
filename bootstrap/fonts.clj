#!/usr/bin/env bb

(ns fonts
  (:require
   [babashka.fs :as fs]
   [babashka.process :as process]
   [babashka.cli :as cli]))

;; Sets up all of the custom fonts in the system, either from the AUR 
;; or from individual repositories. In other words, this handles the 
;; fonts that are not in the official channels for Arch or OSX.

(def spec
  {:ioskeley-version {:alias "v"
                      :desc "Version of Ioskeley Mono to install."
                      :default "v2.1.0"
                      :validate {:pred #(re-matches #"v\d+\.\d+\.\d+" %1)
                                 :ex-msg (fn [m]
                                           (str "Not a valid version: " m))}}})

(def IOSKELEY_FONT_VERSION (cli/parse-opts *command-line-args* {:spec {:ioskeley-version {:default "v2.1.0"}}}))
(def FONTS_DIR (fs/xdg-data-home "fonts"))
(def IOSKELEY_GH_URL (str "https://github.com/ahatem/IoskeleyMono/releases/download/" IOSKELEY_FONT_VERSION "/IoskeleyMono-NerdFont.zip"))
(def IOSKELEY_TERM_GH_URL (str "https://github.com/ahatem/IoskeleyMono/releases/download/" IOSKELEY_FONT_VERSION "/IoskeleyMono-Term-NerdFont.zip"))

(defn update-fonts-cache []
  (process/shell "fc-cache -fv"))

;; Download Ioskeley Mono from its original GitHub repo and set it up 
;; manually. 
(defn download-ioskeley-fonts []
  (process/shell {:dir FONTS_DIR} (str "wget " IOSKELEY_GH_URL))
  (process/shell {:dir FONTS_DIR} (str "wget " IOSKELEY_TERM_GH_URL)))

(defn install-ioskeley-fonts
  "Unzips the released archive and updates the font cache."
  [?version]
  (let [literal-font-archives-glob "IoskeleyMono*.zip"
        archives-glob (fs/glob FONTS_DIR literal-font-archives-glob)]
    (println "Updating Ioskeley to version " (or IOSKELEY_FONT_VERSION ?version) "...")
    ;; Extract the fonts.
    (process/shell {:dir FONTS_DIR} "unzip IoskeleyMono-*.zip")
    ;; Update the font cache.
    (update-fonts-cache)
    ;; Remove the zip files they came in.
    (doseq [archive archives-glob]
      (fs/delete archive))))

;; Do the same thing for Aporetic, except that it is found in the 
;; AUR. It is also available to install using guix, but we're not 
;; going there right now.
(defn install-aporetic []
  (process/shell "paru -S ttf-aporetic"))

;; The Nerd Font variant is also available, but has to be installed 
;; by hand.
(defn install-aporetic-nerd-font []
  (let [cloned-font-dir (fs/xdg-cache-home "Aporetic-Nerd-Font")]
    ;; Clone or update the repo.
    (if (not (fs/exists? cloned-font-dir))
      (process/shell {:dir (fs/xdg-cache-home)} "git clone --depth 1 https://github.com/Echinoidea/Aporetic-Nerd-Font.git")
      (process/shell {:dir cloned-font-dir :continue true} "git pull"))
    ;; We can't shell out and perform a mv * apparently. So, we must 
    ;; loop through this sequence.
    (doseq [font-file (fs/glob cloned-font-dir "*.ttf")]
      (fs/move font-file FONTS_DIR {:replace-existing true}))
    ;; Lastly, update the font cache.
    (update-fonts-cache)))

(defn install-aporetic-fonts []
  (install-aporetic)
  (install-aporetic-nerd-font))

(defn install-all-custom-fonts
  []
  (install-ioskeley-fonts IOSKELEY_FONT_VERSION)
  (install-aporetic)
  (install-aporetic-nerd-font))

(defn -main []
  (install-all-custom-fonts))
