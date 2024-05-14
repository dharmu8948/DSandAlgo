//On account object have is active field and contact object have is active field if is active field checked 
//then all related contact is active field mark checked and related user should be didactive
/*
trigger AccountTrigger on Account (after insert, after update) {
    Set<Id> accountIds = new Set<Id>();
    Set<Id> userIds = new Set<Id>();
    for(Account acc : Trigger.New) {
        if( acc.isActive__c == true) {
            accountIds.add(acc.Id);
            userIds.add(acc.CreatedById);
        }
    }
    // making future call to deactivate the user
    DeactivateUser.deactivateUser(userIds);
    // Note: You might get this Exception: System.DmlException: Update failed. First exception on row 0 with id 0055h000009RNesAAG; 
    //                                                          first error: FIELD_INTEGRITY_EXCEPTION, To self-deactivate, 
    //                                                          the org must enable the user self-deactivation setting and the usertype 
    //                                                          must be external.: Active: [IsActive]
    //                                                          
    // rest logic will execute as is
    System.debug('accountIds:::  '+accountIds);
    List<Contact> lstOfContacts = [Select Id,isActive__c, AccountId FROM Contact WHERE AccountId IN:accountIds];
     System.debug('lstOfContacts:::  '+lstOfContacts);
    List<Contact> lstOfContactToUpdate = new List<Contact>();
    for(Contact con : lstOfContacts) {
        if(!con.isActive__c) {
            con.isActive__c = true;
           lstOfContactToUpdate.add(con); 
        }
    }
    System.debug('lstOfContactToUpdate::: '+lstOfContactToUpdate);
    if(!lstOfContactToUpdate.isEmpty() && lstOfContactToUpdate.size()>0) {
        update lstOfContactToUpdate;
    }
} */
//Write a trigger on Account, when an account is inserted, automatically account billing address should populate into the 
//account shipping address.
trigger AccountTrigger on Account (before insert, before update) {
    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)) {
        //AccountTriggerHandler.updateAddress(Trigger.New);
        for(Account a : Trigger.New) {
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
    }
}
//Write a trigger on Account when Account is update check all opportunity inside the account. Update all Opportunities Stage to
// close lost if an opportunity created date is greater than 30 days from today and stage not equal to close won.
/*
trigger AccountTrigger on Account (after update) { 
    List<String> lstOfAccountIds = new List<String>();
    List<Opportunity> lstOfOppsTOUpdate = new List<Opportunity>();
    Map<String, Opportunity> mpOfIdvsOpps = new Map<String, Opportunity>();
    for(Account acc : Trigger.New) {
        lstOfAccountIds.add(acc.Id);
    } 
    List<Opportunity> lstOfOpps = [Select Id, StageName,CreatedDate, AccountId FROM Opportunity Where AccountId IN:lstOfAccountIds];
    for(Opportunity opps : lstOfOpps) {
        mpOfIdvsOpps.put(opps.AccountId,opps);
    }
    System.debug('mpOfIdvsOpps:: '+mpOfIdvsOpps);
    for(Account acc : Trigger.New) {
        
        if(mpOfIdvsOpps.get(acc.Id) != null 
           && mpOfIdvsOpps.get(acc.Id).CreatedDate<Date.today().addDays(-30) 
           && mpOfIdvsOpps.get(acc.Id).StageName != 'Closed Won') {

            System.debug('inside If Block');
            mpOfIdvsOpps.get(acc.Id).StageName = 'Closed Lost';
            lstOfOppsTOUpdate.add(mpOfIdvsOpps.get(acc.Id));
        }
    }
    System.debug('lstOfOppsTOUpdate:: '+lstOfOppsTOUpdate);
    update lstOfOppsTOUpdate;    
}
*/