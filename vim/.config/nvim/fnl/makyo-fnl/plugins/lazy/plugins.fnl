(import-macros {: module} :nfnl.macros.aniseed)

(module :makyo-fnl.plugins.lazy.plugins)

(local {: general-purpose-plugins} (require :makyo-fnl.plugins.lazy.plugins.general))
(local {: coding-plugins} (require :makyo-fnl.plugins.lazy.plugins.coding))
(local {: language-plugins} (require :makyo-fnl.plugins.lazy.plugins.language))
(local {: text-manipulation-plugins} (require :makyo-fnl.plugins.lazy.plugins.text))
(local {: application-plugins} (require :makyo-fnl.plugins.lazy.plugins.application))
(local {: version-control-plugins} (require :makyo-fnl.plugins.lazy.plugins.version-control))
(local {: search-plugins} (require :makyo-fnl.plugins.lazy.plugins.search))
(local {: ui-plugins} (require :makyo-fnl.plugins.lazy.plugins.ui))
(local {: themes} (require :makyo-fnl.plugins.lazy.plugins.themes))

[
 general-purpose-plugins
 coding-plugins
 language-plugins
 text-manipulation-plugins
 application-plugins
 version-control-plugins
 search-plugins
 ui-plugins
 themes
 ]
