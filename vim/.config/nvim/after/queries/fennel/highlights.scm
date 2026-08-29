;; extends

(table_pair
  key: [
    (string) @string_key (#set! priority 200)
    (symbol) @symbol_key (#set! priority 200)
  ]
  value: (_) @value)
