/*--------------------------------------------------------------------------------------------------------------------------------------------------
 * Class Name    : FileUploaderClass
 * TestClass     : FileUploaderClassTest 
 * Created Date  : 19/Oct/2023
 * Created By    : Dharmendra Kumar
 * Description   : This Class is meet the requirement to file Upload search and Show All files
 *---------------------------------------------------------------------------------------------------------------------------------------------------
 * Maodifications Log:
 * ---------------------------------------------------------------------------------------------------------------------------------------------------
 * S.No.    Modified By                 Modified Date                              Description
 * 
 * ---------------------------------------------------------------------------------------------------------------------------------------------------
 */
public with sharing class FileUploaderClass {
    
   /* Method Name  : uploadFile
    * parameter    : String, String, String
    * Description  : This method is responsible to save the record in File Object based on Parameters
    * return       : String
    * Created Date : 19/Oct/2023
    * Created By   : Dharmendra Kumar
    */
    @AuraEnabled
    public static ContentVersion uploadFile(String base64, String filename, String recordId) {
        ContentVersion cv = createContentVersion(base64, filename);
        ContentDocumentLink cdl = createContentLink(cv.Id, recordId);
        ContentVersion contentVersionRecord = [SELECT Id, Title, ContentDocumentId, FileType, ContentSize, FileExtension, VersionNumber, CreatedDate, VersionData, FirstPublishLocationId 
                                               FROM ContentVersion WHERE Id=:cv.Id LIMIT 1];
        System.debug('cdl::: '+cdl+' cv:  '+cv);
        if (cv == null && cdl == null) { return null; }
        return contentVersionRecord;
    }
    
   /* Method Name  : createContentVersion
    * parameter    : String, String
    * Description  : This method is responsible to insert the record of ContentVersion Object based on Parameters
    * return       : String
    * Created Date : 19/Oct/2023
    * Created By   : Dharmendra Kumar
    */
    private static ContentVersion createContentVersion(String base64, String filename) {
        ContentVersion cv = new ContentVersion();
        cv.VersionData = EncodingUtil.base64Decode(base64);
        cv.Title = filename;
        cv.PathOnClient = filename;
        try {
            insert cv;
            return cv;
        } catch(DMLException e) {
            System.debug(e);
            return null;
        }
    }
   /* Method Name  : createContentLink
    * parameter    : String, String
    * Description  : This method is responsible to insert the record of ContentDocumentLink Object based on Parameters
    * return       : String
    * Created Date : 19/Oct/2023
    * Created By   : Dharmendra Kumar
    */
    private static ContentDocumentLink createContentLink(String contentVersionId, String recordId) {
        if (contentVersionId == null || recordId == null) { return null; }
        ContentDocumentLink cdl = new ContentDocumentLink();
        cdl.ContentDocumentId = [
            SELECT ContentDocumentId 
            FROM ContentVersion 
            WHERE Id =: contentVersionId
        ].ContentDocumentId;
        cdl.LinkedEntityId = recordId;
        cdl.ShareType = 'V';
        try {
            insert cdl;
            return cdl;
        } catch(DMLException e) {
            System.debug(e);
            return null;
        }
    }
    
   /* Method Name  : getSearchProduct
    * parameter    : String
    * Description  : This method is responsible to Search the record in ContentVersion Object based on Parameters
    * return       : List<ContentVersion>
    * Created Date : 19/Oct/2023
    * Created By   : Dharmendra Kumar
    */
    @AuraEnabled
    public static List<ContentVersion> getSearchProduct(String productName) {
        if(String.isNotBlank(productName)) {
             List<ContentVersion> products = [SELECT Id, Title, ContentDocumentId, FileType, ContentSize, FileExtension, VersionNumber, CreatedDate, VersionData, FirstPublishLocationId 
                                               FROM ContentVersion WHERE Title LIKE :'%'+productName+'%'];
             return products;
        }
       return null;
    }
    /* Method Name  : getAllFiles
    * parameter    : no param
    * Description  : This method is responsible to Search all record in ContentVersion Object 
    * return       : List<ContentVersion>
    * Created Date : 19/Oct/2023
    * Created By   : Dharmendra Kumar
    */
    @AuraEnabled
    public static List<ContentVersion> getAllFiles() {
        List<ContentVersion> products = [select Id, Title, ContentDocumentId, FileType, ContentSize, FileExtension, VersionNumber, CreatedDate, VersionData, FirstPublishLocationId FROM ContentVersion LIMIT 3]; // put limit to avoid limit exception
        System.debug('products:: '+products);        
        return products;
    }
   /* Method Name  : loadMore
    * parameter    : no param
    * Description  : This method is responsible to load the remaining reocrds ,based on Offset
    * return       : List<ContentVersion>
    * Created Date : 19/Oct/2023
    * Created By   : Dharmendra Kumar
    */
    @AuraEnabled(cacheable=true)
    public static List<ContentVersion> getPaginatedRecords(Integer startIndex, Integer recordLimit) {
             System.debug('Start::'+startIndex+' recordzLimit:: '+recordLimit);
             List<ContentVersion> products = [SELECT Id, Title, ContentDocumentId FROM ContentVersion  LIMIT :recordLimit OFFSET :startIndex]; // put limit to avoid limit exception
             return products;
    }
}