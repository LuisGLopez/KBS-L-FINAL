(defrule interest-free 
    (creditCard (cardIdCredit ?cardIdCredit) (maxLimitCredit ?maxLimitCredit) (companyCredit ?companyCredit))
    (smartphone (brandPhone ?brandPhone) (modelPhone ?modelPhone) (colorPhone ?colorPhone) (pricePhone ?pricePhone))
    (computer (brandPC ?brandPC) (modelPC ?modelPC) (colorPC ?colorPC) (pricePC ?pricePC))
    =>
    (printout t "Your current card company " ?companyCredit " allows you interest-free with your next buy " ?brandPhone " " ?modelPhone " and " ?brandPC " " ?modelPC crlf))   
)
(defrule credit-wholesale-phone
    (creditCard (cardIdCredit ?cardIdCredit) (maxLimitCredit ?maxLimitCredit) (companyCredit ?companyCredit))
    (smartphone (brandPhone ?brandPhone) (modelPhone ?modelPhone) (colorPhone ?colorPhone) (pricePhone ?pricePhone))
    =>
    (printout t "You'll get 10% discount for buying more than 2 smartphones with your " ?companyCredit crlf)
)