trigger SendEmailOnUpdateTrigger on Account (after update) {
    if(Trigger.isAfter && Trigger.isUpdate) {
        SendEmailOnUpdateTriggerHelper.sendEmail(Trigger.New, Trigger.OldMap);
    }
}