#lang racket/base

(require racket/gui/base
         racket/class
         quickscript
         syntax/parse/define
         (for-syntax racket/base
                     quickscript))

#;(define lg (make-logger))

(define-syntax-parse-rule (define-hook* id (~seq keyword:keyword kwid) ...)
  ;; INFO: add a quote `'` before the next paren and Run to debug
  (define-hook id
      (λ ({~@ keyword kwid} ...)
        (define str
          #;(symbol->string 'id)
          (string-append (format "hook: ~a\n" 'id)
                         (format "[~a ~a]\n" 'keyword kwid)
                         ...))
        #;(writeln str)
        (log-message (current-logger) 'debug 'qs-test str))))

;; TODO: Automated tests!
(define-hook* on-startup)
(define-hook* on-close)
(define-hook* after-create-new-drracket-frame #:show? show?)
(define-hook* after-load-file #:hook-editor ed #:file f)
(define-hook* on-save-file #:hook-editor ed #:save-filename sf #:file f)
(define-hook* after-save-file #:hook-editor ed  #:file f)
(define-hook* on-tab-close #:tab tab)
(define-hook* on-tab-change #:tab-from ft #:tab-to tt)
(define-hook* after-create-new-tab #:tab tab) ; TEST TODO: create a new tab

;; TODO: An error should be shown for this one:
(define-hook* undefined #:show? show?)
