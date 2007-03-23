;; TODO: speedbar info (require 'sb-info)? breaking info startup
;; initialize CEDET
(load-library "cedet")

;; jde-mode
;; overkill, plan on always autoloading
(setq defer-loading-jde t)
(if defer-loading-jde
    (progn
      (autoload 'jde-mode "jde" "JDE mode." t)
      (setq auto-mode-alist
	    (append
	     '(("\\.java\\'" . jde-mode))
	     auto-mode-alist)))
  (require 'jde))

(add-hook 'jde-mode-hook
	  '(lambda ()
	     ;; (setq jde-setnu-mode-enable t)
	     (c-subword-mode)
	     (c-toggle-auto-hungry-state)))

(setq jde-gen-k&r t)
(setq jde-enable-abbrev-mode t)

(setq jde-jdk-registry (quote (("1.5.0" . "/System/Library/Frameworks/JavaVM.framework/Versions/1.5.0")
			       ("1.4.2" . "/System/Library/Frameworks/JavaVM.framework/Versions/1.4.2")
			       ("1.3.1" . "/System/Library/Frameworks/JavaVM.framework/Versions/1.3.1"))))
(setq jde-jdk nil)
(setq jde-jdk-doc-url "http://java.sun.com/j2se/1.5.0/docs/api")
(setq jde-help-docsets (quote (("User (javadoc)" "http://java.sun.com/j2se/1.5.0/docs/api/" nil)
			       ("User (javadoc)" "http://library.blackboard.com/docs/r6/6_1/sdk/b2api/" nil)
			       ("User (javadoc)" "http://java.sun.com/javaee/5/docs/api/" nil))))

(setq jde-compiler (quote ("javac" "")))
(setq jde-complete-function (quote jde-complete-minibuf))

(setq bsh-jar (concat emacs-root "/site-lisp/jde-2.3.5.1/java/lib/bsh.jar"))

(setq jde-ant-home "/usr/bin")
(setq jde-ant-program "ant")
;; default for blackboard projects and all the targets they entail
(setq jde-ant-read-target t)
(setq jde-ant-complete-target t)
(setq jde-ant-enable-find t)		;; recurse up the hierarchy, find the buildfile

;; (setq jde-browse-function 'w3m-browse-url)

;; blackboard development
;; TODO: recursive directory search in jde-global-classpath?  no worky
;; (setq muoh-blackboard-63 (quote ("/opt/blackboard/b2/shared/bbjars/6.3/"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/activation.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/ant-launcher.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/ant.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/bb-assessment.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/bb-bbxythos-install.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/bb-bbxythos.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/bb-bridge.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/bb-castor.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/bb-chalkbox.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/bb-chat-client.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/bb-client.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/bb-cms-admin.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/bb-cms-taglib.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/bb-collab-client.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/bb-collab-platform.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/bb-collab-server.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/bb-content-exchange.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/bb-encryption.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/bb-jldap.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/bb-openldap.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/bb-platform.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/bb-qti.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/bb-snapshot.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/bb-taglibs.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/bb-tomcatboot.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/bb-vc-client.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/bb-webcas-castor.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/bb-webcas.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/bb-wizard.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/bb-xythoswebui.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/bcprov-jdk14-124.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/catalina-optional.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/catalina.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/CcxClientApi.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/classes12.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/commons-beanutils.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/commons-codec-1.3.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/commons-collections-2.1.1.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/commons-collections-3.1.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/commons-dbcp-1.2.1.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/commons-digester.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/commons-el.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/commons-modeler.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/commons-pool-1.2.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/gnu-getopt-1.0.8.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/gnu-regexp-1.0.8.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/jade.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/jakarta-regexp-1.1.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/jasper-compiler.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/jasper-runtime.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/jcert-1.0.2.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/jlansrv.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/jmx.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/jnet-1.0.2.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/jsp-api.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/jsse-1.0.2.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/jta.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/log4j.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/lucene-1.3.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/lucene-demos-1.3.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/mail.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/minerva.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/naming-common.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/naming-factory.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/naming-java.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/naming-resources.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/ojdbc14.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/Opta2000.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/PDFBox-0.6.4.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/poi-2.0.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/poi-contrib-2.0.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/poi-scratchpad-2.0.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/servlet-api.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/servlets-common.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/servlets-default.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/servlets-invoker.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/soap.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/tomcat-coyote.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/tomcat-jk.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/tomcat-jk2.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/tomcat-util.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/webeq36.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/xss.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/xsscore.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/xssdb2.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/xssmssql.jar"
;; 				 "/opt/blackboard/b2/shared/bbjars/6.3/xssoracle.jar")))

;; (setq muoh-hibernate-deps (quote ("/opt/blackboard/b2/shared/bbjars/hibernatedeps/antlr-2.7.6rc1.jar"
;; 				  "/opt/blackboard/b2/shared/bbjars/hibernatedeps/asm-attrs.jar"
;; 				  "/opt/blackboard/b2/shared/bbjars/hibernatedeps/asm.jar"
;; 				  "/opt/blackboard/b2/shared/bbjars/hibernatedeps/c3p0-0.9.0.jar"
;; 				  "/opt/blackboard/b2/shared/bbjars/hibernatedeps/cglib-2.1.3.jar"
;; 				  "/opt/blackboard/b2/shared/bbjars/hibernatedeps/cleanimports.jar"
;; 				  "/opt/blackboard/b2/shared/bbjars/hibernatedeps/commons-collections-2.1.1.jar"
;; 				  "/opt/blackboard/b2/shared/bbjars/hibernatedeps/concurrent-1.3.2.jar"
;; 				  "/opt/blackboard/b2/shared/bbjars/hibernatedeps/connector.jar"
;; 				  "/opt/blackboard/b2/shared/bbjars/hibernatedeps/dom4j-1.6.1.jar"
;; 				  "/opt/blackboard/b2/shared/bbjars/hibernatedeps/ehcache-1.1.jar"
;; 				  "/opt/blackboard/b2/shared/bbjars/hibernatedeps/ejb3-persistence.jar"
;; 				  "/opt/blackboard/b2/shared/bbjars/hibernatedeps/jaas.jar"
;; 				  "/opt/blackboard/b2/shared/bbjars/hibernatedeps/jacc-1_0-fr.jar"
;; 				  "/opt/blackboard/b2/shared/bbjars/hibernatedeps/jaxen-1.1-beta-7.jar"
;; 				  "/opt/blackboard/b2/shared/bbjars/hibernatedeps/jgroups-2.2.8.jar"
;; 				  "/opt/blackboard/b2/shared/bbjars/hibernatedeps/jta.jar"
;; 				  "/opt/blackboard/b2/shared/bbjars/hibernatedeps/junit-3.8.1.jar"
;; 				  "/opt/blackboard/b2/shared/bbjars/hibernatedeps/oscache-2.1.jar"
;; 				  "/opt/blackboard/b2/shared/bbjars/hibernatedeps/proxool-0.8.3.jar"
;; 				  "/opt/blackboard/b2/shared/bbjars/hibernatedeps/swarmcache-1.0rc2.jar"
;; 				  "/opt/blackboard/b2/shared/bbjars/hibernatedeps/syndiag2.jar")))

;; (setq muoh-logging (quote ("/opt/blackboard/b2/shared/bbjars/logging/log4j-1.2.13.jar"
;; 			   "/opt/blackboard/b2/shared/bbjars/logging/commons-logging-1.0.5.a.jar"
;; 			   "/opt/blackboard/b2/shared/bbjars/logging/commons-logging-optional-1.0.5a.jar")))

;; (setq muoh-jstl (quote ("/opt/blackboard/b2/shared/bbjars/jstl/jstl.jar"
;; 			"/opt/blackboard/b2/shared/bbjars/jstl/standard.jar")))

;; (setq muoh-muohio "/opt/blackboard/b2/shared/bbjars/muohio/muohio_external.jar")
;; end blackboard development

;; bash as default shell, beware the zsh
(setq shell-file-name "bash")
(setq shell-command-switch "-c")
(setq explicit-shell-file-name shell-file-name)
(setenv "SHELL" shell-file-name)
(setq explicit-sh-args '("-login" "-i"))
