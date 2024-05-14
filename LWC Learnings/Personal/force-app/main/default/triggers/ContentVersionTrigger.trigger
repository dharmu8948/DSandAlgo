trigger ContentVersionTrigger on ContentVersion (after insert) {
    for(ContentVersion cv : Trigger.New) {
       ContentVersionTriggerHandler.callGoogleDrive(cv.Id); 
    }
}