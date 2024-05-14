trigger UpdateuserTrigger on User (after update) {
    
    List<String> userRecordList = new List<String>();
    for(User newUser : Trigger.New) {
        User oldUser = Trigger.oldMap.get(newUser.Id);
        if(oldUser.isActive && !newUser.isActive) {
           userRecordList.add(newUser.Id); 
        }
    }
    System.debug('userRecordList::'+userRecordList);
    List<Case> caseList = [Select Id, EngineeringReqNumber__c FROM Case WHERE Id IN :userRecordList];
    
    for(Case caseRec : caseList) {
        caseRec.EngineeringReqNumber__c = 'deactvated user case share';
    }
    System.debug('caseList:: '+caseList);
    if(!caseList.isEmpty()) {
        update caseList;
    }
}