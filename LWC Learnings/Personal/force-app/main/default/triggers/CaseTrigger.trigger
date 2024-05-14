trigger CaseTrigger on Case (before update) {
    if(Trigger.isBefore && Trigger.isUpdate) {
        // CaseTriggerHelper.calculateHolidays(Trigger.New);
        //------------Making change inside Trogger itself ------------------------------------------------- 
        for(Case cs : Trigger.New) {
            if(cs.Status == 'Closed') {
                Date aajKaDate = Date.Today();
                Date d = cs.CreatedDate.date();
                Integer totalDays = aajKaDate.daysBetween(d);
                System.debug('totalDays::'+totalDays);
                cs.EngineeringReqNumber__c = String.valueOf(Math.abs(totalDays));
                // updateList.add(new Case(Id = cs.Id,EngineeringReqNumber__c = String.valueOf(Math.abs(totalDays))));
            }
        }
    }
}