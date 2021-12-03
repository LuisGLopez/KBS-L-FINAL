(deftemplate smartphone
	(slot brandPhone)
	(slot modelPhone)
	(slot colorPhone)
	(slot pricePhone)
)
(deftemplate computer
	(slot brandPC)
	(slot modelPC)
	(slot colorPC)
	(slot pricePC)
)
(deftemplate debitCard
	(slot cardIdDebit)
	(slot maxLimitDebit)
	(slot companyDebit)
)
(deftemplate creditCard
	(slot cardIdCredit)
	(slot maxLimitCredit)
	(slot companyCredit)
)
(defrule simple-buy-pc
    (computer (brandPC ?brand) (modelPC ?model) (colorPC ?color) (pricePC ?price))
	=>
	(printout t "A computer with the following characteristics: " ?brand " " ?model " for " ?price " pesos was proposed." crlf)
)