@isTest
public class LMSControllerTest {
    
    @isTest
    static void saveContactTest() {
        String[] profile = new String[]{'Developer'};
        String[] Interest = new String[]{'Developer'};
        
        List<Contact> lstOfContact = LMSController.saveRegistration('Test','test@gmail.com','abc@linkedin.com',profile,Interest);
        System.assertEquals(lstOfContact != null, true);
        
        
    }
}