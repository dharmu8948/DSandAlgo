/**
 * @description       : 
 * @author            : Dharmendra Kumar
 * @group             : 
 * @last modified on  : 12-03-2024
 * @last modified by  : Dharmendra Kumar
**/
trigger AccountsTrigger on Account (before insert, before update) {
    if(Trigger.isInsert){
        Accounts.onBeforeInsert();
    }else if(Trigger.isUpdate){
      Accounts.onBeforeUpdate(Trigger.oldMap);
    }
}