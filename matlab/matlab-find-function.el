;;
;; Use IVY to find function definition in MATLAB
;; Add this script to your .emacs configuration file
;;
(defun re-seq (regexp string)
  "Get a list of all regexp matches in a string"
  (save-match-data
    (let ((pos 0)
          matches)
      (while (string-match regexp string pos)
        (push (match-string 0 string) matches)
        (setq pos (match-end 0)))
      matches)))

(defun matlab-find-function ()
  "Find all functions definitions in current MATLAB file."
  (interactive)
  (ivy-read "MATLAB functions: "
	    (reverse (re-seq "^\\s-*function.*$\\|^\\s-*%%.*$" (buffer-string)))
	    :action (lambda (x)
		      (with-current-buffer
			  (progn
			    (beginning-of-buffer)
			    (search-forward-regexp x))))))
(defun matlab-find-function-config ()
  "For use in `matlab-mode-hook'."
  (local-set-key (kbd "C-c f") 'matlab-find-function)
  (local-set-key (kbd "C-c C-f") 'matlab-find-function)
  ;; more here
  )
(add-hook 'matlab-mode-hook 'matlab-find-function-config)
