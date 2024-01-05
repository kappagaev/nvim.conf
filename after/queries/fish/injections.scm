; extends

(command
  name: (word) @_name (#eq? @_name "curl")
  argument: (word) @_tt (#eq? @_tt "--data")
  argument: (single_quote_string) @injection.content (#set! injection.language "json")
)

