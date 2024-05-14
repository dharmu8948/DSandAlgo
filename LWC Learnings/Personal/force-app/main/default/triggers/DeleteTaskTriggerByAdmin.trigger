trigger DeleteTaskTriggerByAdmin on Task (before delete) {
    List<Profile> PROFILE = [SELECT Id, Name FROM Profile WHERE Id=:userinfo.getProfileId() LIMIT 1];
    String proflieName = !PROFILE.isEMpty() ? PROFILE[0].Name : '';
    if(Trigger.isBefore && Trigger.isDelete) {
        if(!Trigger.Old.isEmpty()) {
            for(Task tsk : Trigger.Old) {
                if(proflieName != 'System Administrator')  {
                    tsk.addError('Only System Admin can have permission to delete the Task');
                }
            }
        }
    }
}