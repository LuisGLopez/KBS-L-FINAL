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
(defrule simple-buy 
	(smartphone (brandPhone ?brand) (modelPhone ?model) (colorPhone ?color) (pricePhone ?price))
	=>
	(printout t "A smartphone with the following characteristics: " ?brand " " ?model " for " ?price " pesos was proposed." crlf)
)
(defrule interest-free 
    (creditCard (cardIdCredit ?cardIdCredit) (maxLimitCredit ?maxLimitCredit) (companyCredit ?companyCredit))
    (smartphone (brandPhone ?brandPhone) (modelPhone ?modelPhone) (colorPhone ?colorPhone) (pricePhone ?pricePhone))
    (computer (brandPC ?brandPC) (modelPC ?modelPC) (colorPC ?colorPC) (pricePC ?pricePC))
    =>
    (printout t "Your proposed according to your current card company " ?companyCredit " allows you interest-free with your next buy " ?brandPhone " " ?modelPhone " and " ?brandPC " " ?modelPC crlf)   
)
(defrule credit-wholesale-phone
    (creditCard (cardIdCredit ?cardIdCredit) (maxLimitCredit ?maxLimitCredit) (companyCredit ?companyCredit))
    (smartphone (brandPhone ?brandPhone) (modelPhone ?modelPhone) (colorPhone ?colorPhone) (pricePhone ?pricePhone))
    =>
    (printout t "A 10% discount is proposed to you for only getting one " ?companyCredit crlf)
)