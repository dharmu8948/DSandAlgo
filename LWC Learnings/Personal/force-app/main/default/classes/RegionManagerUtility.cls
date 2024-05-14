/**
 * @description       : 
 * @author            : Dharmendra Kumar
 * @group             : 
 * @last modified on  : 12-03-2024
 * @last modified by  : Dharmendra Kumar
**/
public with sharing class RegionManagerUtility {
    
    private static RegionManagerUtility utils { get; private set; }
    public  Map<String, String> regionMap { get; private set; }

    private RegionManagerUtility() {
        this.regionMap = new Map<String, String>();
        // Manager__c is Lookup(USER) on RegionManager__c Object
        //Region__c is Picklist Field on RegionManager__c Object with values: 'US','Canada','APAC','LATAM','EMEA'
        for(RegionManager__c regionM : [SELECT Id, Manager__c, Region__c FROM RegionManager__c LIMIT 50]) {
            this.regionMap.put(regionM.Region__c, regionM.Id);
        }
    }

    public static RegionManagerUtility getInstance() {
        if(utils == null) {
            utils = new RegionManagerUtility();
        }
        return utils;
    }
}