(module makyo-fnl.plugins.lazy
  {require {{: general-purpose-plugins} makyo-fnl.plugins.lazy.plugins.general
            {: coding-plugins} makyo-fnl.plugins.lazy.plugins.coding
            {: language-plugins} makyo-fnl.plugins.lazy.plugins.language
            {: text-manipulation-plugins} makyo-fnl.plugins.lazy.plugins.text
            {: application-plugins} makyo-fnl.plugins.lazy.plugins.application
            {: version-control-plugins} makyo-fnl.plugins.lazy.plugins.version-control
            {: search-plugins} makyo-fnl.plugins.lazy.plugins.search
            {: ui-plugins} makyo-fnl.plugins.lazy.plugins.ui
            {: themes} makyo-fnl.plugins.lazy.plugins.themes}
   autoload {: lazy}})

(defn init []
  (let [plugins [
                 general-purpose-plugins
                 coding-plugins
                 language-plugins
                 text-manipulation-plugins
                 application-plugins
                 version-control-plugins
                 search-plugins
                 ui-plugins
                 themes
                ]]
    (lazy.setup plugins)))
