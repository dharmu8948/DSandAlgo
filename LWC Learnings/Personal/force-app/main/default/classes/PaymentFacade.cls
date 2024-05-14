/**
 * @description       : Demonstration of Facade Design Pattern
 * @author            : Dharmendra Kumar
 * @group             : 
 * @last modified on  : 12-March-2024
 * @last modified by  : Dharmendra Kumar
**/
public with sharing class PaymentFacade {
    
    public static Boolean processPayment(String paymentType, String paymentSystem){
        
        if(paymentType == 'Credit Card'){
            IPaymentSystem payment = new CreditCardPayment();
            payment.processPayment();
        }else if (paymentType == 'Debit Card'){
            IPaymentSystem payment = new DebitCardPayment();
            payment.processPayment();
        }else if(paymentType == 'Net Banking'){
            System.debug('Net Banking');
        }else if(paymentType == 'PayPal'){
            System.debug('PayPal');
        }else{
            System.debug('Invalid Payment Type');
        }

        return True;
    }

    public static Boolean processRefund(String paymentType, String paymentSystem){
        return True;
    }
}