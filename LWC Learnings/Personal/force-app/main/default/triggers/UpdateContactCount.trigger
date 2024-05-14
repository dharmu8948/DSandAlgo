//On account field have total contact field add counts of related contact
trigger UpdateContactCount on Contact (after insert, after update, after delete) {
    Set<Id> accountIds = new Set<Id>();
    
    if (Trigger.isInsert || Trigger.isUpdate) {
        for (Contact con : Trigger.new) {
            if (con.AccountId != null) {
                accountIds.add(con.AccountId);
            }
        }
    }
    
    if (Trigger.isDelete) {
        for (Contact con : Trigger.old) {
            if (con.AccountId != null) {
                accountIds.add(con.AccountId);
            }
        }
    }
    
    if (!accountIds.isEmpty()) {
        Map<Id, Account> lstOfAccountToUpdate = new Map<Id, Account>();
        
        for (Account acc : [SELECT Id, (SELECT Id FROM Contacts) FROM Account WHERE Id IN :accountIds]) {
            lstOfAccountToUpdate.put(acc.Id, acc);
        }
        
        for (Account acc : lstOfAccountToUpdate.values()) {
            acc.Total_Contact_Count__c = String.valueOf(acc.Contacts.size());
        }
        
        update lstOfAccountToUpdate.values();
    }
}