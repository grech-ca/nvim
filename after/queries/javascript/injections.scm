; extends

; GraphQL tagged template literals: gql`...`
(call_expression
  function: (identifier) @_fn (#eq? @_fn "gql")
  arguments: (template_string
    (string_fragment) @injection.content
    (#set! injection.language "graphql")))
