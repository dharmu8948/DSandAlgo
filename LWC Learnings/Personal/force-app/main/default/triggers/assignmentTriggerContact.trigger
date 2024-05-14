trigger assignmentTriggerContact on Contact (before insert, after insert, after Update, after delete ) {
    
    if(trigger.isAfter){
        if(trigger.isInsert || trigger.isUpdate){
            contactClass.contactAmountUpdate(trigger.new);
        }
        if(trigger.isDelete){
            contactClass.contactAmountUpdateForDelete(trigger.old);
        }
    }
}