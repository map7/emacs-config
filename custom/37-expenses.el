
;; Expenses plugin I'm working on
(require 'ht)

(setq expenses-utils-ignore-phrases-list '("TFR FROM"))

(setq expenses-utils-phrases-alist '(
                                     ("QUAD LOCK" . "Bike")
                                     ("A CLASS AUTOMOTIVE" . "Car")
                                     ("BUDGET DIRECT" . "Car")
				                             ("CORNER STORE" . "Coffee")
                                     ("COLES ONLINE" . "Food")
                                     ("GENERAL INS HOME" . "Home")
                                     ("1ST CHOICE" . "Grog")
                                     ("DAN MURPHY'S" . "Grog")
                                     ("FIRST CHOICE" . "Grog")
                                     ("AA SUNSHINE" . "Petrol")
                                     ("COLES EXPRESS" . "Petrol")
                                     ("WW METRO" . "Petrol")
                                     ("Triple R" . "Subscriptions")
                                     ("RS COMPONENTS" . "Electronics")
                                     ))

(setq expenses-utils-keyword-category-ht (ht
                                               ("BIKE" "Bike")
                                               ("CYCLES" "Bike")
                                               ("GOODCYCLES" "Bike")

                                               ("LINKT" "Car")
                                               ("VICROADS" "Car")

                                               ("BONDS" "Clothes")

                                               ("ALTRONIC" "Electronics")
                                               ("*CORE" "Electronics")
                                               ("*JAYCAR" "Electronics")
                                               ("*LITTLEBIRDE" "Electronics")
                                               ("MSY" "Electronics")
                                               ("*MWAVE" "Electronics")

                                               ("CINEMA" "Entertainment")
                                               ("MUSEUM" "Entertainment")
                                               ("MOVIE" "Entertainment")
                                               ("*STEAM" "Entertainment")
                                               ("YMCA" "Entertainment")
                                               ("ZOO" "Entertainment")

                                               ("FEE" "Fee")

                                               ("AUSPI" "Food")
                                               ("ALDI" "Food")
                                               ("BAKERY" "Food")
                                               ("CAFE" "Food")
                                               ("CATERING" "Food")
                                               ("DELI" "Food")
                                               ("GROCERY" "Food")
                                               ("EVERYPLATE" "Food")
                                               ("PHO" "Food")
                                               ("RAFO" "Food")
                                               ("MEATS" "Food")
                                               ("MENULOG" "Food")
                                               ("PIZZA" "Food")
                                               ("RESTAURANT" "Food")
                                               ("WOOLWORTHS" "Food")
                                               ("WORKERS" "Food")

                                               ("AMBULANCE" "Health")
                                               ("CHECKUP" "Health")
                                               ("CHEMIST" "Health")
                                               ("CLINIC" "Health")
                                               ("DR" "Health")
                                               ("HAIR" "Health")
                                               ("HIF" "Health")
                                               ("HEALTHLINE" "Health")
                                               ("HOSPITAL" "Health")
                                               ("GYSBERTS" "Health")
                                               ("MEDICAL" "Health")
                                               ("PHARMACY" "Health")
                                               ("PHARMACYSMART" "Health")
                                               ("PHYSIOTHERAP" "Health")

                                               ("BUNNINGS" "Home")
                                               ("DEFT" "Home")

                                               ("BWS" "Grog")
                                               ("CELLARS" "Grog")
                                               ("LIQUOR" "Grog")
                                               ("TAHBILK" "Grog")

                                               ("7-ELEVEN" "Petrol")
                                               ("BP" "Petrol")
                                               ("CALTEX" "Petrol")
                                               ("UNITED" "Petrol")
                                               ("AMPOL" "Petrol")

                                               ("GYM" "Sport")

                                               ("AUDIBLE" "Subscriptions")
                                               ("*CRAZYDOMAIN" "Subscriptions")
                                               ("*GOOGLEPAYME" "Subscriptions")
                                               ("FASTMAIL" "Subscriptions")
                                               ("NETFLIX" "Subscriptions")
                                               ("YOUTUBE" "Subscriptions")

                                               ("MYKI" "Travel")

                                               ("TFR" "Transfer")

                                               ("COUNCIL" "Utilities")
                                               ("POWERSHOP" "Utilities")
                                               ("WATER" "Utilities")
                                               ))
(add-to-list 'load-path "~/.emacs.d/external/expenses") ; Plugins not in the repo
(require 'expenses)
(setq expenses-directory "~/Sync/expenses/")
(setq expenses-currency "$")
(setq expenses-utils-auto-assign-categies-on-import t)

(setq expenses-bank-profiles '(("Westpac" "," 1 3 "dd/mm/yyyy" 2 -1)))

(setq expenses-category-list '("Bike" "Car" "Clothes" "Coffee" "Electronics" "Entertainment" "Fee" "Food" "Gift" "Grog" "Health" "Holiday" "Home" "Petrol" "Other" "Sport" "Subscriptions" "Travel" "Transfer" "Utilities"))
