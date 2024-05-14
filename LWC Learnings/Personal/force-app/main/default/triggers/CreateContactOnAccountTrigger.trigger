trigger CreateContactOnAccountTrigger on Account (after insert, after update) {
   
    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isAfter)) {
         //Question1. Write an apex Trigger to create a related contact whenever "Create_Contact__c" 
         //checkbox on Account is checked on Account insertion or Updation
        CreateContactTriggerHelper.createContacts(Trigger.New, Trigger.OldMap);
         //Q2. Write an Apex Trigger to update the related contacts with the latest country field value whenever it's chnages on 
        //Account Country field (Note: on Account we have a Field "Country__c" as well as on Contact also one Field "Account_Country__c"
        CreateContactTriggerHelper.updateContact(Trigger.New, Trigger.oldMap);
    
        
    }
}