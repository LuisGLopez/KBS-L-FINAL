

(defrule cust-not-buying
     (customer (customer-id ?id) (name ?name))
     (not (order (order-number ?order) (customer-id ?id)))
   =>
   (printout t ?name " no ha comprado... nada!" crlf))




(defrule prods-bought
   (order (order-number ?order))
   (line-item (order-number ?order) (part-number ?part))
   (product (part-number ?part) (name ?pn))
   =>
   (printout t ?pn " was bought " crlf))



(defrule prods-qty-bgt
   (order (order-number ?order))
   (line-item (order-number ?order) (part-number ?part) (quantity ?q))
   (product (part-number ?part) (name ?p) )
   =>
   (printout t ?q " " ?p " was/were bought " crlf))


(defrule customer-shopping
   (customer (customer-id ?id) (name ?cn))
   (order (order-number ?order) (customer-id ?id))
   (line-item (order-number ?order) (part-number ?part))
   (product (part-number ?part) (name ?pn))
   =>
   (printout t ?cn " bought  " ?pn crlf))


(defrule cust-5-prods
   (customer (customer-id ?id) (name ?cn))
   (order (order-number ?order) (customer-id ?id))
   (line-item (order-number ?order) (part-number ?part))
   (product (part-number ?part) (name ?pn))
   =>
   (printout t ?cn " bought more than 5 products (" ?pn ")" crlf))


(defrule text-cust (customer (customer-id ?cid) (name ?name) (phone ?phone))
                   (not (order (order-number ?order) (customer-id ?cid)))
=>
(assert (text-customer ?name ?phone "tienes 25% desc prox compra"))
(printout t ?name " 3313073905 tienes 25% desc prox compra" ))


(defrule call-cust (customer (customer-id ?cid) (name ?name) (phone ?phone))
                   (not (order (order-number ?order) (customer-id ?cid)))
=>
(assert (call-customer ?name ?phone "tienes 25% desc prox compra"))
(printout t ?name " 3313073905 tienes 25% desc prox compra" ))

///////////////////////////////////////////////////////////////////////////////
(deffacts smartphones
    (smartphone (brand "Apple") (model "iPhone 6s") (color "Silver") (price "12000"))
    (smartphone (brand "Apple") (model "iPhone 13") (color "White") (price "31000"))
    (smartphone (brand "Apple") (model "iPhone 11") (color "Black") (price "20000"))
    (smartphone (brand "Samsung") (model "Galaxy S10") (color "Black") (price "25000"))
    (smartphone (brand "Samsung") (model "Galaxy S21") (color "White") (price "30000"))
)

(deffacts computers
    (computer (brand "Apple") (model "Macbook Pro") (color "Silver") (price "50000"))
    (computer (brand "Apple") (model "Macbook Air") (color "Silver") (price "40000"))
    (computer (brand "Lenovo") (model "Thinkpad") (color "Silver") (price "30000"))
    (computer (brand "Lenovo") (model "Thinkpad X1") (color "Silver") (price "20000"))
    (computer (brand "Dell") (model "XPS") (color "Silver") (price "40000"))
)

(deffacts cards
    (card (type "Debit") (company "Visa"))
    (card (type "Credit") (company "MasterCard"))
    (card (type "Credit") (company "AmericanExpress"))
    (card (type "Debit") (company "MasterCard"))
)

(deffacts orders
    (order (device "smartphone") (brand "Apple") (model "iPhone 11") (color "Black") (price "20000"))
    (order (device "smartphone") (brand "Apple") (model "iPhone 13") (color "White") (price "31000"))
)

