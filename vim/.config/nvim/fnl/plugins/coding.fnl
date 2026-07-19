(import-macros {: module} :nfnl.macros.aniseed)

(module :plugins.coding)

(local {: spec} (require :utils.spec))
(local {: wk-spec} (require :utils.wk-spec))

[
 ;; LazyVim overides 
 
 (spec "saghen/blink.compat" {:version "2.*" :lazy true})
 (spec "saghen/blink.cmp" 
       {
        :dependencies [
                       "hrsh7th/vim-vsnip"
                       "https://codeberg.org/FelipeLema/bink-cmp-vsnip.git"
                       "jdrupal-dev/css-vars.nvim"
                       (spec "mikavilpas/blink-ripgrep.nvim" {:version "*"})
                       "MahanRahmati/blink-nerdfont.nvim"
                       "moyiz/blink-emoji.nvim"
                       "archie-judd/blink-cmp-words"
                       "Kaiser-Yang/blink-cmp-git"
                       "barrettruth/blink-cmp-ghostty"
                       "bydlw98/blink-cmp-env"
                       "disrupted/blink-cmp-conventional-commits"
                       "tamago324/cmp-zsh"
                       ]
        :opts {
               :snippets {:preset "vsnip"}
               :sources {
                         :default [
                                   "buffer"
                                   "ripgrep"
                                   "nerdfont"
                                   "emoji"
                                   "lsp"
                                   "path"
                                   "lazydev"
                                   "git"
                                   "ghostty"
                                   "env"
                                   "conventional_commits"
                                   ]
                         :compat ["zsh"]
                         :providers {
                                     :css_vars {:name "css-vars" :module "css-vars.blink"}
                                     :ripgrep {:name "ripgrep" :module "blink-ripgrep"}
                                     :nerdfont {
                                                :name "Nerd Fonts" 
                                                :module "blink-nerdfont" 
                                                :opts {:insert true :trigger ":-"}
                                                }
                                     :emoji {
                                             :name "Emoji"
                                             :module "blink-emoji"
                                             :score_offset 15 
                                             :opts {:insert true :trigger ":"}
                                             }
                                     :dictionary {
                                                  :name "blink-cmp-words"
                                                  :module "blink-cmp-words.dictionary"
                                                  :opts {
                                                         ;;the number of characters to trigger completion
                                                         :dictionary_search_threshold 3
                                                         :score_offset 0
                                                         :definition_pointers ["!" "&" "^"]
                                                         }
                                                  }
                                     :git {:name "Git" :module "blink-cmp-git" :opts {:commit {:enable false}}}
                                     :ghostty {:name "Ghostty" :module "blink-cmp-ghostty"}
                                     :env {
                                           :name "Env"
                                           :module "blink-cmp-env"
                                           :opts {
                                                  :item_kind #(let [types (require :blink.cmp.types)]
                                                                types.CompletionItemKind.Variable)
                                                  :show_braces false 
                                                  :show_documentation_window true
                                                  }
                                           }
                                     :conventional_commits {
                                                            :name "Conventional Commits"
                                                            :module "blink-cmp-conventional-commits"
                                                            :enabled #(= vim.bo.filetype "gitcommit")
                                                            }
                                     :zsh {:name "zsh" :module "blink.compat.source"}
                                     }
                         }
               }
        })

 ;; Disable mini.pairs
 (spec "nvim-mini/mini.pairs" {:enabled false})
 
 (spec "nvim-mini/mini.surround" {:opts {:search_method "cover_or_nearest"}})

 ;;; Additional plugins
 ;;; ----------------------------------------------
 
 ;; Use this auto pairs plugin instead of mini.pairs
 (spec "windwp/nvim-autopairs" {
                                :event "InsertEnter" 
                                :opts {:enable_check_bracket_line false}
                                :config (fn [_ opts]
                                          ;; Auto-pair <> for generics
                                          (let [npairs (require :nvim-autopairs)
                                                Rule (require :nvim-autopairs.rule)
                                                cond (require :nvim-autopairs.conds)]
                                            (npairs.setup opts)
                                            (-> (npairs.add_rule (Rule "<" ">"))
                                                (: :with_pair (cond.before_regex "%a+:?:?$" 3))
                                                (: :with_move (fn [opts]
                                                                (= opts.char ">"))))))
                                :keys [(wk-spec "<leader>Fa" #(let [npairs (require :nvim-autopairs)]
                                                                (npairs.toggle)) {:desc "Toggle Auto Pairs"})]
                                })

 ;; Devcontainer support
 (spec "https://codeberg.org/esensar/nvim-dev-container" 
       {
        :dependencies "nvim-treesitter/nvim-treesitter"
        :config #(let [devcontainer (require :devcontainer)]
                   (devcontainer.setup {:generate_commands true}))
        :keys [
               (wk-spec "<leader>cDa" "<cmd>DevcontainerAttach<cr>" {:desc "Attach"})
               (wk-spec "<leader>cDr" "<cmd>DevcontainerRemove<cr>" {:desc "Remove"})
               (wk-spec "<leader>cDs" "<cmd>DevcontainerStart<cr>" {:desc "Start"})
               (wk-spec "<leader>cDS" "<cmd>DevcontainerStop<cr>" {:desc "Stop"})
               ]
        })

 ;; LISP dialects support 
 "Olical/nfnl"
 (spec "hiphish/rainbow-delimiters.nvim" 
       {:config #(let [rainbow-delimiters (require :rainbow-delimiters.setup)]
                   (rainbow-delimiters.setup {:strategy {
                                                         "''" "rainbow-delimiters.strategy.global"
                                                         ;; Use local strategy for LISP dialects
                                                         :lisp "rainbow-delimiters.strategy.local"
                                                         :clojure "rainbow-delimiters.strategy.local"
                                                         :commonlisp "rainbow-delimiters.strategy.local"
                                                         :fennel "rainbow-delimiters.strategy.local"
                                                         :janet "rainbow-delimiters.strategy.local"
                                                         :racket "rainbow-delimiters.strategy.local"
                                                         }
                                              :query {"''" "rainbow-delimiters"}
                                              :highlight [
                                                          "RainbowDelimiterRed"
                                                          "RainbowDelimiterYellow"
                                                          "RainbowDelimiterBlue"
                                                          "RainbowDelimiterOrange"
                                                          "RainbowDelimiterGreen"
                                                          "RainbowDelimiterViolet"
                                                          "RainbowDelimiterCyan"
                                                          ]
                                              }))})

 ;; Terminal support
 (spec "akinsho/toggleterm.nvim" 
       {
        :version "*" 
        :config #(let [toggleterm (require :toggleterm)]
                   (toggleterm.setup {
                                      :shade_terminals false
                                      :direction "horizontal"
                                      :size (fn [term]
                                              (if (= term.direction "horizontal")
                                                  40 
                                                  (= term.direction "vertical")
                                                  (* vim.o.columns 0.4)
                                                  20))
                                      }))
        :keys [
               (wk-spec "<leader>Tb" "<cmd>ToggleTerm<cr>" {:desc "Bottom-Split Terminal"})
               (wk-spec "<leader>Tc" "<cmd>ToggleTerm direction=tab<cr>" {:desc "Open Terminal in New Tab"})
               (wk-spec "<leader>Tt" "<cmd>ToggleTermToggleAll<cr>" {:desc "Show/Hide Terminal(s)"})
               (wk-spec "<leader>Tv" "<cmd>ToggleTerm direction=vertical<cr>" {:desc "Vertical Terminal"})
               ]
        })
 ]
