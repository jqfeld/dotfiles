;extends

((prefixed_string_literal
   prefix: (identifier) @_prefix) @injection.content
 (#eq? @_prefix "md")
 (#set! injection.language "markdown")
 (#set! injection.include-children)
 (#offset! @injection.content 0 2 0 -1))


((prefixed_string_literal
   prefix: (identifier) @_prefix) @injection.content
 (#eq? @_prefix "html")
 (#set! injection.language "html")
 (#set! injection.include-children)
 (#offset! @injection.content 0 4 0 -1))
