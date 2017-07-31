(setq 4gl-keywords
	  `(

		("\\s." . font-lock-type-face)
		("\\s(\\|\\s)" . font-lock-builtin-face)
		("^REPORT .*(\\(.*\\))" (1 font-lock-variable-name-face))
		("^FUNCTION .*(\\(.*\\))" (1 font-lock-variable-name-face))
		("LET \\(\\sw+\\)" (1 font-lock-variable-name-face))
		("REPORT \\(\\sw+\\)(" (1 font-lock-function-name-face))
		("FUNCTION \\(\\sw+\\)(" (1 font-lock-function-name-face))
		(, (regexp-opt (split-string "ABORT ABS ABSOLUTE ACCEPT ACCESS ACOS ADD AFTER ALL SFMT
ALLOCATE ALTER AND ANSI ANY APPEND ARG_VAL ARRAY ARR_COUNT
ARR_CURR AS ASC ASCENDING ASCII ASIN AT ATAN ATAN2 ATTACH
ATTRIBUTE ATTRIBUTES AUDIT AUTHORIZATION AUTO AUTONEXT AVERAGE AVG
BEFORE BEGIN BETWEEN BLACK BLINK BLUE BOLD BORDER BOTH BOTTOM
BREAK BUFFERED BY BYTE
CALL CASCADE CASE CHAR CHARACTER CHARACTER_LENGTH CHAR_LENGTH
CHECK CLASS_ORIGIN CLEAR CLIPPED CLOSE CLUSTER COLOR
COLUMN COLUMNS COMMAND COMMENT COMMENTS COMMIT COMMITTED
COMPOSITES COMPRESS CONCURRENT CONNECT CONNECTION
CONNECTION_ALIAS CONSTRAINED CONSTRAINT CONSTRAINTS CONSTRUCT
CONTINUE CONTROL COS COUNT CREATE CURRENT CURSOR CYAN
DATA DATABASE DATASKIP DATE DATETIME DAY DBA DBINFO DBSERVERNAME
DEALLOCATE DEBUG DEC DECIMAL DECLARE DEFAULT DEFAULTS DEFER
DEFERRED DEFINE DELETE DELIMITER DELIMITERS DESC DESCENDING
DESCRIBE DESCRIPTOR DETACH DIAGNOSTICS DIM DIRTY DISABLED
DISCONNECT DISPLAY DISTINCT DISTRIBUTIONS DO DORMANT DOUBLE
DOWN DOWNSHIFT DROP
EACH ELIF ELSE ENABLED END ENTRY ERROR ERRORLOG ERR_GET
ERR_PRINT ERR_QUIT ESC ESCAPE EVERY EXCEPTION EXCLUSIVE
EXEC EXECUTE EXISTS EXIT EXP EXPLAIN EXPRESSION EXTEND EXTENT
EXTERN EXTERNAL
F1 F10 F11 F12 F13 F14 F15 F16 F17 F18 F19 F2 F20 F21 F22 F23
F24 F25 F26 F27 F28 F29 F3 F30 F31 F32 F33 F34 F35 F36 F37 F38
F39 F4 F40 F41 F42 F43 F44 F45 F46 F47 F48 F49 F5 F50 F51 F52
F53 F54 F55 F56 F57 F58 F59 F6 F60 F61 F62 F63 F64 F7 F8 F9
FALSE FETCH FGL_GETENV FGL_KEYVAL FGL_LASTKEY FIELD FIELD_TOUCHED
FILE FILLFACTOR FILTERING FINISH FIRST FLOAT FLUSH FOR
FOREACH FOREIGN FORM FORMAT FORMONLY FORTRAN FOUND FRACTION
FRAGMENT FREE FROM FUNCTION GET_FLDBUF GLOBAL GLOBALS GO GOTO
GRANT GREEN GROUP HAVING HEADER HELP HEX HIDE HIGH HOLD HOUR
IDATA IF ILENGTH IMMEDIATE IN INCLUDE INDEX INDEXES INDICATOR
INFIELD INIT INITIALIZE INPUT INSERT INSTRUCTIONS INT INTEGER
INTERRUPT INTERVAL INTO INT_FLAG INVISIBLE IS ISAM ISOLATION
ITYPE
KEY LABEL
LANGUAGE LAST LEADING LEFT LENGTH LET LIKE LINE
LINENO LINES LOAD LOCATE LOCK LOG LOG10 LOGN LONG LOW
MAGENTA MAIN MARGIN MATCHES MAX MDY MEDIUM MEMORY MENU MESSAGE
MESSAGE_LENGTH MESSAGE_TEXT MIN MINUTE MOD MODE MODIFY MODULE
MONEY MONTH MORE
NAME NCHAR NEED NEW NEXT NEXTPAGE NO NOCR NOENTRY NONE NORMAL
NOT NOTFOUND NULL NULLABLE NUMBER NUMERIC NUM_ARGS NVARCHAR
OCTET_LENGTH OF OFF OLD ON ONLY OPEN OPTIMIZATION OPTION OPTIONS
OR ORDER OTHERWISE OUTER OUTPUT
PAGE PAGENO PAUSE PDQPRIORITY PERCENT PICTURE PIPE POW PRECISION
PREPARE PREVIOUS PREVPAGE PRIMARY PRINT PRINTER PRIOR PRIVATE
PRIVILEGES PROCEDURE PROGRAM PROMPT PUBLIC PUT
QUIT QUIT_FLAG
RAISE RANGE READ READONLY REAL RECORD RECOVER RED REFERENCES
REFERENCING REGISTER RELATIVE REMAINDER REMOVE RENAME REOPTIMIZATION
REPEATABLE REPORT REQUIRED RESOLUTION RESOURCE RESTRICT
RESUME RETURN RETURNED_SQLSTATE RETURNING REVERSE REVOKE RIGHT
ROBIN ROLE ROLLBACK ROLLFORWARD ROOT ROUND ROW ROWID ROWIDS
ROWS ROW_COUNT RUN
SCALE SCHEMA SCREEN SCROLL SCR_LINE SECOND SECTION SELECT
SERIAL SERIALIZABLE SERVER_NAME SESSION SET SET_COUNT SHARE
SHORT SHOW SITENAME SIZE SIZEOF SKIP SLEEP SMALLFLOAT SMALLINT
SOME SPACE SPACES SQL SQLAWARN SQLCA SQLCODE SQLERRD SQLERRM
SQLERROR SQLERRP SQLSTATE SQLWARNING SQRT STABILITY START
STARTLOG STATIC STATISTICS STATUS STDEV STEP STOP STRING STRUCT
SUBCLASS_ORIGIN SUM SWITCH SYNONYM SYSTEM
SysBlobs SysChecks SysColAuth SysColDepend SysColumns
SysConstraints SysDefaults SysDepend SysDistrib SysFragAuth
SysFragments SysIndexes SysObjState SysOpClstr SysProcAuth
SysProcBody SysProcPlan SysProcedures SysReferences SysRoleAuth
SysSynTable SysSynonyms SysTabAuth SysTables SysTrigBody
SysTriggers SysUsers SysViews SysViolations
TAB TABLE TABLES TAN TEMP TEXT THEN THROUGH THRU TIME TO
TODAY TOP TOTAL TRACE TRAILER TRAILING TRANSACTION TRIGGER
TRIGGERS TRIM TRUE TRUNC TYPE TYPEDEF
UNCOMMITTED UNCONSTRAINED UNDERLINE UNION UNIQUE UNITS UNLOAD
UNLOCK UNSIGNED UP UPDATE UPSHIFT USER USING
VALIDATE VALUE VALUES VARCHAR VARIABLES VARIANCE VARYING
VERIFY VIEW VIOLATIONS
WAIT WAITING WARNING WEEKDAY WHEN WHENEVER WHERE WHILE WHITE
WINDOW WITH WITHOUT WORDWRAP WORK WRAP WRITE
YEAR YELLOW
ZEROFILL")'words ) . font-lock-keyword-face)
		;;(,(regex-opt (split-string "   ") 'word) . font-lock-face)
	  ))


(setq 4gl-mode-syntax-table
      (let ((synTable (make-syntax-table)))
		(modify-syntax-entry ?\(  "()" synTable)
		(modify-syntax-entry ?\)  ")(" synTable)
		(modify-syntax-entry ?\_  "w" synTable)
		(modify-syntax-entry ?\'  "\"" synTable)
		(modify-syntax-entry ?\"  "\"" synTable)
		
		(modify-syntax-entry ?+  "." synTable)
		(modify-syntax-entry ?-  "." synTable)
		(modify-syntax-entry ?%  "." synTable)
		(modify-syntax-entry ?&  "." synTable)
		(modify-syntax-entry ?|  "." synTable)
		(modify-syntax-entry ?^  "." synTable)
		(modify-syntax-entry ?!  "." synTable)
		(modify-syntax-entry ?=  "." synTable)
		(modify-syntax-entry ?<  "." synTable)
		(modify-syntax-entry ?>  "." synTable)		
		;; {         } as multi-line comments
		(modify-syntax-entry ?\{  "< 1n" synTable)
		(modify-syntax-entry ?\}  "> 4n" synTable)

		;; # python style comments
        (modify-syntax-entry ?# "< b" synTable)
        (modify-syntax-entry ?\n "> b " synTable)

		;; -- SQL style comments
		;; also uses the new line comment ender above
		(modify-syntax-entry ?\- ". 12b" synTable) 

        synTable))



(defun regexp-current-linep (regexp)
  (let ((line-number -1))
	(save-excursion
	  (move-beginning-of-line nil)
	  (ignore-errors 
		(search-forward-regexp regexp)
		(setq line-number (line-number-at-pos)))
	  )
	(= (line-number-at-pos) line-number)))

(defun regexp-backward-col-number (regexp)
  (let ((col-number nil))
	(save-excursion
	  (move-beginning-of-line nil)
	  (search-backward-regexp regexp)
	  (forward-word)(backward-word)
	  (setq col-number (current-column))
	  )
	col-number))
(defun regexp-backward-line-number (regexp)
  (let ((line-number -1))
	(ignore-errors
	  (save-excursion
		(move-beginning-of-line nil)
		(search-backward-regexp regexp)
		(setq line-number (line-number-at-pos))))
	line-number))

(defun 4gl-indent ()
"Going to search backwards for an open(indenting) statement
n and compare it with a closing statement. 
 Indent appropriately to whichever appears first
"
  (let ((open-col 0)
		(open-line-number -1)
		(close-col 0)
		(close-line-number -1)
		(forward-end-line-number -1)
		)
	(save-excursion
	  (move-beginning-of-line nil)
	  (search-forward-regexp "^\\s-*END ")
	  (setq forward-end-line-number (line-number-at-pos))
	  )
	(save-excursion
	  (ignore-errors
		(search-backward-regexp "^\\s-*\\(IF \\|MAIN\\|TYPE\\|FUNCTION\\|REPORT\\|CONSTRUCT\\|DIALOG\\|INPUT\\|FOREACH\\|ON\\s-\\|FORMAT\\|BEFORE\\|AFTER\\|ELSE\\)")

		(forward-word)(backward-word)
		(setq open-col (+ (current-column) 4))
		(setq open-line-number (line-number-at-pos))	  
		)
	  )	
	(save-excursion
	  (ignore-errors
		(search-backward-regexp "^\\s-*\\(END \\)")
		(forward-word)(backward-word)
		(setq close-col (+ (current-column) 0))
		(setq close-line-number (line-number-at-pos))	  	  
		)
	  )
	(indent-line-to
	 (cond ((regexp-current-linep "^\\s-*END IF") (regexp-backward-col-number "^\\s-*IF"))
		   ((regexp-current-linep "^\\s-*END MAIN") (regexp-backward-col-number "^\\s-*MAIN"))
		   ((regexp-current-linep "^\\s-*ELSE") (regexp-backward-col-number "^\\s-*IF"))
		   ((regexp-current-linep "^\\s-*END TYPE") (regexp-backward-col-number "^\\s-*TYPE"))
		   ((regexp-current-linep "^\\s-*END INPUT") (regexp-backward-col-number "^\\s-*INPUT"))
		   ((regexp-current-linep "^\\s-*END DIALOG") (regexp-backward-col-number "^\\s-*DIALOG"))
		   ((regexp-current-linep "^\\s-*END CONSTRUCT") (regexp-backward-col-number "^\\s-*CONSTRUCT"))
		   ((regexp-current-linep "^\\s-*END FOREACH") (regexp-backward-col-number "^\\s-*FOREACH"))
		   ((regexp-current-linep "^\\s-*END FUNCTION") 0)
		   ((regexp-current-linep "^\\s-*END REPORT") 0)
		   ((regexp-current-linep "^\\s-*\\(FORMAT\\|OUTPUT\\|ORDER \\|FIRST\\|ON EVERY\\|AFTER GROUP\\|BEFORE GROUP\\|ON LAST \\|PAGE \\)")
			(+ (regexp-backward-col-number "^\\s-*REPORT ") 4))
		   ((regexp-current-linep "^\\s-*\\(ON\\|AFTER\\|BEFORE\\)")
			(+ (regexp-backward-col-number "^\\s-*\\(INPUT\\|CONSTRUCT\\|DIALOG\\)") 4))
;;		   ((> (regexp-backward-line-number "^.*RECORD") open-col ) (+ 4(regexp-backward-col-number "^.*RECORD")))
		   ((> open-line-number close-line-number) open-col )
		   ((< open-line-number close-line-number) close-col )
		   
		  )
	 )

	;; (indent-line-to (if (> open-line-number close-line-number)
	;; 					open-col
	;; 				  close-col	))

	))


(define-derived-mode 4gl-mode text-mode
  :syntax-table 4gl-mode-syntax-table
  (setq mode-name "4gl")
  (setq font-lock-defaults '(4gl-keywords))
  (setq comment-start "# ")
  (setq comment-end "")
  (set-syntax-table 4gl-mode-syntax-table)
  (setq tab-width 4)
  (electric-indent-mode 1)
  (setq indent-line-function '4gl-indent)
  (setq indent-tabs-mode t)
  )

(add-to-list 'auto-mode-alist '("\\.4gl\\'" . 4gl-mode))

(provide '4gl-mode)
