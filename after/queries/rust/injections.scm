; extends

(macro_invocation
  macro: (scoped_identifier
    path: (identifier) 
    name: (identifier) )
  ((token_tree
      (string_literal) @injection.content (#set! injection.language "sql")
     ))
)
