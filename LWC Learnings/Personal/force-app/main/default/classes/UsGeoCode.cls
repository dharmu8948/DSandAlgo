/**
 * @description       : 
 * @author            : Dharmendra Kumar
 * @group             : 
 * @last modified on  : 12-March-2024
 * @last modified by  : DHarmendra Kumar
**/
public with sharing class UsGeoCode implements IGeoCodeApi {
    
    public static List<Decimal> getLatLong(String address) {
        return new List<Decimal>{234.45, 53.445};
    }

    public static String getAddress(Decimal lat, Decimal lng) {
        return null;
    }

}