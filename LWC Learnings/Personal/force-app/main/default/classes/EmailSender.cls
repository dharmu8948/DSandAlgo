public with sharing class EmailSender {
    
    @AuraEnabled
    public static void sendEmail(String recipientEmail, String subject, String body, String url) {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String[]{recipientEmail});
        mail.setSubject(subject);
        mail.setPlainTextBody(body + '\n\nURL: ' + url);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});
    }
}