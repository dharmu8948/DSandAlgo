public class CreateContactTriggerHandler {
    public static void makePrimaryContact(List<Contact> lstofConRecord, Map<Id, Contact> mpOfIdVsCon) {
        // get accountIds first
        Set<String> accountIds = new Set<String>();
        for(Contact con : lstofConRecord) {
            if(con.AccountId != null)
               accountIds.add(con.AccountId);
        }
        // getting all the Record which is present in DB 
        List<Contact> conList = [Select id, accountId, Is_Primary__c FROM Contact WHERE AccountId IN:accountIds AND Is_Primary__c = True];
        Map<String, COntact> mpOfIdVsConId = new Map<String, Contact>();
        for(Contact con : conList) {
            mpOfIdVsConId.put(con.AccountId,con);
        }
        List<Contact> contactRecs = new List<Contact>();
        for(Contact con : lstofConRecord){
            if(mpOfIdVsConId.containsKey(con.AccountId) && con.Is_Primary__c == true) {
                Contact oldCon = mpOfIdVsConId.get(con.AccountId);
                oldCon.Is_Primary__c = false;
                contactRecs.add(oldCon);
            }else if(!mpOfIdVsConId.containsKey(con.AccountId) && con.Is_Primary__c == false) {
                con.Is_Primary__c = true;
            }
        }
        if(!contactRecs.isEMpty()){
            update contactRecs;
        }
        
        
        
    }
   /* 
    public static void makePrimaryContact(List<Contact> lstofConRecord, Map<Id, Contact> mpOfIdVsCon) {
        Set<String> accountIds = new Set<String>();
        for(Contact con : lstofConRecord) {
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
        for(Contact con : lstofConRecord) {
                // insert case                                                    // update case
            if((mpContact.get(con.AccountId) == True && mpOfIdVsCon == null)) {
                Contact cont = mpContactRecord.get(con.AccountId);
                cont.Is_Primary__c = False;
                lstOfContact.add(cont);
            }else if((mpContact.get(con.AccountId) == True && mpOfIdVsCon != null && mpOfIdVsCon.get(con.Id).Is_Primary__c == False)) {
                if(mpContactRecord.get(con.AccountId).Id != con.Id) {
                    Contact cont = mpContactRecord.get(con.AccountId);
                    cont.Is_Primary__c = False;
                    lstOfContact.add(cont);
                }
            }
        }
        System.debug('lstOfContact::'+lstOfContact);
        if(!lstOfContact.IsEmpty()) {
            update lstOfContact;
        }
    }
    */
}