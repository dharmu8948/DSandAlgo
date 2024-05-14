@isTest
public class DeleteTaskTriggerByAdminTest {
    @TestSetup
    public static void TestData() {
        Task tsk = new Task();
        tsk.OwnerId = UserInfo.getUserId();
        tsk.Priority = 'High';
        tsk.Status = 'In Progress';
        insert tsk;
    }
    
    @IsTest
    public static void deleteTest(){
        Task rec = [Select Id, Priority From Task where Priority='High'];
        delete rec;
    }
}