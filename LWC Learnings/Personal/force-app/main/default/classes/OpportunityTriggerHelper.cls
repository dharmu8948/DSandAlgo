public class OpportunityTriggerHelper {
    public static void updateAccountDesc(List<Opportunity> oppList, Map<Id, Opportunity> oppMap) {
        List<Account> accList = new List<Account>();
        Map<String, Decimal> mpOfIdVsAmount = new Map<String, Decimal>();
        System.debug('mpOfIdVsAmount::'+oppList+'  oppMap::'+oppMap);
        if(!oppList.isEmpty()) {
           Opportunity lstOfOpps = [Select Id, AccountId, Amount FROM Opportunity Order BY Amount DESC];
            for(Opportunity opp : oppList) {
                if(opp.Amount != null && (oppMap == null || oppMap.get(opp.Id).Amount != opp.Amount)) {
                    if(mpOfIdVsAmount.containsKey(opp.AccountId)) {
                       // Decimal value = Math.max(opp.AccountId.Description)
                       mpOfIdVsAmount.put(opp.AccountId, Math.max(mpOfIdVsAmount.get(opp.AccountId), opp.Amount)); 
                    }else {
                        mpOfIdVsAmount.put(opp.AccountId, opp.Amount);
                    }
                }
            }
        }
        System.debug('mpOfIdVsAmount::'+mpOfIdVsAmount);
        if(!mpOfIdVsAmount.isEmpty()) {
        //    List<Opportunity> oppListInDB = [Select Id,AccounId,Amount FROM Opportunity WHERE AccountId IN:mpOfIdVsAmount.keySet()];
        //    if(!oppListInDB.isEmpty()) {
                for(String  accId : mpOfIdVsAmount.keySet()) {
                Account acc = new Account();
                acc.Id = accId;
                acc.Description = String.valueOf(mpOfIdVsAmount.get(accId));
                accList.add(acc);
           // }
            }
        }
        System.debug('accList::'+accList);
        if(!accList.isEmpty()) {
            update accList;
        }
    }
}