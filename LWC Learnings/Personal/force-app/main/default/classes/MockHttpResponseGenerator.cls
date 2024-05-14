@isTest
global class MockHttpResponseGenerator implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest req) {
        // Optionally, only send a mock response for a specific endpoint
        // and method.
        System.assertEquals('http://api.openweathermap.org/data/2.5/weather?q=Noida&units=metric&APPID=d8429f0c76f6644b8071e7e713b50b44', req.getEndpoint());
        System.assertEquals('GET', req.getMethod());

        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{ "coord": { "lon": 77.33, "lat": 28.58 }, "weather": [ { "id": 804, "main": "Clouds", "description": "overcast clouds", "icon": "04d" } ], "base": "stations", "main": { "temp": 35.16, "feels_like": 38.15, "temp_min": 35.16, "temp_max": 35.16, "pressure": 1001, "humidity": 42, "sea_level": 1001, "grnd_level": 979 }, "visibility": 10000, "wind": { "speed": 2.9, "deg": 126, "gust": 2.44 }, "clouds": { "all": 98 }, "dt": 1694681191, "sys": { "type": 1, "id": 9165, "country": "IN", "sunrise": 1694651697, "sunset": 1694696298 }, "timezone": 19800, "id": 7279746, "name": "Noida", "cod": 200 }');
        res.setStatusCode(200);
        return res;
    }
}