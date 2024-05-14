trigger AccountDeleteTrigger on Account (before delete) {
    Set<String> accountIds = new Set<String>();
    for(Account acc : Trigger.Old) {
        accountIds.add(acc.Id);
    }
    List<Account> accountList = [Select Id, (Select Id FROM Contacts where AccountId IN: accountIds) FROM Account WHERE ID IN:accountIds];
    Map<String, Integer> mpOfAccountVsContactCount = new Map<String, Integer>();
    for(Account acc : accountList) {
        mpOfAccountVsContactCount.put(acc.Id, acc.Contacts.size());
    }
    for(Account acc : Trigger.Old) {
        if(mpOfAccountVsContactCount.get(acc.Id) > 0) {
            acc.addError('You cannot delete this account, because it is associated with an Contact');
        }
    }
}