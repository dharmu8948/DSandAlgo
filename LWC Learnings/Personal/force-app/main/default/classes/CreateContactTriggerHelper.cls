//Write an apex Trigger to create a related contact whenever "Create_Contact__c" 
    //checkbox on Account is checked on Account insertion or Updation
public class CreateContactTriggerHelper {
    public static void createContacts(List<Account> lstOfAccount, Map<Id, Account> mpAccount) {
        if(!lstOfAccount.isEmpty()) {
            List<Contact> lstOfContact = new List<Contact>();
            for(Account acc: lstOfAccount) {
                if((acc.Create_Contact__c == true && !mpAccount.isEmpty() && mpAccount.get(acc.Id).Create_Contact__c != true) 
                   || (acc.Create_Contact__c == true && mpAccount.isEmpty())) {
                    Contact con = new Contact();
                       con.FirstName = 'Test Contact';
                       con.LastName = ' Trigger';
                       con.AccountId = acc.Id;
                       lstOfContact.add(con);
                }
            }
            System.debug('lstOfContact:: '+lstOfContact);
            insert lstOfContact;
        }
    }
    public static void updateContact(List<Account> lstOfAccounts, Map<Id, Account> mpAccount) {
        Map<Id, Account> accMap = new Map<Id, Account>();
        if(!lstOfAccounts.isEmpty()) {
            for(Account acc : lstOfAccounts) {
                if(acc.Country__c != null && (mpAccount == null || mpAccount.get(acc.Id).Country__C != acc.Country__c)) {
                   accMap.put(acc.Id, acc); 
                }
            }
        }
        List<Contact> conListToUpdate = new List<Contact>();
        if(!accMap.isEmpty()) {
            List<Contact> conList = [Select Id, AccountId, Country__c FROM Contact WHERE AccountId IN:accMap.keySet()];
            if(!conList.isEmpty()) {
                for(Contact con : conList) {
                    if(accMap.containsKey(con.AccountId)) {
                        con.country__c = accMap.get(con.AccountId).Country__c;
                        conListToUpdate.add(con);
                    }
                }
            }
        }
        if(!conListToUpdate.isEmpty()) {
            update conListToUpdate;
        }
    }
}