/**
 * @description       : 
 * @author            : Dharmendra Kumar
 * @group             : 
 * @last modified on  : 12-March-2024
 * @last modified by  : Dharmendra Kumar
**/
public with sharing class GeoCode {

    /* 
     * @description : Using Google Api to get the Latitude and Longitude of the address
     * @param       : none
     * @return      : List<Decimal>
     */
    public static List<Decimal> getLatLang(String geoCodeServiceName){
        List<Decimal> latLong;
        Type t = Type.forName(geoCodeServiceName);
        IGeoCodeApi igeoCodeObj = (IGeoCodeApi) t.newInstance();
        latLong = igeoCodeObj.getLatLong('123 Main Street');
        return latLong;
    }
}