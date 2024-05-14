/*--------------------------------------------------------------------------------------------------------------------------------------------------
* Class Name    : ContactRecordCreationTrigger
* TestClass     :  
* Created Date  : 11/Oct/2023
* Created By    : Dharmendra Kumar
* Description   : This Class is responsible to send the email after Contact Record Creation
*---------------------------------------------------------------------------------------------------------------------------------------------------
* Maodifications Log:
* ---------------------------------------------------------------------------------------------------------------------------------------------------
* S.No.    Modified By                 Modified Date                              Description
* 1.       Dharmendra                   28-Sep-2023                              Added few Method Descriptions
* ---------------------------------------------------------------------------------------------------------------------------------------------------
*/
trigger ContactRecordCreationTrigger on Contact (after insert) {
    
    // Get the Current Event
    Event__c eventRecord = [Select id,Name FROM Event__c Where Date__c =:Date.today() LIMIT 1];
    Set<Id> lstOfContact = new Set<Id>();
    List<Event_Attendee__c> eventAttendee = new List<Event_Attendee__c>();
    // Get the Meeting Code respective to Attendee
    Map<String, String> mpOfContactIdVsMeetingCode = new Map<String, String>();
    
    for(Contact con: Trigger.New) {
        lstOfContact.add(con.Id);
    }
    if(!lstOfContact.isEmpty()){
        for(Id i: lstOfContact){
            eventAttendee.add(new Event_Attendee__c(Attendee__c = i ,Event__c = eventRecord.Id, Meeting_Code__c =  LMSController.getUniqueLMCode()));
        }
        insert eventAttendee;
    }
    System.debug('eventAttendee: '+eventAttendee);
    
    if(!eventAttendee.isEmpty()) {
        for(Event_Attendee__c rec: eventAttendee) {
            mpOfContactIdVsMeetingCode.put(rec.Attendee__c, rec.Meeting_Code__c);
        }
        System.debug('mpOfContactIdVsMeetingCode: '+mpOfContactIdVsMeetingCode);
        for(Contact con : Trigger.New) {
            // Send an email using the Messaging.SingleEmailMessage class
            OrgWideEmailAddress owea = [select Id from OrgWideEmailAddress LIMIT 1];
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setOrgWideEmailAddressId(owea.Id);
            System.debug('owea: '+owea.Id);
            // Set the recipient's email address (replace with the actual email address)
            String[] toAddresses = new String[]{con.Email};
                mail.setToAddresses(toAddresses);
            mail.setSubject('Registration Successful');
            String fullUrl = 'https://college-17e-dev-ed.develop.my.site.com/qr/s/?event='+eventRecord.Name+'&userId='+con.UserId__c;
            fullUrl.replace('', '%3D');
            // Create the email body as HTML content
            String emailBody = '<html><body>';
            emailBody += 'Hi '+con.LastName+',';
            emailBody += '<br/><br/>';
            emailBody += 'Thanks for the Registration. Here is the following information:';
            emailBody += '<br/><br/>';
            emailBody += 'Your UserId is: <b>'+con.UserId__c+'</b>';
            emailBody += '<br/>';
            emailBody += 'Your Meeting Code: '+mpOfContactIdVsMeetingCode.get(con.Id);
            emailBody += '<br/>';
            emailBody += 'Your URL to visit Application : ';
            emailBody += '<a href="'+fullUrl+'">Click here to view</a>';
            emailBody += '<br/><br/>';
            emailBody += 'Thanks,';
            emailBody += '<br/>';
            emailBody += 'Zordial Labs';
            emailBody += '</body></html>';
            system.debug('url:          '+fullUrl);
            System.debug('htmlBody: '+emailBody);
            mail.setHtmlBody(emailBody);
            System.debug('--mail-->>'+mail);
            // Send the email
            Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});
        }
    }
}