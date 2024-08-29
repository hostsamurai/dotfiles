;;; Octo mappings

(module makyo-fnl.plugins.octo
  {require {a aniseed.core}})

(def issue-mappings
  {
   "close_issue"       {:lhs "<leader>oiic" :desc "close issue"}
   "reopen_issue"      {:lhs "<leader>oiio" :desc "reopen issue"}
   "list_issues"       {:lhs "<leader>oiil" :desc "list open issues on same repo"}
   "reload"            {:lhs "<C-r>"        :desc "reload issue"}
   "open_in_browser"   {:lhs "<C-b>"        :desc "open issue in browser"}
   "copy_url"          {:lhs "<C-y>"        :desc "copy url to system clipboard"}
   "add_assignee"      {:lhs "<leader>oiaa" :desc "add assignee"}
   "remove_assignee"   {:lhs "<leader>oiad" :desc "remove assignee"}
   "create_label"      {:lhs "<leader>oilc" :desc "create label"}
   "add_label"         {:lhs "<leader>oila" :desc "add label"}
   "remove_label"      {:lhs "<leader>oild" :desc "remove label"}
   "goto_issue"        {:lhs "<leader>oigi" :desc "navigate to a local repo issue"}
   "add_comment"       {:lhs "<leader>oica" :desc "add comment"}
   "delete_comment"    {:lhs "<leader>oicd" :desc "delete comment"}
   })

(def pull-request-mappings
  {
   "checkout_pr"         {:lhs "<leader>gopc"  :desc "checkout PR"}
   "merge_pr"            {:lhs "<leader>gopm"  :desc "merge commit PR"}
   "squash_and_merge_pr" {:lhs "<leader>gops"  :desc "squash and merge PR"}
   "rebase_and_merge_pr" {:lhs "<leader>gopr"  :desc "rebase and merge PR"}
   "list_commits"        {:lhs "<leader>gopl"  :desc "list PR commits"}
   "list_changed_files"  {:lhs "<leader>gopL"  :desc "list PR changed files"}
   "show_pr_diff"        {:lhs "<leader>gopd"  :desc "show PR diff"}
   "add_reviewer"        {:lhs "<leader>gopA"  :desc "add reviewer"}
   "remove_reviewer"     {:lhs "<leader>gopD"  :desc "remove reviewer request"}
   "close_issue"         {:lhs "<leader>gopiC" :desc "close PR"}
   "reopen_issue"        {:lhs "<leader>gopiR" :desc "reopen PR"}
   "list_issues"         {:lhs "<leader>gopiI" :desc "list open issues on same repo"}
   "reload"              {:lhs "<C-r>"         :desc "reload PR"}
   "open_in_browser"     {:lhs "<C-b>"         :desc "open PR in browser"}
   "copy_url"            {:lhs "<C-y>"         :desc "copy url to system clipboard"}
   "add_assignee"        {:lhs "<leader>gopaa" :desc "add assignee"}
   "remove_assignee"     {:lhs "<leader>gopad" :desc "remove assignee"}
   "create_label"        {:lhs "<leader>goplc" :desc "create label"}
   "add_label"           {:lhs "<leader>gopla" :desc "add label"}
   "remove_label"        {:lhs "<leader>gopld" :desc "remove label"}
   "goto_issue"          {:lhs "<leader>gopig" :desc "navigate to a local repo issue"}
   "add_comment"         {:lhs "<leader>gopca" :desc "add comment"}
   "delete_comment"      {:lhs "<leader>gopcd" :desc "delete comment"}

   })

(def review-thread-mappings
  {
   "goto_issue"         {:lhs "<leader>gorg" :desc "navigate to a local repo issue"}
   "add_comment"        {:lhs "<leader>gorc" :desc "add comment"}
   "add_suggestion"     {:lhs "<leader>gors" :desc "add suggestion"}
   "delete_comment"     {:lhs "<leader>gorD" :desc "delete comment"}
   "close_review_tab"   {:lhs "<C-c>"        :desc "close review tab"}
   })

(def submit-win-mappings
  {
   "approve_review"   {:lhs "<C-a>" :desc "approve review"}
   "comment_review"   {:lhs "<C-m>" :desc "comment review"}
   "request_changes"  {:lhs "<C-r>" :desc "request changes review"}
   "close_review_tab" {:lhs "<C-c>" :desc "close review tab"}
   })

(def review-diff-mappings
  {
   "submit_review"         {:lhs  "<leader>goRs"    :desc "submit review"}
   "discard_review"        {:lhs  "<leader>goRd"    :desc "discard review"}
   "add_review_comment"    {:lhs  "<leader>goRa"    :desc "add a new review comment"}
   "add_review_suggestion" {:lhs  "<leader>goRs"    :desc "add a new review suggestion"}
   "focus_files"           {:lhs  "<leader>goRf"    :desc "move focus to changed file panel"}
   "toggle_files"          {:lhs  "<leader>goRt"    :desc "hide/show changed files panel"}
   "close_review_tab"      {:lhs  "<C-c>"           :desc "close review tab"}
   "toggle_viewed"         {:lhs  "<leader><space>" :desc "toggle viewer viewed state"}
    })

(def file-panel-mappings
  {
   "submit_review"      {:lhs  "<leader>gofs"    :desc "submit review"}
   "discard_review"     {:lhs  "<leader>gofd"    :desc "discard review"}
   "select_entry"       {:lhs  "<cr>"            :desc "show selected changed file diffs"}
   "focus_files"        {:lhs  "<leader>goff"    :desc "move focus to changed file panel"}
   "toggle_files"       {:lhs  "<leader>goft"    :desc "hide/show changed files panel"}
   "toggle_viewed"      {:lhs  "<leader><space>" :desc "toggle viewer viewed state"}
   })

(def reaction-mappings
   {
   "react_hooray"        {:lhs "<leader>gorp"  :desc "add/remove 🎉 reaction"}
   "react_heart"         {:lhs "<leader>gorh"  :desc "add/remove ❤️ reaction"}
   "react_eyes"          {:lhs "<leader>gore"  :desc "add/remove 👀 reaction"}
   "react_thumbs_up"     {:lhs "<leader>gor+"  :desc "add/remove 👍 reaction"}
   "react_thumbs_down"   {:lhs "<leader>gor-"  :desc "add/remove 👎 reaction"}
   "react_rocket"        {:lhs "<leader>gorr"  :desc "add/remove 🚀 reaction"}
   "react_laugh"         {:lhs "<leader>gorl"  :desc "add/remove 😄 reaction"}
   "react_confused"      {:lhs "<leader>gorc"  :desc "add/remove 😕 reaction"}
   "review_start"        {:lhs "<leader>govs"  :desc "start a review for the current PR"}
   "review_resume"       {:lhs "<leader>govr"  :desc "resume a pending review for the current PR"}
    })
