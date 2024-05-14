/**
 * @description       : 
 * @author            : Dharmendra Kumar
 * @group             : 
 * @last modified on  : 12-March-2024
 * @last modified by  : Dharmendra Kumar
**/
@IsTest
public with sharing class AccountsUnitTest {
    
    @TestSetup
    static void setupData(){
        RegionManager__c regionManager = new RegionManager__c(
            Manager__c = UserInfo.getUserId(),
            Region__c = 'US'
        );
        RegionManager__c regionManager1 = new RegionManager__c(
            Manager__c = UserInfo.getUserId(),
            Region__c = 'LATAM'
        );
        RegionManager__c regionManager2 = new RegionManager__c(
            Manager__c = UserInfo.getUserId(),
            Region__c = 'Canada'
        );
        RegionManager__c regionManager3 = new RegionManager__c(
            Manager__c = UserInfo.getUserId(),
            Region__c = 'EMEA'
        );
        RegionManager__c regionManager4 = new RegionManager__c(
            Manager__c = UserInfo.getUserId(),
            Region__c = 'Canada'
        );
    }

    @IsTest
    private static void insertAccountTest(){
        Account acc = New Account();
        acc.Name = 'Singleton Test';
        acc.Region__c = 'US';
        acc.Rating = 'Hot';
        acc.Description = 'Test Account';
        acc.Website = 'www.test.com';
        insert acc;
        System.assertEquals(acc.Name, 'Singleton Test','Account Not Created');
    }

    @IsTest
    private static void updateAccountTest(){
        Account acc = New Account();
        acc.Name = 'Singleton Test';
        acc.Region__c = 'Canada';
        acc.Rating = 'Hot';
        acc.Description = 'Test Account';
        acc.Website = 'www.test.com';
        insert acc;
        acc.Name = 'Singleton Test Updated';
        update acc;
        System.assertEquals(acc.Name, 'Singleton Test Updated','Account Not Updated');
    }
}