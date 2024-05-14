public class CaseTriggerHelper {
    public static void calculateHolidays(List<Case> caseList) {
        List<Case> updateList = new List<Case>();
        for(Case cs : caseList) {
            if(cs.Status == 'Closed') {
                Date aajKaDate = Date.Today();
                Date d = cs.CreatedDate.date();
                Integer totalDays = aajKaDate.daysBetween(d);
                System.debug('totalDays::'+totalDays);
                cs.EngineeringReqNumber__c = String.valueOf(Math.abs(totalDays));
                updateList.add(new Case(Id = cs.Id,EngineeringReqNumber__c = String.valueOf(Math.abs(totalDays))));
            }
        }
        System.debug('updateList:: '+updateList);
        Database.update(updateList);
    }
}