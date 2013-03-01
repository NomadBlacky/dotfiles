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

