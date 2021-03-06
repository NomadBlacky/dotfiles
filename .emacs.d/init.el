;;
;; ロードパスを追加する関数を定義
;;
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
	      (expand-file-name (concat user-emacs-directory path))))
	(add-to-list 'load-path default-directory)
	(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
	    (normal-top-level-add-subdirs-to-load-path))))))

;;
;; 引数のディレクトリとそのサブディレクトリをload-pathに追加
;;
(add-to-load-path "elisp" "conf" "public_repos" )

;;
;; init-loader
;; http://coderepos.org/share/browser/lang/elisp/init-loader/init-loader.el
;;
(require 'init-loader)
(init-loader-load "~/.emacs.d/conf") ;設定ファイルのあるディレクトリを指定

;;
;; Lispコメント用マクロ
;;
(fset 'cmt-lisp
   [?\; ?\; return ?\; ?\; return ?\; ?\; up ? ])

;;
;; C-mにnewline-and-indentを割り当てる。初期値はnewline
;;
(define-key global-map (kbd "C-m") 'newline-and-indent)
;; (global-set-key (kbd "C-m") 'newline-and-indent)

;;
;; 折り返しトグルコマンド
;;
(define-key global-map (kbd "C-c l") 'toggle-truncate-lines)

;;
;; "C-t"でウィンドウを切り替える。初期値はtranspose-chars
;;
(define-key global-map (kbd "C-t") 'other-window)

;;
;; カラム番号を表示
;;
(column-number-mode t)

;;
;; ファイルサイズを表示
;;
;;(size-indication-mode t)

;;
;; 時間を表示
;;
;;(setq display-time-day-and-date t) ;曜日・月・日を表示
;;(setq display-time-24hr-format t) ;24時間表示
;;(display-time-mode t)

;;
;; タイトルバーにファイルのフルパスを表示
;;
(setq frame-title-format "%f")

;;
;; TAB幅の設定。初期値は8。
;;
(setq-default tab-width 4)

;;
;; 表示テーマの設定
;;
(when (require 'color-theme nil t)
  ;; テーマを読み込むための設定
  (color-theme-initialize)
  ;; テーマをhoberに変更する
  ;;(color-theme-hober)
  )

;;
;; フォントの設定
;; inconsolata & Takao
;;
(set-default-font "Inconsolata-11")
(set-face-font 'variable-pitch "Inconsolata-11")
(set-fontset-font (frame-parameter nil 'font)
                  'japanese-jisx0208
                  '("Takaoゴシック" . "unicode-bmp")
)

;;
;; mozcの設定
;;
(require 'mozc)
(set-language-environment "Japanese")
(setq default-input-method "japanese-mozc")
(global-set-key (kbd "C-o") 'toggle-input-method)

;;
;; 現在行のハイライト
;;
(defface my-hl-line-face
  ;; 背景色がdarkならば背景色を紺に
  '((((class color) (background dark))
	 (:background "NavyBlue" t))
	;; 背景色がlightならば背景色を緑に
	(((class color) (background light))
	  (:background "LightGreen" t))
	 (t (:bold t)))
	"hi-line's my face")
  (setq hl-line-face 'my-hl-line-face)
  (global-hl-line-mode t)

;;
;; 対応する括弧のハイライト
;;
;; paren-mode : 対応する括弧を強調して表示する
(setq show-paren-delay 0) ; 表示までの秒数。初期値は0.125
(show-paren-mode t) ; 有効化
;; parenのスタイル：expressionは括弧内も強調表示
(setq show-paren-style 'expression)
;; フェイスを変更する
;;(set-face-background 'show-paren-match-face nil)
;;(set-face-underline-p 'show-paren-match-face "yellow")

;;
;; バックアップファイルとオートセーブファイルを~/.emacs.d/backups/へ集める
;;
(add-to-list 'backup-directory-alist
			 (cons "." "~/.emacs.d/backups"))
(setq auto-save-file-name-transforms
	  `((".*" ,(expand-file-name "~/.emacs.d/backups/") t)))

;;
;; 初期画面を非表示
;;
(setq inhibit-startup-message t)

;;
;; Q&Aマクロ
;;
(fset 'q-and-a
   [?Q ?: ?  return ?A ?: ?  kp-enter])

;;
;; twittering-mode
;;
(require 'twittering-mode)
(setq twittering-use-master-password t)

;;
;; markdown-mode
;;
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))

;;
;; クリップボードにコピーを有効
;;
(cond (window-system
(setq x-select-enable-clipboard t)
))

;;
;; 文字コードをUTF-8に設定
;;
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)

;;
;; 端末を起動
;;
(define-key global-map (kbd "C-x C-t") 'ansi-term)

;;
;; リージョンを削除可能にする
;;
(delete-selection-mode t)

;;
;; 最近開いたファイルを表示
;;
(recentf-mode 1)
(setq recentf-max-menu-items 20)
(setq recentf-max-saved-items 100)
;; キーバインド設定
(define-key global-map (kbd "C-x C-r") 'recentf-open-files)
