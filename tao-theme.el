;;; tao-theme.el --- A golden mean grayscale color theme for Emacs.

;; Copyright (C) 2014 Peter Kosov 11111000000@email.com
;; Author: Peter <11111000000@email.com>
;;
;; Original faces taken from Zenburn theme port (c) by Bozhidar Batsov
;;
;; Color palette generated automatically by golden-ratio algorithm v1.0
;;
;; URL: http://github.com/11111000000/tao-theme-emacs
;; Version: 1.0

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;;; Code:

(deftheme tao "The Tao color theme")

;;; Color Palette

(defvar tao-colors-alist '()
  "List of Tao colors.
Each element has the form (NAME . HEX).")

(defconst phi (/ (+ 1 (sqrt 5)) 2))

(defun golden-grayscale ()
  (let ((zeta nil))
    (dotimes (i 7)
      (setq delta (/ #xFF (expt phi (+ 2 i))))
      (setq gamma (- #xFF delta))
      (push (format "#%02X%02X%02X" delta delta delta) zeta)
      (setq zeta (append zeta (list (format "#%02X%02X%02X" gamma gamma gamma))))
      ) zeta ))

(defun golden-grayscale-alist ()  
  (let ((index 0))
    (mapcar (lambda (x)
              (setq index (+ 1 index))
              (cons (concat "color-" (format "%d" index)) x))
            (golden-grayscale))))


(setq tao-light-list '(9 10 11 13 10 9 5 4 2 3 5 4 6 4))

(defun golden-grayscale-light-alist ()
  (let ((index 0)
        (grayscale (golden-grayscale)))
    (mapcar (lambda (x)
              (setq index (+ 1 index))
              (cons (concat "color-" (format "%d" index)) (nth x grayscale)))
            tao-light-list)))

(setq tao-colors-alist (golden-grayscale-alist))

;;(setq tao-colors-alist (golden-grayscale-light-alist))
      
;;(("color-1" . "#050505") ("color-2" . "#080808") ("color-3" . "#0E0E0E") ("color-4" . "#161616") ("color-5" . "#252525") ("color-6" . "#3C3C3C") ("color-7" . "#616161") ("color-8" . "#9D9D9D") ("color-9" . "#C2C2C2") ("color-10" . "#D9D9D9") ("color-11" . "#E8E8E8") ("color-12" . "#F0F0F0") ...)
;; (defun invert(rgb-hex)
;;   (setq first-symbol (substring rgb-hex 0 1))
;;   (if (equalp first-symbol "#") (setq rgb-hex (substring rgb-hex 1)))
;;   (setq X (- #xFFFFFF (string-to-number rgb-hex 16)))
;;   (if (equalp first-symbol "#") (format "#%X" X) (format "%X" X))
;;   )

;; (setq tao-colors-alist (mapcar (lambda (x) (cons (car x) (invert (cdr x)))) tao-colors-alist))

(defmacro tao-with-color-variables (&rest body)
  "`let' bind all colors defined in `tao-colors-alist' around BODY.
Also bind `class' to ((class color) (min-colors 89))."
  (declare (indent 0))
  `(let ((class '((class color) (min-colors 89)))
         ,@(mapcar (lambda (cons)
                     (list (intern (car cons)) (cdr cons)))
                   tao-colors-alist))
     ,@body))

;;; Theme Faces
(tao-with-color-variables
  (custom-theme-set-faces
   'tao
;;;; Built-in
;;;;; basic coloring
   '(button ((t (:underline t))))
   `(link ((t (:foreground ,color-13 :underline t :weight bold))))
   `(link-visited ((t (:foreground ,color-11 :underline t :weight normal))))
   `(default ((t (:foreground ,color-9 :background ,color-4))))
   `(hl-paren-face ((t (:weight bold))))
   `(cursor ((t (:foreground ,color-13 :background ,color-14))))
   `(escape-glyph ((t (:foreground ,color-13 :bold t))))
   `(fringe ((t (:foreground ,color-2 :background ,color-4))))
   ;; `(header-line ((t (:foreground ,color-13
   ;;                                :background ,color-3
   ;;                                :box (:line-width -1 :style released-button)))))
   `(header-line ((t (:inherit mode-line))))
   `(highlight ((t (:background ,color-4))))
   `(success ((t (:foreground ,color-9 :weight bold))))
   `(warning ((t (:foreground ,color-11 :weight bold))))
;;;;; compilation
   `(compilation-column-face ((t (:foreground ,color-13))))
   `(compilation-enter-directory-face ((t (:foreground ,color-9))))
   `(compilation-error-face ((t (:foreground ,color-9 :weight bold :underline t))))
   `(compilation-face ((t (:foreground ,color-13))))
   `(compilation-info-face ((t (:foreground ,color-11))))
   `(compilation-info ((t (:foreground ,color-13 :underline t))))
   `(compilation-leave-directory-face ((t (:foreground ,color-9))))
   `(compilation-line-face ((t (:foreground ,color-13))))
   `(compilation-line-number ((t (:foreground ,color-13))))
   `(compilation-message-face ((t (:foreground ,color-11))))
   `(compilation-warning-face ((t (:foreground ,color-11 :weight bold :underline t))))
   `(compilation-mode-line-exit ((t (:foreground ,color-11 :weight bold))))
   `(compilation-mode-line-fail ((t (:foreground ,color-10 :weight bold))))
   `(compilation-mode-line-run ((t (:foreground ,color-13 :weight bold))))
;;;;; grep
   `(grep-context-face ((t (:foreground ,color-13))))
   `(grep-error-face ((t (:foreground ,color-9 :weight bold :underline t))))
   `(grep-hit-face ((t (:foreground ,color-11))))
   `(grep-match-face ((t (:foreground ,color-11 :weight bold))))
   `(match ((t (:background ,color-3 :foreground ,color-11 :weight bold))))
;;;;; make
   `(makefile-space ((t (:background ,color-4))))
   
;;;;; isearch
   `(isearch ((t (:foreground ,color-11 :weight bold :background ,color-3))))
   `(isearch-fail ((t (:foreground ,color-13 :background ,color-7))))
   `(lazy-highlight ((t (:foreground ,color-11 :weight bold :background ,color-4))))

   `(menu ((t (:foreground ,color-13 :background ,color-4))))
   `(minibuffer-prompt ((t (:foreground ,color-13 :color ,color-1))))
   `(mode-line
     ((,class (:foreground ,color-10
                           :background ,color-3
                           :height 86
                           :box (:line-width 1 :style released-button)))
      (t :inverse-video t)))
   `(mode-line-inactive
     ((t (:foreground ,color-8
                      :background ,color-6
                      :height 86
                      :box (:line-width -1 :style released-button)))))
   `(mode-line-buffer-id ((t (:foreground ,color-13 :weight bold))))
   `(region ((,class (:background ,color-9 :foreground ,color-3))
             (t :inverse-video t)))
   `(secondary-selection ((t (:background ,color-4))))
   `(trailing-whitespace ((t (:background ,color-10))))
   `(vertical-border ((t (:foreground ,color-7 :background ,color-4))))
;;;;; font lock
   `(font-lock-builtin-face ((t (:foreground ,color-13 :weight bold))))
   `(font-lock-comment-face ((t (:foreground ,color-7 :weight bold))))
   `(font-lock-comment-delimiter-face ((t (:foreground ,color-8))))
   `(font-lock-constant-face ((t (:foreground ,color-13))))
   `(font-lock-doc-face ((t (:foreground ,color-7))))
   `(font-lock-function-name-face ((t (:foreground ,color-12))))
   `(font-lock-keyword-face ((t (:foreground ,color-13 :weight bold))))
   `(font-lock-negation-char-face ((t (:foreground ,color-13 :weight bold))))
   `(font-lock-preprocessor-face ((t (:foreground ,color-11))))
   `(font-lock-regexp-grouping-construct ((t (:foreground ,color-13 :weight bold))))
   `(font-lock-regexp-grouping-backslash ((t (:foreground ,color-9 :weight bold))))
   `(font-lock-string-face ((t (:foreground ,color-8 :slant oblique))))
   `(font-lock-type-face ((t (:foreground ,color-10 :underline t))))
   `(font-lock-variable-name-face ((t (:foreground ,color-11))))
   `(font-lock-warning-face ((t (:foreground ,color-11 :weight bold))))

   `(c-annotation-face ((t (:inherit font-lock-constant-face))))
;;;;; newsticker
   `(newsticker-date-face ((t (:foreground ,color-13))))
   `(newsticker-default-face ((t (:foreground ,color-13))))
   `(newsticker-enclosure-face ((t (:foreground ,color-12))))
   `(newsticker-extra-face ((t (:foreground ,color-7 :height 0.8))))
   `(newsticker-feed-face ((t (:foreground ,color-13))))
   `(newsticker-immortal-item-face ((t (:foreground ,color-9))))
   `(newsticker-new-item-face ((t (:foreground ,color-11))))
   `(newsticker-obsolete-item-face ((t (:foreground ,color-10))))
   `(newsticker-old-item-face ((t (:foreground ,color-8))))
   `(newsticker-statistics-face ((t (:foreground ,color-13))))
   `(newsticker-treeview-face ((t (:foreground ,color-13))))
   `(newsticker-treeview-immortal-face ((t (:foreground ,color-9))))
   `(newsticker-treeview-listwindow-face ((t (:foreground ,color-13))))
   `(newsticker-treeview-new-face ((t (:foreground ,color-11 :weight bold))))
   `(newsticker-treeview-obsolete-face ((t (:foreground ,color-10))))
   `(newsticker-treeview-old-face ((t (:foreground ,color-8))))
   `(newsticker-treeview-selection-face ((t (:background ,color-3 :foreground ,color-13))))
;;;; Third-party
;;;;; highlight-symbol
   `(highlight-symbol-face ((t (:background ,color-4) )))
;;;;; ace-jump
   `(ace-jump-face-background
     ((t (:foreground ,color-7 :background ,color-4 :inverse-video nil))))
   `(ace-jump-face-foreground
     ((t (:foreground ,color-11 :background ,color-4 :inverse-video nil))))
;;;;; anzu
   `(anzu-mode-line ((t (:foreground ,color-12 :weight bold))))
;;;;; full-ack
   `(ack-separator ((t (:foreground ,color-13))))
   `(ack-file ((t (:foreground ,color-11))))
   `(ack-line ((t (:foreground ,color-13))))
   `(ack-match ((t (:foreground ,color-11 :background ,color-3 :weight bold))))
;;;;; auctex
   `(font-latex-bold-face ((t (:inherit bold))))
   `(font-latex-warning-face ((t (:foreground nil :inherit font-lock-warning-face))))
   `(font-latex-sectioning-5-face ((t (:foreground ,color-10 :weight bold ))))
   `(font-latex-sedate-face ((t (:foreground ,color-13))))
   `(font-latex-italic-face ((t (:foreground ,color-12 :slant italic))))
   `(font-latex-string-face ((t (:inherit ,font-lock-string-face))))
   `(font-latex-math-face ((t (:foreground ,color-11))))
;;;;; auto-complete
   `(ac-candidate-face ((t (:background ,color-8 :foreground ,color-2))))
   `(ac-selection-face ((t (:background ,color-7 :foreground ,color-13))))
   `(ac-yasnippet-candidate-face ((t (:background ,color-8 :foreground ,color-3))))
   `(ac-yasnippet-selection-face ((t (:background ,color-7 :foreground ,color-12))))
   `(ac-slime-menu-face ((t (:background ,color-8 :foreground ,color-1))))
   `(ac-slime-selection-face ((t (:background ,color-7 :foreground ,color-12))))
   `(ac-gtags-candidate-face ((t (:background ,color-8 :foreground ,color-1))))
   `(ac-gtags-selection-face ((t (:background ,color-7 :foreground ,color-12))))
   `(ac-emmet-candidate-face ((t (:background ,color-8 :foreground ,color-2))))
   `(ac-emmet-selection-face ((t (:background ,color-7 :foreground ,color-12))))
   
   `(popup-tip-face ((t (:background ,color-11 :foreground ,color-2))))
   `(popup-scroll-bar-foreground-face ((t (:background ,color-6))))
   `(popup-scroll-bar-background-face ((t (:background ,color-3))))
   `(popup-isearch-match ((t (:background ,color-4 :foreground ,color-13))))
;;;;; android mode
   `(android-mode-debug-face ((t (:foreground ,color-10))))
   `(android-mode-error-face ((t (:foreground ,color-11 :weight bold))))
   `(android-mode-info-face ((t (:foreground ,color-13))))
   `(android-mode-verbose-face ((t (:foreground ,color-9))))
   `(android-mode-warning-face ((t (:foreground ,color-13))))
;;;;; bm
   `(bm-face ((t (:background ,color-12 :foreground ,color-5))))
   `(bm-fringe-face ((t (:background ,color-4 :foreground ,color-2))))
   `(bm-fringe-persistent-face ((t (:background ,color-4 :foreground ,color-2))))
   `(bm-persistent-face ((t (:background ,color-8 :foreground ,color-5))))
;;;;; clojure-test-mode
   `(clojure-test-failure-face ((t (:foreground ,color-11 :weight bold :underline t))))
   `(clojure-test-error-face ((t (:foreground ,color-10 :weight bold :underline t))))
   `(clojure-test-success-face ((t (:foreground ,color-10 :weight bold :underline t))))
;;;;; coq
   `(coq-solve-tactics-face ((t (:foreground nil :inherit font-lock-constant-face))))
;;;;; ctable
   `(ctbl:face-cell-select ((t (:background ,color-11 :foreground ,color-5))))
   `(ctbl:face-continue-bar ((t (:background ,color-4 :foreground ,color-5))))
   `(ctbl:face-row-select ((t (:background ,color-12 :foreground ,color-5))))
;;;;; diff

   `(diff-added ((,class (:foreground ,color-13 :background nil))
                 (t (:foreground ,color-8 :background nil))))
   `(diff-changed ((t (:foreground ,color-13))))
   `(diff-removed ((,class (:foreground ,color-10 :background nil))
                   (t (:foreground ,color-8 :background nil))))
   `(diff-refine-added ((t :inherit diff-added :weight bold)))
   `(diff-refine-change ((t :inherit diff-changed :weight bold)))
   `(diff-refine-removed ((t :inherit diff-removed :weight bold)))
   `(diff-header ((,class (:background ,color-7))
                  (t (:background ,color-13 :foreground ,color-5))))
   `(diff-file-header
     ((,class (:background ,color-7 :foreground ,color-13 :bold t))
      (t (:background ,color-13 :foreground ,color-5 :bold t))))
;;;;; dired+
   `(diredp-display-msg ((t (:foreground ,color-11))))
   `(diredp-compressed-file-suffix ((t (:foreground ,color-11))))
   `(diredp-date-time ((t (:foreground ,color-10))))
   `(diredp-deletion ((t (:foreground ,color-13))))
   `(diredp-deletion-file-name ((t (:foreground ,color-10))))
   `(diredp-dir-heading ((t (:foreground ,color-13 :background ,color-3 :bold t))))
   `(diredp-dir-priv ((t (:foreground ,color-14 :bold t))))
   `(diredp-exec-priv ((t (:foreground ,color-10))))
   `(diredp-executable-tag ((t (:foreground ,color-10))))
   `(diredp-file-name ((t (:foreground ,color-11))))
   `(diredp-file-suffix ((t (:foreground ,color-11 :bold t))))
   `(diredp-flag-mark ((t (:foreground ,color-13))))
   `(diredp-flag-mark-line ((t (:foreground ,color-11))))
   `(diredp-ignored-file-name ((t (:foreground ,color-6))))
   `(diredp-link-priv ((t (:foreground ,color-13))))
   `(diredp-mode-line-flagged ((t (:foreground ,color-13))))
   `(diredp-mode-line-marked ((t (:foreground ,color-11))))
   `(diredp-no-priv ((t (:foreground ,color-13))))
   `(diredp-number ((t (:foreground ,color-10))))
   `(diredp-other-priv ((t (:foreground ,color-12))))
   `(diredp-rare-priv ((t (:foreground ,color-9))))
   `(diredp-read-priv ((t (:foreground ,color-8))))
   `(diredp-symlink ((t (:foreground ,color-13))))
   `(diredp-write-priv ((t (:foreground ,color-10))))
;;;;; ediff
   `(ediff-current-diff-A ((t (:foreground ,color-13 :background ,color-7))))
   `(ediff-current-diff-Ancestor ((t (:foreground ,color-13 :background ,color-7))))
   `(ediff-current-diff-B ((t (:foreground ,color-13 :background ,color-8))))
   `(ediff-current-diff-C ((t (:foreground ,color-13 :background ,color-6))))
   `(ediff-even-diff-A ((t (:background ,color-6))))
   `(ediff-even-diff-Ancestor ((t (:background ,color-6))))
   `(ediff-even-diff-B ((t (:background ,color-6))))
   `(ediff-even-diff-C ((t (:background ,color-6))))
   `(ediff-fine-diff-A ((t (:foreground ,color-13 :background ,color-9 :weight bold))))
   `(ediff-fine-diff-Ancestor ((t (:foreground ,color-13 :background ,color-9 weight bold))))
   `(ediff-fine-diff-B ((t (:foreground ,color-13 :background ,color-9 :weight bold))))
   `(ediff-fine-diff-C ((t (:foreground ,color-13 :background ,color-8 :weight bold ))))
   `(ediff-odd-diff-A ((t (:background ,color-7))))
   `(ediff-odd-diff-Ancestor ((t (:background ,color-7))))
   `(ediff-odd-diff-B ((t (:background ,color-7))))
   `(ediff-odd-diff-C ((t (:background ,color-7))))
;;;;; ert
   `(ert-test-result-expected ((t (:foreground ,color-13 :background ,color-4))))
   `(ert-test-result-unexpected ((t (:foreground ,color-10 :background ,color-4))))
;;;;; eshell
   `(eshell-prompt ((t (:foreground ,color-13 :weight bold))))
   `(eshell-ls-archive ((t (:foreground ,color-9 :weight bold))))
   `(eshell-ls-backup ((t (:inherit font-lock-comment-face))))
   `(eshell-ls-clutter ((t (:inherit font-lock-comment-face))))
   `(eshell-ls-directory ((t (:foreground ,color-11 :weight bold))))
   `(eshell-ls-executable ((t (:foreground ,color-11 :weight bold))))
   `(eshell-ls-unreadable ((t (:foreground ,color-13))))
   `(eshell-ls-missing ((t (:inherit font-lock-warning-face))))
   `(eshell-ls-product ((t (:inherit font-lock-doc-face))))
   `(eshell-ls-special ((t (:foreground ,color-13 :weight bold))))
   `(eshell-ls-symlink ((t (:foreground ,color-12 :weight bold))))
;;;;; flx
   `(flx-highlight-face ((t (:foreground ,color-11 :weight bold))))
;;;;; flycheck
   `(flycheck-error
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,color-1) :inherit unspecified))
      (t (:foreground ,color-9 :weight bold :underline t))))
   `(flycheck-warning
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,color-4) :inherit unspecified))
      (t (:foreground ,color-13 :weight bold :underline t))))
   `(flycheck-info
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,color-4) :inherit unspecified))
      (t (:foreground ,color-12 :weight bold :underline t))))
   `(flycheck-fringe-error ((t (:foreground ,color-1 :weight bold))))
   `(flycheck-fringe-warning ((t (:foreground ,color-4 :weight bold))))
   `(flycheck-fringe-info ((t (:foreground ,color-4 :weight bold))))
;;;;; flymake
   `(flymake-errline
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,color-10)
                   :inherit unspecified :foreground unspecified :background unspecified))
      (t (:foreground ,color-9 :weight bold :underline t))))
   `(flymake-warnline
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,color-11)
                   :inherit unspecified :foreground unspecified :background unspecified))
      (t (:foreground ,color-11 :weight bold :underline t))))
   `(flymake-infoline
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,color-9)
                   :inherit unspecified :foreground unspecified :background unspecified))
      (t (:foreground ,color-8 :weight bold :underline t))))
;;;;; flyspell
   `(flyspell-duplicate
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,color-11) :inherit unspecified))
      (t (:foreground ,color-11 :weight bold :underline t))))
   `(flyspell-incorrect
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,color-10) :inherit unspecified))
      (t (:foreground ,color-9 :weight bold :underline t))))
;;;;; erc
   `(erc-action-face ((t (:inherit erc-default-face))))
   `(erc-bold-face ((t (:weight bold))))
   `(erc-current-nick-face ((t (:foreground ,color-11 :weight bold))))
   `(erc-dangerous-host-face ((t (:inherit font-lock-warning-face))))
   `(erc-default-face ((t (:foreground ,color-13))))
   `(erc-direct-msg-face ((t (:inherit erc-default))))
   `(erc-error-face ((t (:inherit font-lock-warning-face))))
   `(erc-fool-face ((t (:inherit erc-default))))
   `(erc-highlight-face ((t (:inherit hover-highlight))))
   `(erc-input-face ((t (:foreground ,color-13))))
   `(erc-keyword-face ((t (:foreground ,color-11 :weight bold))))
   `(erc-nick-default-face ((t (:foreground ,color-13 :weight bold))))
   `(erc-my-nick-face ((t (:foreground ,color-10 :weight bold))))
   `(erc-nick-msg-face ((t (:inherit erc-default))))
   `(erc-notice-face ((t (:foreground ,color-9))))
   `(erc-pal-face ((t (:foreground ,color-11 :weight bold))))
   `(erc-prompt-face ((t (:foreground ,color-11 :background ,color-4 :weight bold))))
   `(erc-timestamp-face ((t (:foreground ,color-13))))
   `(erc-underline-face ((t (:underline t))))
;;;;; git-gutter
   `(git-gutter:added ((t (:foreground ,color-9 :weight bold :inverse-video t))))
   `(git-gutter:deleted ((t (:foreground ,color-10 :weight bold :inverse-video t))))
   `(git-gutter:modified ((t (:foreground ,color-10 :weight bold :inverse-video t))))
   `(git-gutter:unchanged ((t (:foreground ,color-13 :weight bold :inverse-video t))))
;;;;; git-gutter-fr
   `(git-gutter-fr:added ((t (:foreground ,color-2 :weight bold))))
   `(git-gutter-fr:deleted ((t (:foreground ,color-2 :weight bold))))
   `(git-gutter-fr:modified ((t (:foreground ,color-2 :weight bold))))
;;;;; gnus
   `(gnus-group-mail-1 ((t (:bold t :inherit gnus-group-mail-1-empty))))
   `(gnus-group-mail-1-empty ((t (:inherit gnus-group-news-1-empty))))
   `(gnus-group-mail-2 ((t (:bold t :inherit gnus-group-mail-2-empty))))
   `(gnus-group-mail-2-empty ((t (:inherit gnus-group-news-2-empty))))
   `(gnus-group-mail-3 ((t (:bold t :inherit gnus-group-mail-3-empty))))
   `(gnus-group-mail-3-empty ((t (:inherit gnus-group-news-3-empty))))
   `(gnus-group-mail-4 ((t (:bold t :inherit gnus-group-mail-4-empty))))
   `(gnus-group-mail-4-empty ((t (:inherit gnus-group-news-4-empty))))
   `(gnus-group-mail-5 ((t (:bold t :inherit gnus-group-mail-5-empty))))
   `(gnus-group-mail-5-empty ((t (:inherit gnus-group-news-5-empty))))
   `(gnus-group-mail-6 ((t (:bold t :inherit gnus-group-mail-6-empty))))
   `(gnus-group-mail-6-empty ((t (:inherit gnus-group-news-6-empty))))
   `(gnus-group-mail-low ((t (:bold t :inherit gnus-group-mail-low-empty))))
   `(gnus-group-mail-low-empty ((t (:inherit gnus-group-news-low-empty))))
   `(gnus-group-news-1 ((t (:bold t :inherit gnus-group-news-1-empty))))
   `(gnus-group-news-2 ((t (:bold t :inherit gnus-group-news-2-empty))))
   `(gnus-group-news-3 ((t (:bold t :inherit gnus-group-news-3-empty))))
   `(gnus-group-news-4 ((t (:bold t :inherit gnus-group-news-4-empty))))
   `(gnus-group-news-5 ((t (:bold t :inherit gnus-group-news-5-empty))))
   `(gnus-group-news-6 ((t (:bold t :inherit gnus-group-news-6-empty))))
   `(gnus-group-news-low ((t (:bold t :inherit gnus-group-news-low-empty))))
   `(gnus-header-content ((t (:inherit message-header-other))))
   `(gnus-header-from ((t (:inherit message-header-from))))
   `(gnus-header-name ((t (:inherit message-header-name))))
   `(gnus-header-newsgroups ((t (:inherit message-header-other))))
   `(gnus-header-subject ((t (:inherit message-header-subject))))
   `(gnus-summary-cancelled ((t (:foreground ,color-11))))
   `(gnus-summary-high-ancient ((t (:foreground ,color-11))))
   `(gnus-summary-high-read ((t (:foreground ,color-9 :weight bold))))
   `(gnus-summary-high-ticked ((t (:foreground ,color-11 :weight bold))))
   `(gnus-summary-high-unread ((t (:foreground ,color-13 :weight bold))))
   `(gnus-summary-low-ancient ((t (:foreground ,color-11))))
   `(gnus-summary-low-read ((t (:foreground ,color-9))))
   `(gnus-summary-low-ticked ((t (:foreground ,color-11 :weight bold))))
   `(gnus-summary-low-unread ((t (:foreground ,color-13))))
   `(gnus-summary-normal-ancient ((t (:foreground ,color-11))))
   `(gnus-summary-normal-read ((t (:foreground ,color-9))))
   `(gnus-summary-normal-ticked ((t (:foreground ,color-11 :weight bold))))
   `(gnus-summary-normal-unread ((t (:foreground ,color-13))))
   `(gnus-summary-selected ((t (:foreground ,color-13 :weight bold))))
   `(gnus-cite-1 ((t (:foreground ,color-11))))
   `(gnus-cite-10 ((t (:foreground ,color-12))))
   `(gnus-cite-11 ((t (:foreground ,color-13))))
   `(gnus-cite-2 ((t (:foreground ,color-10))))
   `(gnus-cite-3 ((t (:foreground ,color-9))))
   `(gnus-cite-4 ((t (:foreground ,color-11))))
   `(gnus-cite-5 ((t (:foreground ,color-10))))
   `(gnus-cite-6 ((t (:foreground ,color-9))))
   `(gnus-cite-7 ((t (:foreground ,color-10))))
   `(gnus-cite-8 ((t (:foreground ,color-9))))
   `(gnus-cite-9 ((t (:foreground ,color-9))))
   `(gnus-group-news-1-empty ((t (:foreground ,color-13))))
   `(gnus-group-news-2-empty ((t (:foreground ,color-12))))
   `(gnus-group-news-3-empty ((t (:foreground ,color-10))))
   `(gnus-group-news-4-empty ((t (:foreground ,color-9))))
   `(gnus-group-news-5-empty ((t (:foreground ,color-8))))
   `(gnus-group-news-6-empty ((t (:foreground ,color-7))))
   `(gnus-group-news-low-empty ((t (:foreground ,color-7))))
   `(gnus-signature ((t (:foreground ,color-13))))
   `(gnus-x ((t (:background ,color-13 :foreground ,color-5))))
;;;;; guide-key
   `(guide-key/highlight-command-face ((t (:foreground ,color-11))))
   `(guide-key/key-face ((t (:foreground ,color-9))))
   `(guide-key/prefix-command-face ((t (:foreground ,color-10))))
;;;;; helm
   `(helm-header
     ((t (:foreground ,color-9
                      :background ,color-4
                      :underline nil
                      :box nil))))
   `(helm-source-header
     ((t (:foreground ,color-13
                      :background ,color-3
                      :underline nil
                      :weight bold
                      :box (:line-width -1 :style released-button)))))
   `(helm-selection ((t (:background ,color-6 :underline nil))))
   `(helm-selection-line ((t (:background ,color-6))))
   `(helm-visible-mark ((t (:foreground ,color-5 :background ,color-11))))
   `(helm-candidate-number ((t (:foreground ,color-13 :background ,color-3))))
   `(helm-separator ((t (:foreground ,color-10 :background ,color-4))))
   `(helm-time-zone-current ((t (:foreground ,color-11 :background ,color-4))))
   `(helm-time-zone-home ((t (:foreground ,color-10 :background ,color-4))))
   `(helm-bookmark-addressbook ((t (:foreground ,color-11 :background ,color-4))))
   `(helm-bookmark-directory ((t (:foreground nil :background nil :inherit helm-ff-directory))))
   `(helm-bookmark-file ((t (:foreground nil :background nil :inherit helm-ff-file))))
   `(helm-bookmark-gnus ((t (:foreground ,color-10 :background ,color-4))))
   `(helm-bookmark-info ((t (:foreground ,color-11 :background ,color-4))))
   `(helm-bookmark-man ((t (:foreground ,color-13 :background ,color-4))))
   `(helm-bookmark-w3m ((t (:foreground ,color-10 :background ,color-4))))
   `(helm-buffer-not-saved ((t (:foreground ,color-10 :background ,color-4))))
   `(helm-buffer-process ((t (:foreground ,color-12 :background ,color-4))))
   `(helm-buffer-saved-out ((t (:foreground ,color-13 :background ,color-4))))
   `(helm-buffer-size ((t (:foreground ,color-7 :background ,color-4))))
   `(helm-ff-directory ((t (:foreground ,color-12 :background ,color-4 :weight bold))))
   `(helm-ff-file ((t (:foreground ,color-13 :background ,color-4 :weight normal))))
   `(helm-ff-executable ((t (:foreground ,color-11 :background ,color-4 :weight normal))))
   `(helm-ff-invalid-symlink ((t (:foreground ,color-10 :background ,color-4 :weight bold))))
   `(helm-ff-symlink ((t (:foreground ,color-13 :background ,color-4 :weight bold))))
   `(helm-ff-prefix ((t (:foreground ,color-5 :background ,color-13 :weight normal))))
   `(helm-grep-cmd-line ((t (:foreground ,color-12 :background ,color-4))))
   `(helm-grep-file ((t (:foreground ,color-13 :background ,color-4))))
   `(helm-grep-finish ((t (:foreground ,color-11 :background ,color-4))))
   `(helm-grep-lineno ((t (:foreground ,color-7 :background ,color-4))))
   `(helm-grep-match ((t (:foreground nil :background nil :inherit helm-match))))
   `(helm-grep-running ((t (:foreground ,color-10 :background ,color-4))))
   `(helm-moccur-buffer ((t (:foreground ,color-12 :background ,color-4))))
   `(helm-mu-contacts-address-face ((t (:foreground ,color-7 :background ,color-4))))
   `(helm-mu-contacts-name-face ((t (:foreground ,color-13 :background ,color-4))))
;;;;; hl-line-mode
   `(hl-line-face ((,class (:background ,color-3))
                   (t :weight bold)))
   `(hl-line ((,class (:background ,color-3)) ; old emacsen
              (t :weight bold)))
;;;;; hl-sexp
   `(hl-sexp-face ((,class (:background ,color-6))
                   (t :weight bold)))
;;;;; ido-mode
   `(ido-first-match ((t (:foreground ,color-13 :weight bold))))
   `(ido-only-match ((t (:foreground ,color-11 :weight bold))))
   `(ido-subdir ((t (:foreground ,color-13))))
   `(ido-indicator ((t (:foreground ,color-13 :background ,color-7))))
;;;;; iedit-mode
   `(iedit-occurrence ((t (:background ,color-7 :weight bold))))
;;;;; js2-mode

   `(js2-warning ((t (:underline ,color-3))))
   `(js2-error ((t (:foreground ,color-10 :weight bold))))
   `(js2-jsdoc-tag ((t (:foreground ,color-8))))
   `(js2-jsdoc-type ((t (:foreground ,color-11))))
   `(js2-jsdoc-value ((t (:foreground ,color-12))))
   `(js2-jsdoc-html-tag-name ((t (:foreground ,color-11))))
   `(js2-jsdoc-html-tag-delimiter ((t (:foreground ,color-12))))
   `(js2-function-param ((t (:foreground, color-12))))
   `(js2-external-variable ((t (:foreground ,color-11))))
   
;;;;; jabber-mode
   `(jabber-roster-user-away ((t (:foreground ,color-11))))
   `(jabber-roster-user-online ((t (:foreground ,color-10))))
   `(jabber-roster-user-dnd ((t (:foreground ,color-11))))
   `(jabber-rare-time-face ((t (:foreground ,color-10))))
   `(jabber-chat-prompt-local ((t (:foreground ,color-10))))
   `(jabber-chat-prompt-foreign ((t (:foreground ,color-11))))
   `(jabber-activity-face((t (:foreground ,color-11))))
   `(jabber-activity-personal-face ((t (:foreground ,color-11))))
   `(jabber-title-small ((t (:height 1.1 :weight bold))))
   `(jabber-title-medium ((t (:height 1.2 :weight bold))))
   `(jabber-title-large ((t (:height 1.3 :weight bold))))
;;;;; ledger-mode
   `(ledger-font-payee-uncleared-face ((t (:foreground ,color-9 :weight bold))))
   `(ledger-font-payee-cleared-face ((t (:foreground ,color-13 :weight normal))))
   `(ledger-font-xact-highlight-face ((t (:background ,color-6))))
   `(ledger-font-pending-face ((t (:foreground ,color-11 weight: normal))))
   `(ledger-font-other-face ((t (:foreground ,color-13))))
   `(ledger-font-posting-account-face ((t (:foreground ,color-10))))
   `(ledger-font-posting-account-cleared-face ((t (:foreground ,color-13))))
   `(ledger-font-posting-account-pending-face ((t (:foreground ,color-11))))
   `(ledger-font-posting-amount-face ((t (:foreground ,color-11))))
   `(ledger-font-posting-account-pending-face ((t (:foreground ,color-11))))
   `(ledger-occur-narrowed-face ((t (:foreground ,color-7 :invisible t))))
   `(ledger-occur-xact-face ((t (:background ,color-6))))
   `(ledger-font-comment-face ((t (:foreground ,color-9))))
   `(ledger-font-reconciler-uncleared-face ((t (:foreground ,color-9 :weight bold))))
   `(ledger-font-reconciler-cleared-face ((t (:foreground ,color-13 :weight normal))))
   `(ledger-font-reconciler-pending-face ((t (:foreground ,color-11 :weight normal))))
   `(ledger-font-report-clickable-face ((t (:foreground ,color-11 :weight normal))))
;;;;; linum-mode
   `(linum ((t (:foreground ,color-11 :background ,color-4))))
;;;;; macrostep
   `(macrostep-gensym-1
     ((t (:foreground ,color-11 :background ,color-3))))
   `(macrostep-gensym-2
     ((t (:foreground ,color-11 :background ,color-3))))
   `(macrostep-gensym-3
     ((t (:foreground ,color-11 :background ,color-3))))
   `(macrostep-gensym-4
     ((t (:foreground ,color-10 :background ,color-3))))
   `(macrostep-gensym-5
     ((t (:foreground ,color-13 :background ,color-3))))
   `(macrostep-expansion-highlight-face
     ((t (:inherit highlight))))
   `(macrostep-macro-face
     ((t (:underline t))))
;;;;; magit
   `(magit-section-title ((t (:foreground ,color-13 :weight bold))))
   `(magit-branch ((t (:foreground ,color-11 :weight bold))))
   `(magit-item-highlight ((t (:background ,color-6 :bold nil))))
;;;;; egg
   `(egg-text-base ((t (:foreground ,color-13))))
   `(egg-help-header-1 ((t (:foreground ,color-13))))
   `(egg-help-header-2 ((t (:foreground ,color-12))))
   `(egg-branch ((t (:foreground ,color-13))))
   `(egg-branch-mono ((t (:foreground ,color-13))))
   `(egg-term ((t (:foreground ,color-13))))
   `(egg-diff-add ((t (:foreground ,color-13))))
   `(egg-diff-del ((t (:foreground ,color-11))))
   `(egg-diff-file-header ((t (:foreground ,color-11))))
   `(egg-section-title ((t (:foreground ,color-13))))
   `(egg-stash-mono ((t (:foreground ,color-13))))
;;;;; message-mode
   `(message-cited-text ((t (:inherit font-lock-comment-face))))
   `(message-header-name ((t (:foreground ,color-10))))
   `(message-header-other ((t (:foreground ,color-9))))
   `(message-header-to ((t (:foreground ,color-13 :weight bold))))
   `(message-header-from ((t (:foreground ,color-13 :weight bold))))
   `(message-header-cc ((t (:foreground ,color-13 :weight bold))))
   `(message-header-newsgroups ((t (:foreground ,color-13 :weight bold))))
   `(message-header-subject ((t (:foreground ,color-11 :weight bold))))
   `(message-header-xheader ((t (:foreground ,color-9))))
   `(message-mml ((t (:foreground ,color-13 :weight bold))))
   `(message-separator ((t (:inherit font-lock-comment-face))))
;;;;; mew
   `(mew-face-header-subject ((t (:foreground ,color-11))))
   `(mew-face-header-from ((t (:foreground ,color-13))))
   `(mew-face-header-date ((t (:foreground ,color-9))))
   `(mew-face-header-to ((t (:foreground ,color-10))))
   `(mew-face-header-key ((t (:foreground ,color-9))))
   `(mew-face-header-private ((t (:foreground ,color-9))))
   `(mew-face-header-important ((t (:foreground ,color-11))))
   `(mew-face-header-marginal ((t (:foreground ,color-13 :weight bold))))
   `(mew-face-header-warning ((t (:foreground ,color-10))))
   `(mew-face-header-xmew ((t (:foreground ,color-9))))
   `(mew-face-header-xmew-bad ((t (:foreground ,color-10))))
   `(mew-face-body-url ((t (:foreground ,color-11))))
   `(mew-face-body-comment ((t (:foreground ,color-13 :slant italic))))
   `(mew-face-body-cite1 ((t (:foreground ,color-9))))
   `(mew-face-body-cite2 ((t (:foreground ,color-11))))
   `(mew-face-body-cite3 ((t (:foreground ,color-11))))
   `(mew-face-body-cite4 ((t (:foreground ,color-13))))
   `(mew-face-body-cite5 ((t (:foreground ,color-10))))
   `(mew-face-mark-review ((t (:foreground ,color-11))))
   `(mew-face-mark-escape ((t (:foreground ,color-9))))
   `(mew-face-mark-delete ((t (:foreground ,color-10))))
   `(mew-face-mark-unlink ((t (:foreground ,color-13))))
   `(mew-face-mark-refile ((t (:foreground ,color-9))))
   `(mew-face-mark-unread ((t (:foreground ,color-9))))
   `(mew-face-eof-message ((t (:foreground ,color-9))))
   `(mew-face-eof-part ((t (:foreground ,color-13))))
;;;;; mic-paren
   `(paren-face-match ((t (:foreground ,color-12 :background ,color-3 ))))
   `(paren-face-mismatch ((t (:foreground ,color-2 :background ,color-3 ))))
   `(paren-face-no-match ((t (:foreground ,color-6 :background ,color-3 ))))
;;;;; mingus
   `(mingus-directory-face ((t (:foreground ,color-11))))
   `(mingus-pausing-face ((t (:foreground ,color-10))))
   `(mingus-playing-face ((t (:foreground ,color-12))))
   `(mingus-playlist-face ((t (:foreground ,color-12 ))))
   `(mingus-song-file-face ((t (:foreground ,color-13))))
   `(mingus-stopped-face ((t (:foreground ,color-10))))
;;;;; nav
   `(nav-face-heading ((t (:foreground ,color-13))))
   `(nav-face-button-num ((t (:foreground ,color-12))))
   `(nav-face-dir ((t (:foreground ,color-9))))
   `(nav-face-hdir ((t (:foreground ,color-10))))
   `(nav-face-file ((t (:foreground ,color-13))))
   `(nav-face-hfile ((t (:foreground ,color-7))))
;;;;; mu4e
   `(mu4e-cited-1-face ((t (:foreground ,color-11    :slant italic))))
   `(mu4e-cited-2-face ((t (:foreground ,color-11 :slant italic))))
   `(mu4e-cited-3-face ((t (:foreground ,color-9  :slant italic))))
   `(mu4e-cited-4-face ((t (:foreground ,color-9   :slant italic))))
   `(mu4e-cited-5-face ((t (:foreground ,color-7  :slant italic))))
   `(mu4e-cited-6-face ((t (:foreground ,color-8 :slant italic))))
   `(mu4e-cited-7-face ((t (:foreground ,color-11    :slant italic))))
   `(mu4e-replied-face ((t (:foreground ,color-8))))
   `(mu4e-trashed-face ((t (:foreground ,color-8 :strike-through t))))
;;;;; mumamo
   `(mumamo-background-chunk-major ((t (:background nil))))
   `(mumamo-background-chunk-submode1 ((t (:background ,color-3))))
   `(mumamo-background-chunk-submode2 ((t (:background ,color-7))))
   `(mumamo-background-chunk-submode3 ((t (:background ,color-8))))
   `(mumamo-background-chunk-submode4 ((t (:background ,color-6))))
;;;;; org-mode
   `(org-agenda-date-today
     ((t (:foreground ,color-14 :slant italic :weight bold))) t)
   `(org-agenda-structure
     ((t (:inherit font-lock-comment-face))))
   `(org-archived ((t (:foreground ,color-13 :weight bold))))
   `(org-checkbox ((t (:background ,color-7 :foreground ,color-14
                                   :box (:line-width 1 :style released-button)))))
   `(org-date ((t (:foreground ,color-11 :underline t))))
   `(org-deadline-announce ((t (:foreground ,color-9))))
   `(org-done ((t (:bold t :weight bold :foreground ,color-12))))
   `(org-formula ((t (:foreground ,color-11))))
   `(org-headline-done ((t (:foreground ,color-12))))
   `(org-hide ((t (:foreground ,color-3))))
   `(org-document-title ((t (:foreground ,color-12 :height 1.9 :bold t))))
   `(org-level-1 ((t (:foreground ,color-14 :height 1.5))))
   `(org-level-2 ((t (:foreground ,color-10 :height 1.2))))
   `(org-level-3 ((t (:foreground ,color-9 :height 1.1))))
   `(org-level-4 ((t (:foreground ,color-9 :height 1.0))))
   `(org-level-5 ((t (:foreground ,color-9 :height 1.0))))
   `(org-level-6 ((t (:foreground ,color-9 :height 1.0))))
   `(org-level-7 ((t (:foreground ,color-9 :height 1.0))))
   `(org-level-8 ((t (:foreground ,color-8 :height 1.0))))
   `(org-link ((t (:foreground ,color-11 :underline t))))
   `(org-scheduled ((t (:foreground ,color-13))))
   `(org-scheduled-previously ((t (:foreground ,color-10))))
   `(org-scheduled-today ((t (:foreground ,color-11))))
   `(org-sexp-date ((t (:foreground ,color-11 :underline t))))
   `(org-special-keyword ((t (:inherit font-lock-comment-face))))
   `(org-table ((t (:foreground ,color-11))))
   `(org-tag ((t (:bold t :weight bold))))
   `(org-time-grid ((t (:foreground ,color-11))))
   `(org-todo ((t (:bold t :foreground ,color-10 :weight bold))))
   `(org-upcoming-deadline ((t (:inherit font-lock-keyword-face))))
   `(org-warning ((t (:bold t :foreground ,color-10 :weight bold :underline nil))))
   `(org-column ((t (:background ,color-3))))
   `(org-column-title ((t (:background ,color-3 :underline t :weight bold))))
   `(org-mode-line-clock ((t (:foreground ,color-13 :background ,color-3))))
   `(org-mode-line-clock-overrun ((t (:foreground ,color-5 :background ,color-9))))
   `(org-ellipsis ((t (:foreground ,color-12 :underline t))))
   `(org-footnote ((t (:foreground ,color-12 :underline t))))
   `(org-meta-line ((t (:foreground ,color-8 :height 0.5))))
   `(org-block-background ((t (:background ,color-4 :height 0.7))))

;;;;; outline
   `(outline-1 ((t (:foreground ,color-11))))
   `(outline-2 ((t (:foreground ,color-13))))
   `(outline-3 ((t (:foreground ,color-10))))
   `(outline-4 ((t (:foreground ,color-11))))
   `(outline-5 ((t (:foreground ,color-12))))
   `(outline-6 ((t (:foreground ,color-11))))
   `(outline-7 ((t (:foreground ,color-7))))
   `(outline-8 ((t (:foreground ,color-7))))
;;;;; p4
   `(p4-depot-added-face ((t :inherit diff-added)))
   `(p4-depot-branch-op-face ((t :inherit diff-changed)))
   `(p4-depot-deleted-face ((t :inherit diff-removed)))
   `(p4-depot-unmapped-face ((t :inherit diff-changed)))
   `(p4-diff-change-face ((t :inherit diff-changed)))
   `(p4-diff-del-face ((t :inherit diff-removed)))
   `(p4-diff-file-face ((t :inherit diff-file-header)))
   `(p4-diff-head-face ((t :inherit diff-header)))
   `(p4-diff-ins-face ((t :inherit diff-added)))
;;;;; perspective
   `(persp-selected-face ((t (:foreground ,color-11 :inherit mode-line))))
;;;;; powerline
   `(powerline-active1 ((t (:background ,color-6 :foreground ,color-11 :inherit mode-line))))
   `(powerline-active2 ((t (:background ,color-8 :foreground ,color-1 :inherit mode-line))))
   `(powerline-inactive1 ((t (:background ,color-6 :foreground ,color-4 :inherit mode-line-inactive))))
   `(powerline-inactive2 ((t (:background ,color-5 :foreground ,color-3 :inherit mode-line-inactive))))
;;;;; proofgeneral
   `(proof-active-area-face ((t (:underline t))))
   `(proof-boring-face ((t (:foreground ,color-13 :background ,color-7))))
   `(proof-command-mouse-highlight-face ((t (:inherit proof-mouse-highlight-face))))
   `(proof-debug-message-face ((t (:inherit proof-boring-face))))
   `(proof-declaration-name-face ((t (:inherit font-lock-keyword-face :foreground nil))))
   `(proof-eager-annotation-face ((t (:foreground ,color-5 :background ,color-11))))
   `(proof-error-face ((t (:foreground ,color-13 :background ,color-7))))
   `(proof-highlight-dependency-face ((t (:foreground ,color-5 :background ,color-12))))
   `(proof-highlight-dependent-face ((t (:foreground ,color-5 :background ,color-11))))
   `(proof-locked-face ((t (:background ,color-6))))
   `(proof-mouse-highlight-face ((t (:foreground ,color-5 :background ,color-11))))
   `(proof-queue-face ((t (:background ,color-7))))
   `(proof-region-mouse-highlight-face ((t (:inherit proof-mouse-highlight-face))))
   `(proof-script-highlight-error-face ((t (:background ,color-9))))
   `(proof-tacticals-name-face ((t (:inherit font-lock-constant-face :foreground nil :background ,color-4))))
   `(proof-tactics-name-face ((t (:inherit font-lock-constant-face :foreground nil :background ,color-4))))
   `(proof-warning-face ((t (:foreground ,color-5 :background ,color-12))))
;;;;; rainbow-delimiters
   `(rainbow-delimiters-depth-1-face ((t (:foreground ,color-7))))
   `(rainbow-delimiters-depth-2-face ((t (:foreground ,color-8))))
   `(rainbow-delimiters-depth-3-face ((t (:foreground ,color-9))))
   `(rainbow-delimiters-depth-4-face ((t (:foreground ,color-10))))
   `(rainbow-delimiters-depth-5-face ((t (:foreground ,color-11))))
   `(rainbow-delimiters-depth-6-face ((t (:foreground ,color-12))))
   `(rainbow-delimiters-depth-7-face ((t (:foreground ,color-13))))
   `(rainbow-delimiters-depth-8-face ((t (:foreground ,color-14))))
   `(rainbow-delimiters-depth-9-face ((t (:foreground ,color-14))))
   `(rainbow-delimiters-depth-10-face ((t (:foreground ,color-14))))
   `(rainbow-delimiters-depth-11-face ((t (:foreground ,color-14))))
   `(rainbow-delimiters-depth-12-face ((t (:foreground ,color-14))))
;;;;; rcirc
   `(rcirc-my-nick ((t (:foreground ,color-11))))
   `(rcirc-other-nick ((t (:foreground ,color-11))))
   `(rcirc-bright-nick ((t (:foreground ,color-11))))
   `(rcirc-dim-nick ((t (:foreground ,color-9))))
   `(rcirc-server ((t (:foreground ,color-9))))
   `(rcirc-server-prefix ((t (:foreground ,color-10))))
   `(rcirc-timestamp ((t (:foreground ,color-11))))
   `(rcirc-nick-in-message ((t (:foreground ,color-13))))
   `(rcirc-nick-in-message-full-line ((t (:bold t))))
   `(rcirc-prompt ((t (:foreground ,color-13 :bold t))))
   `(rcirc-track-nick ((t (:inverse-video t))))
   `(rcirc-track-keyword ((t (:bold t))))
   `(rcirc-url ((t (:bold t))))
   `(rcirc-keyword ((t (:foreground ,color-13 :bold t))))
;;;;; rpm-mode
   `(rpm-spec-dir-face ((t (:foreground ,color-9))))
   `(rpm-spec-doc-face ((t (:foreground ,color-9))))
   `(rpm-spec-ghost-face ((t (:foreground ,color-10))))
   `(rpm-spec-macro-face ((t (:foreground ,color-13))))
   `(rpm-spec-obsolete-tag-face ((t (:foreground ,color-10))))
   `(rpm-spec-package-face ((t (:foreground ,color-10))))
   `(rpm-spec-section-face ((t (:foreground ,color-13))))
   `(rpm-spec-tag-face ((t (:foreground ,color-11))))
   `(rpm-spec-var-face ((t (:foreground ,color-10))))
;;;;; rst-mode
   `(rst-level-1-face ((t (:foreground ,color-11))))
   `(rst-level-2-face ((t (:foreground ,color-10))))
   `(rst-level-3-face ((t (:foreground ,color-10))))
   `(rst-level-4-face ((t (:foreground ,color-11))))
   `(rst-level-5-face ((t (:foreground ,color-12))))
   `(rst-level-6-face ((t (:foreground ,color-8))))
;;;;; sh-mode
   `(sh-heredoc     ((t (:foreground ,color-13 :bold t))))
   `(sh-quoted-exec ((t (:foreground ,color-10))))
;;;;; show-paren
   `(show-paren-mismatch-face ((t (:foreground ,color-1 :background ,color-4 :weight bold))))
   `(show-paren-match-face ((t (:foreground ,color-11 :background ,color-3  :weight bold))))
;;;;; smartparens
   `(sp-show-pair-mismatch-face ((t (:foreground ,color-14 :background ,color-4 :weight bold))))
   `(sp-show-pair-match-face ((t (:weight bold :underline t))))
;;;;; sml-mode-line
   '(sml-modeline-end-face ((t :inherit default :width condensed)))
;;;;; SLIME
   `(slime-repl-output-face ((t (:foreground ,color-10))))
   `(slime-repl-inputed-output-face ((t (:foreground ,color-9))))
   `(slime-error-face
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,color-10)))
      (t
       (:underline ,color-10))))
   `(slime-warning-face
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,color-11)))
      (t
       (:underline ,color-11))))
   `(slime-style-warning-face
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,color-13)))
      (t
       (:underline ,color-13))))
   `(slime-note-face
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,color-9)))
      (t
       (:underline ,color-9))))
   `(slime-highlight-face ((t (:inherit highlight))))
;;;;; speedbar
   `(speedbar-button-face ((t (:foreground ,color-11))))
   `(speedbar-directory-face ((t (:foreground ,color-12))))
   `(speedbar-file-face ((t (:foreground ,color-13))))
   `(speedbar-highlight-face ((t (:foreground ,color-5 :background ,color-11))))
   `(speedbar-selected-face ((t (:foreground ,color-10))))
   `(speedbar-separator-face ((t (:foreground ,color-5 :background ,color-10))))
   `(speedbar-tag-face ((t (:foreground ,color-13))))
;;;;; tabbar
   `(tabbar-button ((t (:foreground ,color-13
                                    :background ,color-4))))
   `(tabbar-selected ((t (:foreground ,color-13
                                      :background ,color-4
                                      :box (:line-width -1 :style pressed-button)))))
   `(tabbar-unselected ((t (:foreground ,color-13
                                        :background ,color-6
                                        :box (:line-width -1 :style released-button)))))
;;;;; term
   `(term-color-black ((t (:foreground ,color-5
                                       :background ,color-3))))
   `(term-color-red ((t (:foreground ,color-9
                                     :background ,color-7))))
   `(term-color-green ((t (:foreground ,color-9
                                       :background ,color-11))))
   `(term-color-yellow ((t (:foreground ,color-11
                                        :background ,color-13))))
   `(term-color-blue ((t (:foreground ,color-10
                                      :background ,color-7))))
   `(term-color-magenta ((t (:foreground ,color-10
                                         :background ,color-10))))
   `(term-color-cyan ((t (:foreground ,color-12
                                      :background ,color-11))))
   `(term-color-white ((t (:foreground ,color-13
                                       :background ,color-7))))
   '(term-default-fg-color ((t (:inherit term-color-white))))
   '(term-default-bg-color ((t (:inherit term-color-black))))
;;;;; undo-tree
   `(undo-tree-visualizer-active-branch-face ((t (:foreground ,color-14 :weight bold))))
   `(undo-tree-visualizer-current-face ((t (:foreground ,color-9 :weight bold))))
   `(undo-tree-visualizer-default-face ((t (:foreground ,color-13))))
   `(undo-tree-visualizer-register-face ((t (:foreground ,color-13))))
   `(undo-tree-visualizer-unmodified-face ((t (:foreground ,color-12))))
;;;;; volatile-highlights
   `(vhl/default-face ((t (:background ,color-4))))
;;;;; emacs-w3m
   `(w3m-anchor ((t (:foreground ,color-13 :underline t
                                 :weight bold))))
   `(w3m-arrived-anchor ((t (:foreground ,color-11
                                         :underline t :weight normal))))
   `(w3m-form ((t (:foreground ,color-9 :underline t))))
   `(w3m-header-line-location-title ((t (:foreground ,color-13
                                                     :underline t :weight bold))))
   '(w3m-history-current-url ((t (:inherit match))))
   `(w3m-lnum ((t (:foreground ,color-11 :background ,color-4))))
   `(w3m-lnum-match ((t (:background ,color-3
                                     :foreground ,color-11
                                     :weight bold))))
   `(w3m-lnum-minibuffer-prompt ((t (:foreground ,color-13))))
;;;;; web-mode
   `(web-mode-builtin-face ((t (:inherit ,font-lock-builtin-face))))
   `(web-mode-comment-face ((t (:inherit ,font-lock-comment-face))))
   `(web-mode-constant-face ((t (:inherit ,font-lock-constant-face))))
   `(web-mode-css-at-rule-face ((t (:foreground ,color-11 ))))
   `(web-mode-css-prop-face ((t (:foreground ,color-11))))
   `(web-mode-css-pseudo-class-face ((t (:foreground ,color-12 :weight bold))))
   `(web-mode-css-rule-face ((t (:foreground ,color-11))))
   `(web-mode-doctype-face ((t (:inherit ,font-lock-comment-face))))
   `(web-mode-folded-face ((t (:underline t))))
   `(web-mode-function-name-face ((t (:foreground ,color-11))))
   `(web-mode-html-attr-name-face ((t (:foreground ,color-11))))
   `(web-mode-html-attr-value-face ((t (:inherit ,font-lock-string-face))))
   `(web-mode-html-tag-face ((t (:foreground ,color-12))))
   `(web-mode-keyword-face ((t (:inherit ,font-lock-keyword-face))))
   `(web-mode-preprocessor-face ((t (:inherit ,font-lock-preprocessor-face))))
   `(web-mode-string-face ((t (:inherit ,font-lock-string-face))))
   `(web-mode-type-face ((t (:inherit ,font-lock-type-face))))
   `(web-mode-variable-name-face ((t (:inherit ,font-lock-variable-name-face))))
   `(web-mode-server-background-face ((t (:background ,color-4))))
   `(web-mode-server-comment-face ((t (:inherit web-mode-comment-face))))
   `(web-mode-server-string-face ((t (:inherit web-mode-string-face))))
   `(web-mode-symbol-face ((t (:inherit font-lock-constant-face))))
   `(web-mode-warning-face ((t (:inherit font-lock-warning-face))))
   `(web-mode-whitespaces-face ((t (:background ,color-10))))
;;;;; whitespace-mode
   `(whitespace-space ((t (:background ,color-6 :foreground ,color-6))))
   `(whitespace-hspace ((t (:background ,color-6 :foreground ,color-6))))
   `(whitespace-tab ((t (:background ,color-9))))
   `(whitespace-newline ((t (:foreground ,color-6))))
   `(whitespace-trailing ((t (:background ,color-10))))
   `(whitespace-line ((t (:background ,color-4 :foreground ,color-10))))
   `(whitespace-space-before-tab ((t (:background ,color-11 :foreground ,color-11))))
   `(whitespace-indentation ((t (:background ,color-13 :foreground ,color-10))))
   `(whitespace-empty ((t (:background ,color-13))))
   `(whitespace-space-after-tab ((t (:background ,color-13 :foreground ,color-10))))
;;;;; wanderlust
   `(wl-highlight-folder-few-face ((t (:foreground ,color-9))))
   `(wl-highlight-folder-many-face ((t (:foreground ,color-9))))
   `(wl-highlight-folder-path-face ((t (:foreground ,color-11))))
   `(wl-highlight-folder-unread-face ((t (:foreground ,color-11))))
   `(wl-highlight-folder-zero-face ((t (:foreground ,color-13))))
   `(wl-highlight-folder-unknown-face ((t (:foreground ,color-11))))
   `(wl-highlight-message-citation-header ((t (:foreground ,color-9))))
   `(wl-highlight-message-cited-text-1 ((t (:foreground ,color-10))))
   `(wl-highlight-message-cited-text-2 ((t (:foreground ,color-11))))
   `(wl-highlight-message-cited-text-3 ((t (:foreground ,color-11))))
   `(wl-highlight-message-cited-text-4 ((t (:foreground ,color-11))))
   `(wl-highlight-message-header-contents-face ((t (:foreground ,color-9))))
   `(wl-highlight-message-headers-face ((t (:foreground ,color-11))))
   `(wl-highlight-message-important-header-contents ((t (:foreground ,color-11))))
   `(wl-highlight-message-header-contents ((t (:foreground ,color-10))))
   `(wl-highlight-message-important-header-contents2 ((t (:foreground ,color-11))))
   `(wl-highlight-message-signature ((t (:foreground ,color-9))))
   `(wl-highlight-message-unimportant-header-contents ((t (:foreground ,color-13))))
   `(wl-highlight-summary-answered-face ((t (:foreground ,color-11))))
   `(wl-highlight-summary-disposed-face ((t (:foreground ,color-13
                                                         :slant italic))))
   `(wl-highlight-summary-new-face ((t (:foreground ,color-11))))
   `(wl-highlight-summary-normal-face ((t (:foreground ,color-13))))
   `(wl-highlight-summary-thread-top-face ((t (:foreground ,color-13))))
   `(wl-highlight-thread-indent-face ((t (:foreground ,color-10))))
   `(wl-highlight-summary-refiled-face ((t (:foreground ,color-13))))
   `(wl-highlight-summary-displaying-face ((t (:underline t :weight bold))))
;;;;; which-func-mode
   `(which-func ((t (:foreground ,color-13))))
;;;;; yascroll
   `(yascroll:thumb-text-area ((t (:background ,color-3))))
   `(yascroll:thumb-fringe ((t (:background ,color-3 :foreground ,color-3))))
   `(minimap-active-region-background ((t (:background ,color-6 :foreground ,color-7))))
;;;;; html fold/unfold face
   `(html-fold-unfolded-face ((t (:background ,color-4))))
   `(html-fold-folded-face ((t (:foreground ,color-14 :bold t))))
;;;;; markdown mode
   `(markdown-header-delimiter-face ((t (:inherit font-lock-function-name-face :weight bold :foreground ,color-5))))
   `(markdown-header-face-1 ((t (:inherit markdown-header-face :height 1.5))))
   `(markdown-header-face-2 ((t (:inherit markdown-header-face :height 1.3))))
   `(markdown-header-face-3 ((t (:inherit markdown-header-face :underline t :height 1.2))))
   `(markdown-header-face-4 ((t (:inherit markdown-header-face :underline t :height 1.1))))
   `(markdown-header-face-5 ((t (:inherit markdown-header-face :underline t))))
   `(markdown-header-face-6 ((t (:inherit markdown-header-face :underline t))))
;;;; swoop
   `(swoop-face-line-buffer-name ((t (:background ,color-9 :foreground ,color-1))))
   `(swoop-face-target-line ((t (:background ,color-7 :foreground ,color-12))))
   `(swoop-face-line-number ((t (:background ,color-4 :foreground ,color-6))))
   `(swoop-face-header-format-line ((t (:background ,color-6 :foreground ,color-1))))
   `(swoop-face-target-words ((t (:background ,color-6 :foreground ,color-13))))
   ))

;;; Theme Variables
(tao-with-color-variables
  (custom-theme-set-variables
   'tao
;;;;; ansi-color
   `(ansi-color-names-vector [,color-5 ,color-10 ,color-9 ,color-13
                                          ,color-11 ,color-10 ,color-12 ,color-13])
;;;;; fill-column-indicator
   `(fci-rule-color ,color-4)
;;;;; vc-annotate
   `(vc-annotate-color-map
     '(( 20. . ,color-7)
       ( 40. . ,color-8)
       ( 60. . ,color-8)
       ( 80. . ,color-9)
       (100. . ,color-9)
       (120. . ,color-10)
       (140. . ,color-10)
       (160. . ,color-11)
       (180. . ,color-11)
       (200. . ,color-11)
       (220. . ,color-12)
       (240. . ,color-12)
       (260. . ,color-12)
       (280. . ,color-13)
       (300. . ,color-13)
       (320. . ,color-13)
       (340. . ,color-14)
       (360. . ,color-14)))
   `(vc-annotate-very-old-color ,color-10)
   `(vc-annotate-background ,color-3)
   ))


;;; Rainbow Support

(declare-function rainbow-mode 'rainbow-mode)
(declare-function rainbow-colorize-by-assoc 'rainbow-mode)

(defvar tao-add-font-lock-keywords nil
  "Whether to add font-lock keywords for tao color names.
In buffers visiting library `tao-theme.el' the tao
specific keywords are always added.  In all other Emacs-Lisp
buffers this variable controls whether this should be done.
This requires library `rainbow-mode'.")

(defvar tao-colors-font-lock-keywords nil)

;; (defadvice rainbow-turn-on (after tao activate)
;;   "Maybe also add font-lock keywords for tao colors."
;;   (when (and (derived-mode-p 'emacs-lisp-mode)
;;              (or tao-add-font-lock-keywords
;;                  (equal (file-name-nondirectory (buffer-file-name))
;;                         "tao-theme.el")))
;;     (unless tao-colors-font-lock-keywords
;;       (setq tao-colors-font-lock-keywords
;;             `((,(regexp-opt (mapcar 'car tao-colors-alist) 'words)
;;                (0 (rainbow-colorize-by-assoc tao-colors-alist))))))
;;     (font-lock-add-keywords nil tao-colors-font-lock-keywords)))

;; (defadvice rainbow-turn-off (after tao activate)
;;   "Also remove font-lock keywords for tao colors."
;;   (font-lock-remove-keywords nil tao-colors-font-lock-keywords))

;;; Footer

;;;###autoload
(and load-file-name
   (boundp 'custom-theme-load-path)
   (add-to-list 'custom-theme-load-path
                (file-name-as-directory
                 (file-name-directory load-file-name))))

(provide-theme 'tao)

;;;###autoload
(add-to-list 'safe-local-eval-forms
             '(when (require 'rainbow-mode nil t) (rainbow-mode 1)))

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; eval: (when (require 'rainbow-mode nil t) (rainbow-mode 1))
;; End:
;;; tao-theme.el ends here
