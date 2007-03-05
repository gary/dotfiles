;; look and feel
(setq initial-frame-alist '(
			    (mouse-color      . "midnightblue")
			    (foreground-color . "midnightblue")
			    (background-color . "antiquewhite1")
			    ;; (font . "-*-*-medium-r-normal--10-*-*-*-*-*-fontset-hiraginomin")
			    (top . 10) (left . 650) (width . 123) (height . 60))
      )

(setq default-frame-alist '(
		      (background-color     . "ghost white")
		      (foreground-color     . "grey10")
		      (cursor-color         . "purple")
		      (cursor-type          . box)
		      (vertical-scroll-bars . left)
		      (active-alpha         . 0.875)
		      (inactive-alpha       . 0.75)
		      ;; (font . "-*-*-medium-r-normal--9-*-*-*-*-*-fontset-hiraginokaku")
		      (top . 20) (left . 150) (width . 89) (height . 56))
      )

;; aquamacs
(if (boundp 'aquamacs-version)
    ((setq one-buffer-one-frame-mode nil)
     (setq cua-mode 0)))
  
;; jdee
(setq jde-global-classpath (quote ("/System/Library/Frameworks/JavaVM.framework/Versions/1.5.0/"
				   "/opt/blackboard/b2/shared/bbjars/6.3/"
				   "/opt/blackboard/b2/shared/bbjars/hibernatedeps/"
				   "/opt/blackboard/b2/shared/bbjars/jstl/"
				   "/opt/blackboard/b2/shared/bbjars/logging/"
				   "/opt/blackboard/b2/shared/bbjars/muohio/")))
(setq jde-jdk-registry (quote (("1.5.0" . "/System/Library/Frameworks/JavaVM.framework/Versions/1.5.0")
			       ("1.4.2" . "/System/Library/Frameworks/JavaVM.framework/Versions/1.4.2")
			       ("1.3.1" . "/System/Library/Frameworks/JavaVM.framework/Versions/1.3.1"))))
(setq jde-jdk nil)
(setq jde-compiler (quote ("javac" "")))
(setq jde-jdk-doc-url "http://java.sun.com/j2se/1.5.0/docs/api")
(setq jde-complete-function (quote jde-complete-minibuf))
(setq jde-enable-abbrev-mode t)
(setq jde-ant-home "/Developer/Java/bin")
(setq jde-ant-program "ant")
