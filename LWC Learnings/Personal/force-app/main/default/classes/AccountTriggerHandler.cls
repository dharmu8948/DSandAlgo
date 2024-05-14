public class AccountTriggerHandler {
    public static void updateAddress(List<Account> lstOfAccountRecords) {
        List<Account> lstOfAccount = new List<Account>();
         for(Account a : lstOfAccountRecords) {
           // if(a.BillingAddress != null) {
                if(a.BillingCity!=null){
                    a.ShippingCity=a.BillingCity;
                }
                if(a.BillingState!=null){
                    a.ShippingState=a.BillingState;
                }
                if(a.BillingPostalCode!=null){
                    a.ShippingPostalCode=a.BillingPostalCode;
                }
                if(a.BillingCountry!=null){
                    a.ShippingCountry=a.BillingCountry;
                }
               // lstOfAccount.add(new Account(Id = a.Id));
               System.debug('account info :  '+a);
          //  }
        }
       // update lstOfAccount;
    }
}