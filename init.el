;; -*- mode: emacs-lisp -*-

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   dotspacemacs-distribution 'spacemacs
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()

   dotspacemacs-configuration-layers
   '(
     org
     git
     yaml
     (ibuffer :variables ibuffer-group-buffers-by 'projects)
     emacs-lisp
     better-defaults
     syntax-checking
     (auto-completion
      :variables
      auto-completion-enable-snippets-in-popup t
      auto-completion-private-snippets-directory (concat dotspacemacs-directory "snippets"))
     (python
      :variables
      python-test-runner 'pytest))

   dotspacemacs-additional-packages
   '(visual-regexp
     mark-multiple
     dedicated)

   dotspacemacs-excluded-packages '()

   ;; If non-nil spacemacs will delete any orphan packages, i.e. packages that
   ;; are declared in a layer which is not a member of
   ;; the list `dotspacemacs-configuration-layers'. (default t)
   dotspacemacs-delete-orphan-packages t))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  (setq-default
   dotspacemacs-editing-style   'vim
   dotspacemacs-verbose-loading  nil
   dotspacemacs-startup-banner  'nil
   dotspacemacs-startup-lists '(recents bookmarks projects)

   ;; Press <leader> T n to cycle to the next theme in the list.
   dotspacemacs-themes '(spacemacs-dark
                         spacemacs-light
                         solarized-light
                         solarized-dark
                         leuven
                         monokai
                         zenburn)

   dotspacemacs-colorize-cursor-according-to-state t
   dotspacemacs-default-font '("Source Code Pro"
                               :size 13
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   dotspacemacs-leader-key "SPC"
   dotspacemacs-emacs-leader-key "M-m"
   dotspacemacs-major-mode-leader-key ";"
   dotspacemacs-major-mode-emacs-leader-key "C-;"
   dotspacemacs-command-key ":"

   dotspacemacs-remap-Y-to-y$ t
   dotspacemacs-auto-save-file-location 'cache

   ;; Helm
   dotspacemacs-use-ido nil
   dotspacemacs-helm-resize nil
   dotspacemacs-helm-no-header t
   dotspacemacs-helm-position 'bottom

   ;; UI
   dotspacemacs-enable-paste-micro-state nil
   dotspacemacs-which-key-delay 0.4
   dotspacemacs-which-key-position 'bottom
   dotspacemacs-loading-progress-bar t
   dotspacemacs-fullscreen-at-startup nil
   dotspacemacs-fullscreen-use-non-native nil
   dotspacemacs-maximized-at-startup nil
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols nil
   dotspacemacs-smooth-scrolling nil
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil advises quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   dotspacemacs-default-package-repository nil
   ))

;;;---------------------------------------------------------------------------
;;; User Config
;;;---------------------------------------------------------------------------
(defconst is-bsd (eq system-type 'berkeley-unix))
(defconst is-linux (eq system-type 'gnu/linux))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init'.  You are free to put any
user code."

  (setq-default git-magit-status-fullscreen t))

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
 This function is called at the very end of Spacemacs initialization after
layers configuration. You are free to put any user code."

  ;;--------------------------------------------------------------------------
  (add-to-list 'load-path (concat dotspacemacs-directory "/lisp"))
  (require 'my-defuns)
  (require 'my-config-defuns)

  ;;--------------------------------------------------------------------------
  ;; backup, autosave and lockfiles
  (setq backup-directory-alist         `((".*" . ,(concat spacemacs-cache-directory "/backups/"))))
  ;; (setq auto-save-file-name-transforms `((".*", "~/.emacs.d/backups/" t))
  (setq version-control t
        make-backup-files t
        backup-by-copying t
        delete-by-moving-to-trash nil
        kept-old-versions 5
        kept-new-versions 9
        auto-save-timeout 20
        auto-save-interval 200
        create-lockfiles t)

  ;;--------------------------------------------------------------------------
  ;; clipboard
  (setq x-select-enable-clipboard t
        x-select-enable-primary t
        save-interprogram-paste-before-kill t
        mouse-yank-at-point t)

  ;;--------------------------------------------------------------------------
  ;; ui
  (setq powerline-default-separator 'nil)
  (setq scroll-step 2)
  (setq scroll-conservatively 4)
  ;; (setq split-height-threshold 110)
  ;; (setq enable-recursive-minibuffers nil)
  (setq mouse-wheel-follow-mouse t
        mouse-wheel-scroll-amount '(1 ((shift) . 1)))

  ;;--------------------------------------------------------------------------
  ;; editor
  (setq-default tab-width 4
                c-basic-offset 4
                indent-tabs-mode nil
                tab-always-indent 'complete)

  (setq require-final-newline t)

  ;;--------------------------------------------------------------------------
  ;; mode customizaitons
  (setq recentf-max-saved-items 500)
  (setq recentf-max-menu-items 40)

  ;; dired -------------------------------------------------------------------
  (setq-default dired-listing-switches (if is-bsd "-alh" "-alhv"))
  (setq dired-recursive-deletes 'top)
  (setq dired-recursive-copies 'top)
  (setq dired-dwim-target t)

  (setq dired-auto-revert-buffer t)

  ;; company -----------------------------------------------------------------
  (setq company-show-numbers t)

  ;; tramp -------------------------------------------------------------------
  (setq password-cache-expiry nil)

  ;; ibuffer -----------------------------------------------------------------
  (spacemacs|use-package-add-hook ibuffer
    :post-config
    (progn
      (define-ibuffer-column size-human
        (:name "Size" :inline t)
        (cond
         ((> (buffer-size) 1000000) (format "%7.1fM" (/ (buffer-size) 1000000.0)))
         ((> (buffer-size) 1000) (format "%7.1fk" (/ (buffer-size) 1000.0)))
         (t (format "%8d" (buffer-size)))))

      (add-hook! 'ibuffer-mode-hook
                 (progn
                   (ibuffer-tramp-set-filter-groups-by-tramp-connection)
                   (ibuffer-tramp-set-filter-groups-by-tramp-connection)
                   (ibuffer-do-sort-by-alphabetic)))))

  ;; magit -------------------------------------------------------------------
  (spacemacs|use-package-add-hook magit
    :post-config
    (progn
      (setq magit-push-always-verify t
            magit-process-popup-time -1
            magit-diff-refine-hunk nil
            magit-repository-directories '("~/source/github" "~/source/work" "~/source/misc"))))


  ;; helm --------------------------------------------------------------------
  ;; (eval-after-load 'helm
  ;;   (add-to-list 'helm-boring-buffer-regexp-list
  ;;                (rx (or
  ;;                     "*Ibuffer*"
  ;;                     "*Help*"
  ;;                     "*Completions*"
  ;;                     "*Customize")))
  ;;   (define-key helm-map (kbd "<f11>") 'my/helm-fullscreen-toggle))

  ;; mark-multiple -----------------------------------------------------------
  (use-package mark-multiple
    :init
    (progn
      (define-key evil-visual-state-map "]" 'mark-next-like-this)
      (define-key evil-visual-state-map "[" 'mark-previous-like-this)
      (define-key evil-visual-state-map "m" 'mark-more-like-this)))

  ;; calendar ----------------------------------------------------------------
  (setq calendar-week-start-day 1
        calendar-date-style 'european
        calendar-mark-holidays-flag nil)

  ; add week numbers
  (setq calendar-intermonth-text
        '(propertize
          (format "%2d"
                  (car
                   (calendar-iso-from-absolute
                    (calendar-absolute-from-gregorian (list month day year)))))
          'font-lock-face 'font-lock-warning-face))
  (setq calendar-intermonth-header
        (propertize "Wk" 'font-lock-face 'font-lock-keyword-face))

  ;; -------------------------------------------------------------------------
  (use-package dedicated
    :bind ("C-x d" . dedicated-mode))

  ;;--------------------------------------------------------------------------
  ;; shortcuts
  (global-set-key [down-mouse-3] 'x-menu-bar-open)
  (global-set-key (kbd "<menu>") 'x-menu-bar-open)
  (global-set-key (kbd "C-:") 'eval-expression)

  (dolist (map '(normal visual motion hybrid emacs))
    (evil-global-set-key map (kbd ",")
                         (lookup-key evil-leader--default-map (kbd "o"))))

  (global-set-key (kbd "<f12>") 'spacemacs/toggle-whitespace)

  (evil-define-key 'visual evil-surround-mode-map "S" 'evil-surround-region)
  (evil-define-key 'visual evil-surround-mode-map "s" 'evil-substitute)

  (evil-leader/set-key
    ;; helm shortcuts
    "o f"  'helm-find-files
    "o m"  'helm-recentf
    "o l"  'helm-mini
    "o p"  'helm-projectile
    "o y"  'helm-show-kill-ring
    "o sw" 'helm-swoop
    "o b"  'ibuffer

    ;; query/replace
    "o vr" 'vr/replace
    "o vq" 'vr/query-replace

    ;; files and buffers
    "o w" 'spacemacs/write-file
    "o k" 'kill-this-buffer
    "o d" 'kill-buffer-and-window
    "o q" 'kill-buffer-and-window
    "s c" (lambda () (interactive) (switch-to-buffer "*scratch*"))

    "o h" 'ff-find-other-file
    "o u" 'undo-tree-visualize
    "o r" 'dired-jump
    "o i" 'helm-semantic-or-imenu
    "o er" 'evil-show-registers

    "o g" (lookup-key evil-leader--default-map (kbd "g"))
    )

  ;; misc
  (setq-default buffers-menu-max-size 20)
  (setq-default compilation-scroll-output 'first-error)
  ;; (setq indicate-buffer-boundaries 'left)

  ;; compatibility vars and defuns
  (setq-default redisplay-dont-pause t)

  ;;--------------------------------------------------------------------------
  ;; hooks
  ;; (add-hook 'before-save-hook 'whitespace-cleanup)
  (add-hook 'before-save-hook 'delete-trailing-whitespace)
  (add-hook 'text-mode-hook 'enable-hard-wrap)
  (add-hook 'prog-mode-hook 'enable-comment-hard-wrap)
)

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.