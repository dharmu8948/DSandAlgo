/**
 * @description       : Demonstration of Facade Design Pattern
 * @author            : Dharmendra Kumar
 * @group             : 
 * @last modified on  : 12-March-2024
 * @last modified by  : Dharmendra Kumar
**/
public with sharing class ShopingCart {

    //List<Product2> products;
    //public String paymentType;

    public Boolean processPayment(String paymentType, String paymentSystem){
        Boolean isProcesed = PaymentFacade.processPayment(paymentType, paymentSystem);
        return True;
    }

}