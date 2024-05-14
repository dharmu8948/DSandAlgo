public class DeactivateUser {
    @Future
    public static void deactivateUser(Set<Id> lstOfuser) {
        List<User> usersToUpdate = new List<User>();
        for(User u : [Select Id, IsActive, IsPortalEnabled from User where Id IN :lstOfuser]){
            if(u.IsActive || u.IsPortalEnabled ){
                u.IsActive = false;
                u.IsPortalEnabled = false;
                usersToUpdate.add(u);
            }
        }
        System.debug('usersToUpdate:: '+usersToUpdate);
        if (usersToUpdate.size()>0){
            System.debug('updating');
            update usersToUpdate;
        }
    }
}