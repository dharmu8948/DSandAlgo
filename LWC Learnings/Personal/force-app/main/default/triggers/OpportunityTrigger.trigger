trigger OpportunityTrigger on Opportunity (after insert, after update, after delete) {
    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)) {
        //OpportunityTriggerHelper.updateAccountDesc(Trigger.New, Trigger.OldMap);
        Set<Id> accIds = new Set<Id>();
        
        Map<Id, Account> accMap = new Map<Id, Account>();
        
        if (Trigger.isInsert) {
            
            for (Opportunity opp : Trigger.new) {
                
                accIds.add(opp.AccountId);
                
            }
            
        }
        
        if (Trigger.isUpdate || Trigger.isDelete) {
            
            for (Opportunity opp : Trigger.old) {
                
                accIds.add(opp.AccountId);
                
            }
            
        }
        
        for (Account acc : [SELECT Id, Description, 
                            
                            (SELECT Id, Amount, Name FROM Opportunities ORDER BY Amount DESC LIMIT 1)
                            
                            FROM Account WHERE Id IN :accIds]) {
                                
                                accMap.put(acc.Id, acc);
                                
                            }
        
        Map<Id,Account> accUpdateMap = new Map<Id,Account>();
        
        for (Opportunity opp : Trigger.new) {
            
            Account acc = accMap.get(opp.AccountId);
            
            if (acc != null && acc.Opportunities.size() > 0) {
                
                acc.Description = String.valueOf(acc.Opportunities[0].Amount);
                
                accUpdateMap.put(acc.Id, acc);
                
            }
            
        }
        
        for (Opportunity opp : Trigger.old) {
            
            Account acc = accMap.get(opp.AccountId);
            
            if (acc != null && acc.Opportunities.size() > 0) {
                
                acc.Description = String.valueOf(acc.Opportunities[0].Amount);
                
                accUpdateMap.put(acc.Id, acc);
                
            }
        }
        if (accUpdateMap.size() > 0) {
            
            update accUpdateMap.values();
        }
        
    }
    /*  else if(Trigger.isAfter && Trigger.isDelete) {
OpportunityTriggerHelper.updateAccountDesc(Trigger.Old, Trigger.OldMap);
} */
}