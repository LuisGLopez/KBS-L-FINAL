(deftemplate book
    (multislot surname)(slot name)(multislot title)
)

(deffacts initial
    (book (surname J.P.)(name Dubreuil)(title History of francmasons))
    (book (surname T.)(name Eker)(title Secrets of millionare mind))
)

(defrule find 
    ?book<-(book(name Eker))
    =>
    (printout t ?book crlf)
)