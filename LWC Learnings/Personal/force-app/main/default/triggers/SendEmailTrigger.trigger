trigger SendEmailTrigger on Contact (after insert) {
    if(Trigger.isAfter && Trigger.isInsert) {
        SendEmailTriggerHandler.insertContact(Trigger.New);
    }
}