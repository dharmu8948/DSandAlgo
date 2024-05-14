/*--------------------------------------------------------------------------------------------------------------------------------------------------
 * Class Name    : LMSController
 * TestClass     : LMSControllerTest 
 * Created Date  : 21/Sep/2023
 * Created By    : Dharmendra Kumar
 * Description   : This Class is responsible get the required methods for Let's meet Project reuirements
 *---------------------------------------------------------------------------------------------------------------------------------------------------
 * Maodifications Log:
 * ---------------------------------------------------------------------------------------------------------------------------------------------------
 * S.No.    Modified By                 Modified Date                              Description
 * 1.       Dharmendra                   28-Sep-2023                              Added few Method Descriptions
 * 2.       Dharmendra/Samyak            04-Oct-2023                              Added method to get LMS Code from Contact
 * 3.		Rahul Kumawat				 04-oct-2023							  Added SOQL on Event Object to fetch Event in saveRegistration method
 * ---------------------------------------------------------------------------------------------------------------------------------------------------
 */

global  without sharing class LMSController {
    
   /* Method Name  : saveRegistration
    * parameter    : String, String, String, String[], String[] 
    * Description  : This method is responsible to save the record in Contact Object based on Parameters
    * return       : List< Contact >
    * Created Date : 21/Sep/2023
    * Created By   : Dharmendra Kumar
    */
    public static List< Contact > saveRegistration(String name, String email, String linkedInUrl, String[] profile, String[] interest) {
        
         List<Contact> lstOfContacts = new List<Contact>();
         //Creating lstOfEvents for fetch the event name that date is equal to today
         Event__c eventRecord=[SELECT Name,id from Event__c WHERE Date__c =:Date.today() LIMIT 1];
         // checking duplicacy of email id
        List< Contact > Record = [Select Id,LastName,LinkedIn_Id__c, Profile__c,UserId__c, Email from Contact Where Email=:email];
        if( !Record.isEmpty() && Record.size()>0 && eventRecord != null) {
            Event_Attendee__c eventAttendee = new Event_Attendee__c();
            eventAttendee.Attendee__c = Record[0].LastName;
            eventAttendee.Event__c = eventRecord.Id;
            eventAttendee.Meeting_Code__c =  getUniqueLMCode();
            insert eventAttendee;
            // getting the list of user info based on Interest
            lstOfContacts = [Select LastName, LinkedIn_Id__c,Profile__c,UserId__c FROM Contact Where Id !=: Record[0].Id];
            return lstOfContacts;
        }
        
        // Empty check for fields
        System.debug('profile.isEmpty(): '+profile.isEmpty()+' profile.size()>0: '+profile.size()+' interest.isEmpty(): '+interest.size());
        if( String.isBlank(name) || String.isBlank(email) || String.isBlank(linkedInUrl) || (profile.isEmpty() && profile.size()<0) || (interest.isEmpty() && interest.size()<0)) {
            return null;
        }
        try{
            // creating contact based on paramenter
            Contact con = new Contact();
            con.LastName = name;
            con.Email = email;
            
            con.LinkedIn_Id__c = linkedInUrl;
            con.Profile__c = profile[0];
            List<String> lstOfInterests = interest;
            String interestedIn = '';
            for(String data : lstOfInterests) {
                interestedIn += data+';';
            }
            interestedIn = interestedIn.removeEnd(';');
            con.Interested_In__c = interestedIn;
            con.UserId__c =  getUniqueLMCode();
            System.debug('lm ----'+ con.UserId__c);
            insert con;
         	            
            // Creating Event Record-->this code is no longer required
            /*
            Event__c event = new Event__c();
            event.Name='WIT';
            event.Date__c = System.today();
            insert event;
			*/
            
            // creating the Event Attendee Record
            
            // getting the list of user info based on Interest
            lstOfContacts = [Select LastName, LinkedIn_Id__c,Profile__c,UserId__c FROM Contact Where Profile__c IN:lstOfInterests AND Id !=: con.Id];
            
        }catch(Exception e) {
            System.debug('Exception '+e.getLineNumber()+'  cause  '+e.getCause());
           // return e.getMessage()+' -->Line No.--> '+e.getLineNumber();
        }
        return lstOfContacts;
    }
    
   /* Method Name  : getLMSCode
    * parameter    : String 
    * Description  : This method is responsible to get the LMS code From Contact based on Parameters
    * Return       : String
    * Created Date : 21/Sep/2023
    * Created By   : Dharmendra Kumar
    */
    
    @AuraEnabled
    global static List<Contact> getLMSCode(String lmsCode){
        
        try{
            List<Contact> conList = [SELECT Id, UserId__c, Interested_In__c
                                     FROM Contact
                                     WHERE UserId__c =: lmsCode];
            System.debug('LMCOdE:: '+conList);
            List<Contact> lstOfContacts = new List<Contact>();
            String lstOfInterest = '';
            String recordIdOfCurrentUser = '';
            if(!conList.isEmpty() && conList.size()>0) {
                System.debug('conList@@  '+conList);
                for(Contact interest : conList) {
                    recordIdOfCurrentUser = interest.Id;
                    lstOfInterest = (String)(interest.Interested_In__c);
                }
                List<String> lstOfIntrst = lstOfInterest.split(';');
                System.debug('lstOfIntrst@@  '+lstOfIntrst);
                // here we might change the SOQL query where we fetch the record where LMCode != given LMCode
                lstOfContacts = [Select LastName, LinkedIn_Id__c,Profile__c,UserId__c FROM Contact Where Profile__c IN:lstOfIntrst AND UserId__c !=: lmsCode];
                System.debug('lstOfContacts@@  '+lstOfContacts);
               // return JSON.serialize(lstOfContacts);
               return lstOfContacts;
            } 
        }catch(Exception e) {
            System.debug(e.getMessage()+' Line No.:::: '+e.getLineNumber());
            //return e.getMessage()+' Line No.: '+e.getLineNumber();
        }
        return null;
    }
    
   /* Method Name  : sendOtpEmail
    * parameter    : String 
    * Description  : This method is responsible to generate the OTP and send OTP to given email in Parameter
    * Return       : String
    * Created Date : 22/Sep/2023
    * Created By   : Dharmendra Kumar
    */
    @AuraEnabled
    global static Boolean sendOtpEmail(String email) {
        // Generate a random OTP
        String otp = generateRandomOtp();
        System.debug('OTP::: '+otp);
        // Store the OTP temporarily (in a custom object)
        Boolean canWeSendOtp = storeOtp(email, otp);

        // Send the OTP via email
        if(canWeSendOtp) {
            sendEmail(email, otp);
            return true;
        }else {
            return false;
        }
        
    }
    
   /* Method Name  : generateRandomOtp
    * parameter    : String 
    * Description  : This method is responsible to generate the 6-digit OTP
    * Return       : String
    * Created Date : 22/Sep/2023
    * Created By   : Dharmendra Kumar
    */
    private static String generateRandomOtp() {
        // Generating random OTP 
        // For simplicity, let's assume a 6-digit OTP
        Integer randomValue = Integer.valueOf(Math.floor(Math.random() * 900000) + 100000);
        return String.valueOf(randomValue);
    }
    
    private static Boolean storeOtp(String emailAddress, String otp) {
        // Store the OTP along with the email address
        List<Contact> checkEmailInContact = [Select Email from Contact WHERE email=:emailAddress LIMIT 1];
        
        //List<OTP__c> lstOfOTPRecord = [Select id, Email_Address__c FROM OTP__c where Email_Address__c=:emailAddress];
        if(checkEmailInContact.isEmpty()) {
            OTP__c otpRecord = new OTP__c();
            otpRecord.OTP_Number__c = otp;
            otpRecord.Email_Address__c = emailAddress;
            insert otpRecord;
            return true;
        }else {
            return false;
        }
        
    }
   
   /* Method Name  : sendEmail
    * parameter    : String , String
    * Description  : This method is responsible to send Email with given OTP
    * Return       : String
    * Created Date : 22/Sep/2023
    * Created By   : Dharmendra Kumar
    */
   private static void sendEmail(String emailAddress, String otp) {
       System.debug('In send email');
        // Send an email using the Messaging.SingleEmailMessage class
        OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress];
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    	mail.setOrgWideEmailAddressId(owea[0].Id);
        System.debug('owea: '+owea[0].Id);
        // Set the recipient's email address (replace with the actual email address)
        mail.setToAddresses(new String[] { 'recipient@example.com' });
        System.debug('--email-->>'+emailAddress);
        String[] toAddresses = new String[]{emailAddress};
        mail.setToAddresses(toAddresses);
        mail.setSubject('Your OTP');
        String emailBody = 'Dear Sir / Madam,';
        emailBody += '<br/><br/>';
        emailBody += 'Your One Time Password(OTP) is :'+otp;
        emailBody += '<br/>';
        emailBody += 'Do not share your OTP with anyone';
        emailBody += '<br/><br/>';
        emailBody += 'Thanks,';
        emailBody += '<br/>';
        emailBody += 'Zordial Labs';
        System.debug('emailBody: '+emailBody);
        mail.setHtmlBody(emailBody);
		System.debug('--mail-->>'+mail);
        // Send the email
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});
    }
   /* Method Name  : getStoredOtp
    * parameter    : String 
    * Description  : This method is responsible to get Stored OTP Based on email as parameter
    * Return       : Map<String, Object>
    * Created Date : 22/Sep/2023
    * Created By   : Dharmendra Kumar
    */
    private static Map<String, Object> getStoredOtp(String emailAddress) {
        Map<String, Object> otpData = new Map<String, Object>();
        System.debug('email: '+emailAddress);
        // Query the custom object to retrieve the OTP and timestamp
        List<OTP__c> otpLogs = [ SELECT OTP_Number__c, Is_Used__c
                                FROM OTP__c
                                WHERE Email_Address__c =:emailAddress
                                AND Is_Used__c = false  // Ensure you only retrieve unused OTPs
                                LIMIT 1];
        
        if (!otpLogs.isEmpty()) {
            OTP__c otpLog = otpLogs[0];
            otpData.put('otp', otpLog.OTP_Number__c);
        } else {
            otpData.put('otp', null); // No valid OTP found for the email
        }
        System.debug('otpData: '+otpData);
        return otpData;
    }

   /* Method Name  : verifyOtp
    * parameter    : String , String
    * Description  : This method is responsible to verify the OTP Based on email as parameter, and entered OTP
    * Return       : boolean
    * Created Date : 22/Sep/2023
    * Created By   : Dharmendra Kumar
    */
    @AuraEnabled
    global static List<Contact> verifyOtp(String email, String enteredOtp,String name, String linkedInUrl, String[] profile, String[] interest) {
        // Retrieve the stored OTP and its timestamp for the given email address
        System.debug('email from Verify: '+email);
        Map<String, Object> otpData = getStoredOtp(email);
        String storedOtp = (String)otpData.get('otp');
        
        //---------------------------- we are not implementing the Expiration time as of now--------------------
        /*Datetime timestamp = (Datetime)otpData.get('timestamp');

        // Check if the OTP has expired (e.g., set a 5-minute expiration time)
        Datetime currentDatetime = Datetime.now();
        if (timestamp != null && timestamp.addMinutes(5) >= currentDatetime) { } */
      //---------------------------------------------------------------------------------------------------------
            System.debug('enteredOtp: '+enteredOtp+'  storedOtp: '+storedOtp);
            // Check if the OTP has not been used
            if (storedOtp != null && storedOtp.equals(enteredOtp)) {
                // Mark the OTP as used in the custom object
                markOtpAsUsed(email, enteredOtp);
                List<Contact> record = saveRegistration(name, email, linkedInUrl, profile, interest);
                if(record != null)
                     return record; // OTP is valid and not used
                else
                    return null;
            }
        return null; // OTP has expired or is used
    }

   /* Method Name  : markOtpAsUsed
    * parameter    : String , String
    * Description  : This method is responsible to make the OTP as one time Based on email as parameter, and OTP
    * Return       : void
    * Created Date : 22/Sep/2023
    * Created By   : Dharmendra Kumar
    */
    private static void markOtpAsUsed(String emailAddress, String otp) {
        // Update the custom object record to mark the OTP as used
        List<OTP__c> otpLogs = [SELECT Id, Is_Used__c
                                FROM OTP__c
                                WHERE Email_Address__c = :emailAddress
                                AND OTP_Number__c = :otp LIMIT 1];
        System.debug('otpLogs: '+otpLogs);
        if (!otpLogs.isEmpty()) {
            OTP__c otpLog = otpLogs[0];
            otpLog.Is_Used__c = true;
            update otpLog;
        }
    }
    
    /* Method Name : getUniqueLMCode
    * parameter    : no parameter
    * Description  : This method is responsible to generate the unique LM Code 
    * Return       : String
    * Created Date : 29/Sep/2023
    * Created By   : Himanshi Gupta 
    */
    
   //InvocableMethod to be used in Flow
   // @InvocableMethod(label='getUniqueLMCode' description='Generates the unique LM Code ' category='LMApp')
    
    public static String  getUniqueLMCode(){
        Blob b = Crypto.GenerateAESKey(128);
        String h = EncodingUtil.ConvertTohex(b);
        String lmc= h.SubString(0,6);
        return lmc;
    }
    
      
   /* Method Name : createMeeting
    * parameter    : String, String, String
    * Description  : This method is responsible to Create Meeting Record based on paramerter velues 
    * Return       : String
    * Created Date : 12/Oct/2023
    * Created By   : Dharmendra
    */
    @AuraEnabled
    global static Boolean createMeeting(String userId,String eventCode, String meetingCode) {
        system.debug(userId+'===='+eventCode+'====='+meetingCode);
        String currentAttendeeId = [Select Id FROM Event_Attendee__c Where Meeting_Code__c =:meetingCode].Id;
        Event_Attendee__c initiatorAttendee = [Select Id,Event__c FROM Event_Attendee__c Where Attendee__r.UserId__c =:userId AND Event__r.Name =:eventCode ][0];
        Meeting__c meeting = new Meeting__c();
        system.debug(currentAttendeeId+'===='+initiatorAttendee.id+'====='+initiatorAttendee.Event__c);
        meeting.Attendee1__c = currentAttendeeId;
        meeting.Attendee2__c = initiatorAttendee.Id;
        meeting.Event__c = initiatorAttendee.Event__c; 
        try{
            insert meeting;
            return true;
        }catch(Exception e) {
            System.debug('Exception:::'+e.getMessage());
            return false;
        }
        
    }
}