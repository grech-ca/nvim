;; @tag.outer
(element) @tag.outer

;; @tag.inner
(element
  (start_tag)
  .
  (_) @tag.inner
  .
  (end_tag))

((element
  (start_tag)
  .
  (_) @_start
  (_) @_end
  .
  (end_tag))
  (#make-range! "tag.inner" @_start @_end))
