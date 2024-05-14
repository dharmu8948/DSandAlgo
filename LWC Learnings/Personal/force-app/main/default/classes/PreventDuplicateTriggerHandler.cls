public class PreventDuplicateTriggerHandler {
    public static void checkDuplicateRecord(List<Contact> lstOfContactRecords) {
        Set<String> contactRecords = new Set<String>();
        for(contact con : [Select Id, Email, Phone FROM Contact]) {
            String element = con.Email+'_'+con.Phone;
            contactRecords.add(element);
        }
        for(Contact con : lstOfContactRecords) {
            String element = con.Email+'_'+con.Phone;
            if(contactRecords.contains(element)) {
                con.addError('Duplicate Record found');
            }
        }
    }
}