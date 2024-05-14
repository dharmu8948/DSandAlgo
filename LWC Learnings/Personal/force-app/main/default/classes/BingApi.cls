/**
 * @description       : 
 * @author            : Dharmendra Kumar
 * @group             : 
 * @last modified on  : 12-March-2024
 * @last modified by  : Dharmendra Kumar
**/
public with sharing class BingApi implements IGeoCodeApi {
    
    public static List<Decimal> getLatLong(String address) {
        System.debug('getLatLong inside Bing API');
        return new List<Decimal>{23.445, 53.445};
    }

    public static String getAddress(Decimal lat, Decimal lng) {
        return '123 Main Street';
    }

}