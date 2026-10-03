;;; early-init.el --- Agent Emacs early init -*- lexical-binding: t -*-

;;; Commentary:

;; Settings that must take effect before the first frame is drawn or
;; before package.el would initialize.

;;; Code:

;; Elpaca manages packages; package.el must not activate anything.
(setq package-enable-at-startup nil)

;; Collect garbage rarely during startup, then return to a sane threshold.
(setq gc-cons-threshold most-positive-fixnum)
(add-hook 'emacs-startup-hook
          (lambda () (setq gc-cons-threshold (* 64 1024 1024))))

(setq load-prefer-newer t)

;; Packages are compiled to native code in the background; their compiler
;; warnings are for package authors, so do not pop them up.
(setq native-comp-async-report-warnings-errors 'silent)

;; Frame: no toolbar or scroll bars, maximized, no flash of unstyled UI.
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
(push '(horizontal-scroll-bars) default-frame-alist)
(push '(fullscreen . maximized) initial-frame-alist)
(setq frame-inhibit-implied-resize t
      frame-resize-pixelwise t
      inhibit-startup-screen t)

;; Paint a dark background immediately when macOS is in dark mode, so the
;; window does not flash white before the theme loads.
(when (and (eq system-type 'darwin)
           (equal (string-trim
                   (shell-command-to-string
                    "defaults read -g AppleInterfaceStyle 2>/dev/null"))
                  "Dark"))
  (push '(background-color . "#000000") default-frame-alist)
  (push '(foreground-color . "#ffffff") default-frame-alist))

;;; early-init.el ends here
