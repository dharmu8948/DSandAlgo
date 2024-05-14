/**
 * @description       : 
 * @author            : Dharmendra Kumar
 * @group             : 
 * @last modified on  : 12-March-2024
 * @last modified by  : Dharmendra Kumar
**/
public with sharing class AccountGeoCode {

    /*
        Google API
        Us Geocoder API
        OpenCage Geocoder API
    */

    /* 
        GeoCode Serivce - Picklist
            Google API
            Us Geocoder API
            OpenCage Geocoder API
    */
    /* 
     * @description : Using Google Api to get the Latitude and Longitude of the address
     * @param       : none
     * @return      : List<Decimal>
     */
    /*
     *  Execute below code snippet from Annanymous window
        Account acc = new Account(Name = 'Salesforce.com', Geocode_Service__c = 'BingApi' );
        AccountGeoCode.getLatLong(acc);
    */

    public static void getLatLong(Account acc){
       List<Decimal> latLong = GeoCode.getLatLang(acc.Geocode_Service__c);
       System.debug(' latLong '+ latLong);
    }

}