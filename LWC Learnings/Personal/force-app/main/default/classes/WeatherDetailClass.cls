global class WeatherDetailClass {
    
    @AuraEnabled
    public static WeatherDetailWrapper getWeatherDetail(String cityName){
        // framing the end point URL
        String apiKey = 'd8429f0c76f6644b8071e7e713b50b44';
        String endPoint = 'http://api.openweathermap.org/data/2.5/weather';
        endPoint += '?q='+cityName;
        endPoint += '&units=metric';
        endPoint += '&APPID='+apiKey;
        System.debug('endPointUrl '+endPoint);
        
        // callout to weather API
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endPoint);
        req.setMethod('GET');
        HttpResponse res = http.send(req);
        System.debug('res '+res+'   '+Json.deserializeUntyped(res.getBody()));
        
        // return the weather details in Wrapper form
        WeatherDetailWrapper wrapper = new WeatherDetailWrapper();
        if(res.getStatusCode() == 200) {
            Map<String, Object> result = (Map<String, Object>)Json.deserializeUntyped(res.getBody());
            wrapper.city = String.valueOf(result.get('name'));
            Map<String, Object> mainResult = (Map<String, Object>)result.get('main');
            wrapper.temperature = String.valueOf(mainResult.get('temp'));
            wrapper.pressure = String.valueOf(mainResult.get('pressure'));
            wrapper.humidity = String.valueOf(mainResult.get('humidity'));
            wrapper.feelLike = String.valueOf(mainResult.get('feels_like'));
            wrapper.tempMin = String.valueOf(mainResult.get('temp_min'));
            wrapper.tempMax = String.valueOf(mainResult.get('temp_max'));
        }
        System.debug('wrapper '+Json.serialize(wrapper));
        return wrapper;
    }
    
    // wrapper class to store weather details in serial manner
    public class WeatherDetailWrapper {
        @AuraEnabled public String city{get;set;}
        @AuraEnabled public String temperature{get;set;}
        @AuraEnabled public String pressure{get;set;}
        @AuraEnabled public String humidity{get;set;}
        @AuraEnabled public String feelLike{get;set;}
        @AuraEnabled public String tempMin{get;set;}
        @AuraEnabled public String tempMax{get;set;}
    }
    
}