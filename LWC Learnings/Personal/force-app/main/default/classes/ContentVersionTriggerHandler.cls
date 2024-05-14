public class ContentVersionTriggerHandler {
    
    @future(callout = true)
    public static void callGoogleDrive(String contentVersionId) {
        String key = '676966802823-8ugnimms0o5pt4vtpgmf9bih6dmui5d8.apps.googleusercontent.com';
        String secret = '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';
        String redirect_uri = 'https://developers.google.com/oauthplayground';
        String accessToken;
        String refreshToken = '1//04swYIgQQHVRvCgYIARAAGAQSNwF-L9IrKsgNws1dYhZHzHWPsdGDEg3cw5H1fNqrYCVZ2WdYHWIy4onIcDpTcdo5V7fs0y7AdrA';
        
        HttpRequest req2 = new HttpRequest();
        req2.setMethod('POST');
        req2.setEndpoint('https://www.googleapis.com/oauth2/v4/token');
        req2.setHeader('content-type','application/x-www-form-urlencoded');
        String messageBody = 'client_id='+ key + '&client_secret='+ secret + '&refresh_token=' + refreshToken + '&redirect_uri=' + redirect_uri + '&grant_type=refresh_token';
        req2.setHeader('Content-length', String.valueOf(messageBody));
        req2.setBody(messageBody);
        req2.setTimeout(60*1000);
        System.debug('req2:: '+req2);
        Http h2 = new Http();
        String resp2;
        HttpResponse res2 = h2.send(req2);
        System.debug('res2:: '+res2);
        resp2 = res2.getBody();
        System.debug('resp2-->>'+resp2);
        JSONParser parser = JSON.createParser(resp2);
        while(parser.nextToken() != null) {
            if((parser.getCurrentToken() == JSONToken.FIELD_NAME)) {
                String fieldName = parser.getText();
                parser.nextToken();
                if(fieldName == 'access_token') {
                    accessToken = parser.getText();
                }else if(fieldName == 'expires_in') {
                    Integer expiresIn = parser.getIntegerValue();
                }else if(fieldName == 'token_type') {
                    String tokenType = parser.getText();
                }
            }
        }
        
        ContentVersion cv = [SELECT Id, Title,ContentDocumentId, VersionData FROM ContentVersion WHERE ID =:contentVersionId];
        System.debug('title:: '+cv.Title);
        Blob myBlob = cv.VersionData;
        // https://www.googleapis.com/upload/drive/v3/files
        String url = 'https://www.googleapis.com/upload/drive/v3/files?uploadType=media';
        String authorizationHeader = 'Bearer ' + accessToken;
        Integer contentSize = myBlob.size();
        // Define the file metadata including the title (file name)
       // String metadataJson = '{"title":"' + cv.Title + '"}';
        HttpRequest req1 = new HttpRequest();
        req1.setHeader('Authorization', authorizationHeader);
        req1.setHeader('Content-Type', 'application/json;charset=UTF-8');
        req1.setHeader('Content-length', String.valueOf(contentSize));
       // req1.setHeader('X-Upload-Content-Type',fileType);
        req1.setHeader('X-Upload-Content-Length',String.valueOf(contentSize));
        //req1.setHeader('Content-Length', String.valueOf(contentSize));
        req1.setHeader('Content-Type','image/'+'PNG');
        req1.setHeader('Content-Type','application/'+'pdf');
        req1.setHeader('title',cv.Title);
        req1.setEndPoint(url);
       // req1.setBodyAsBlob(Blob.valueOf(metadataJson));
        req1.setBodyAsBlob(myBlob);
        req1.setMethod('POST');
        System.debug('reqrtfghuyitfughjvbhugyf1::'+req1);
        Http h1 = new Http();
        HttpResponse resp1 = h1.send(req1);
        System.debug('resp1::'+resp1);
    }
    
}