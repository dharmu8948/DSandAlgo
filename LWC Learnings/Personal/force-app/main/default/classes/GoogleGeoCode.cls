/**
 * @description       : 
 * @author            : Dharmendra Kumar
 * @group             : 
 * @last modified on  : 12-March-2024
 * @last modified by  : Dharmendra Kumar
**/
public with sharing class GoogleGeoCode implements IGeoCodeApi {
    
    public static List<Decimal> getLatLong(String address) {
        return new List<Decimal>{23.445, 53.445};
    }

    public static String getAddress(Decimal lat, Decimal lng) {
        return '123 Main Street';
    }

}