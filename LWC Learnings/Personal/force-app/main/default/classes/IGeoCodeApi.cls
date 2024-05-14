/**
 * @description       : Demostration of interface design pattern
 * @author            : Dharmendra Kumar
 * @group             : 
 * @last modified on  : 12-March-2024
 * @last modified by  : Dharmendra Kumar
**/

/*
    IGeoCodeApi objetDemo = new IGeoCodeApi();
*/
public interface IGeoCodeApi {
    List<Decimal> getLatLong(String address);
    String getAddress(Decimal lat, Decimal lng);
}