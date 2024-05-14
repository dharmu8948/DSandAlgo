trigger CreateContactTrigger on Contact (before insert, before update) {
    if(Trigger.IsBefore && Trigger.IsInsert) {
        CreateContactTriggerHandler.makePrimaryContact(Trigger.New, null);
    }else if(Trigger.IsBefore && Trigger.isUpdate) {
        CreateContactTriggerHandler.makePrimaryContact(Trigger.New, Trigger.OldMap);
    }
    /*
    Set<String> accountIds = new Set<String>();
    for(Contact con : Trigger.New) {
        accountIds.add(con.accountId);
    }
    System.debug('accountIds:: '+accountIds);
    List<Contact> contactList = [Select Id, accountId,Is_Primary__c FROM Contact Where AccountId IN:accountIds AND Is_Primary__c = True];
    Map<String, Boolean> mpContact = new Map<String, Boolean>();
    Map<String, Contact> mpContactRecord = new Map<String, Contact>();
    for(Contact con : contactList) {
        mpContact.put(con.AccountId, con.Is_Primary__c);
        mpContactRecord.put(con.AccountId, con);
    }
    System.debug('mpContact:: '+mpContact);
    System.debug('mpContactRecord:: '+mpContactRecord);
    List<Contact> lstOfContact = new List<Contact>();
    for(Contact con : Trigger.New) {
        if(mpContact.get(con.AccountId) == True) {
            Contact cont = mpContactRecord.get(con.AccountId);
            cont.Is_Primary__c = False;
            lstOfContact.add(cont);
        }
    }
    System.debug('lstOfContact::'+lstOfContact);
    if(!lstOfContact.IsEmpty()) {
        update lstOfContact;
    }
*/
}