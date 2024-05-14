public class contactClass {
   
    public static void contactAmountUpdate(List <Contact> conList){
        Set<Id> accIds = new Set<Id>();
        for(Contact conid : conList ){
            accIds.add(conid.AccountId);
        }
        Map<Id, Decimal> mapForTotalAmount= new Map<Id,Decimal>();
        List<AggregateResult> sumOfAmount = new List<AggregateResult>([SELECT Accountid, SUM(Amount__c) sumamount FROM Contact WHERE AccountId IN :accIds GROUP BY AccountId]);
        for(AggregateResult arg : sumOfAmount){
            mapForTotalAmount.put((Id)arg.get('AccountId'),(Decimal)arg.get('sumamount'));
        }
        List<Account> accountTotalAmountUpdate = new List<Account>();
        for(Id accId:mapForTotalAmount.keySet()){
            Account accAmount = new Account(Id=accId, Total_Contacts_Amount__c = mapForTotalAmount.get(accId));
            accountTotalAmountUpdate.add(accAmount);
        }
        upsert(accountTotalAmountUpdate);
    }
   
   
     public static void contactAmountUpdateForDelete(List <Contact> oldList){
       System.debug('oldList::'+oldList);
        Set<Id> accOldIds = new Set<Id>();
        for(Contact conid : oldList ){
            accOldIds.add(conid.AccountId);
        }
       

        Map<Id, Decimal> mapForTotalAmount= new Map<Id,Decimal>();
        List<AggregateResult> sumOfAmount = new List<AggregateResult>([SELECT Accountid, SUM(Amount__c) sumamount FROM Contact WHERE AccountId IN :accOldIds GROUP BY AccountId]);
       
        for(AggregateResult arg : sumOfAmount){
           
            mapForTotalAmount.put((Id)arg.get('AccountId'),(Decimal)arg.get('sumamount'));
        }
       
        List<Account> accountTotalAmountUpdate = new List<Account>();
        for(Id accId:mapForTotalAmount.keySet()){
            Account accAmount = new Account(Id=accId, Total_Contacts_Amount__c = mapForTotalAmount.get(accId));
            accountTotalAmountUpdate.add(accAmount);
        }
        upsert(accountTotalAmountUpdate);
    }
   
   

       
    }