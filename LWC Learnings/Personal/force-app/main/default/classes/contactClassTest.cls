@isTest
public class contactClassTest {
    
    @isTest
    public static void unitTest(){
        //insert data
        Account accr = new Account();
        accr.Name = 'trigger test class';
        insert accr;
        
        List <Contact> nList = new List<Contact>();
        Contact con = new Contact();
        con.AccountId = accr.Id;
        con.FirstName = 'Shyam';
        con.LastName = 'singh';
        con.Amount__c = 5;
        nList.add(con);
        
        
        Test.startTest();    
        insert con;
        //contactClass.contactAmountUpdate(nList);
        
        Test.stopTest();    
        
        // test the value now
        Account acc = [SELECT Id, Total_Contacts_Amount__c FROM Account WHERE Id =:con.AccountId];
        
        system.assertEquals(5,acc.Total_Contacts_Amount__c);
        
    }
    
    @isTest
    public static void unitTest1(){
        Account acc = new Account(Name = 'Test Account', Total_Contacts_Amount__c = 0);
        insert acc;
        
        Contact con1 = new Contact(LastName = 'Test1', AccountId = acc.Id, Amount__c = 100);
        //insert con1;
        Contact con2 = new Contact(LastName = 'Test2', AccountId = acc.Id, Amount__c = 100);
        insert new List<Contact>{con1, con2};
                
                // Call the method under test
                Test.startTest();
        delete con1;
        Test.stopTest();
        
        // Retrieve the updated Account record
        Account updatedAcc = [SELECT Total_Contacts_Amount__c FROM Account WHERE Id = :acc.Id];
        System.debug('updatedAcc::'+updatedAcc);
        // Verify that the Total_Contacts_Amount__c field is updated correctly
        System.assertEquals(100, updatedAcc.Total_Contacts_Amount__c, 'Total amount not updated correctly');
        
    }
    
}