;; Setup modeline items
(defun gcs-propertized-evil-mode-tag ()
  (propertize evil-mode-line-tag 'font-lock-face
    ;; Don't propertize if we're not in the selected buffer
    (cond ((not (eq (current-buffer) (car (buffer-list)))) '())
          ((evil-normal-state-p)  '(:background "orange" :foreground "black"))
          ((evil-insert-state-p) '(:background "green" :foreground "black"))
          ((evil-emacs-state-p)  '(:background "red" :foreground "black"))
          ((evil-motion-state-p) '(:background "purple" :foreground "black"))
          ((evil-visual-state-p) '(:background "gray" :foreground "black"))
          (t '()))))

(setq-default mode-line-format
'("%e"
  (:eval
   (let* ((active (eq (frame-selected-window) (selected-window)))
          (face1 (if active 'powerline-active1 'powerline-inactive1))
          (face2 (if active 'powerline-active2 'powerline-inactive2))
          (lhs (list
                (powerline-raw "%*" nil 'l)
                (powerline-buffer-size nil 'l)
                (powerline-buffer-id nil 'l)

                (powerline-raw " ")
                (powerline-arrow-right nil face1)

                (powerline-major-mode face1 'l)
                (powerline-minor-modes face1 'l)
                (powerline-raw mode-line-process face1 'l)

                (powerline-narrow face1 'l)

                (powerline-arrow-right face1 face2)

                (powerline-vc face2)
                ))
          (rhs (list
                (powerline-raw global-mode-string face2 'r)

                (powerline-arrow-left face2 face1)

                (powerline-raw "%4l" face1 'r)
                (powerline-raw ":" face1)
                (powerline-raw "%3c" face1 'r)

                (powerline-arrow-left face1 nil)
                (powerline-raw " ")

                (powerline-raw "%6p" nil 'r)

                (powerline-hud face2 face1))))
     (concat
      (gcs-propertized-evil-mode-tag)
      (powerline-render lhs)
      (powerline-fill face2 (powerline-width rhs))
      (powerline-render rhs))))))
