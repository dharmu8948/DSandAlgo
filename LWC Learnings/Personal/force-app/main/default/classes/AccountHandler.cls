global class AccountHandler {
    
    @AuraEnabled(Cacheable = true)
    public static List<Account> getAccount(String accountName) {
        List<Account> lstOfAccountRec = [Select Name, Id, Description From Account Where Name =:accountName];
        return lstOfAccountRec;
    }
}