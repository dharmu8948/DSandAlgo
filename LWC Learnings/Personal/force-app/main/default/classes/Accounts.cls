/**
 * @description       : 
 * @author            : Dharmendra Kumar
 * @group             : 
 * @last modified on  : 12-03-2024
 * @last modified by  : Dharmendra Kumar
**/
public class Accounts {

    public static void onBeforeInsert(){
        RegionManagerUtility utils = RegionManagerUtility.getInstance();
        for(Account acc : (List<Account>) Trigger.New ) { // Trigger.New
            acc.RegionManager__c = utils.regionMap.get(acc.Region__c); // RegionManager__c is Lookup(USER) on Account Object
                                                                       //Region__c is Picklist Field on Account with values: 'US','Canada','APAC','LATAM','EMEA'
        }
    }
    
    public static void onBeforeUpdate(Map<id, SObject> existingRecords){
        RegionManagerUtility utils = RegionManagerUtility.getInstance();
        for(Account acc : (List<Account>) Trigger.New ) { // Trigger.New 
            acc.RegionManager__c = utils.regionMap.get(acc.Region__c);        
        }
    }
    
}