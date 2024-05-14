@isTest
public class WeatherDetailClassTest {
    @isTest static void testCallout() {
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        WeatherDetailClass.WeatherDetailWrapper res = WeatherDetailClass.getWeatherDetail('Noida');
        System.assertEquals(true, res!=null);
    }
}