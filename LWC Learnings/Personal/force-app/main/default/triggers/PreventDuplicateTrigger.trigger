trigger PreventDuplicateTrigger on Contact (before insert, before update) {
    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)) {
        PreventDuplicateTriggerHandler.checkDuplicateRecord(Trigger.new);
    }
}