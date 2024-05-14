/**
 * @description       : Demonstration of Facade Design Pattern
 * @author            : Dharmendra Kumar
 * @group             : 
 * @last modified on  : 12-March-2024
 * @last modified by  : Dharmendra Kumar
**/
public with sharing class CreditCardPayment implements IPaymentSystem {
    
    public void processPayment(){
        System.debug('Processing Payment');
        // Do something
    }

    public void processRefund(){
        System.debug('Procesing Refund');
    }
}