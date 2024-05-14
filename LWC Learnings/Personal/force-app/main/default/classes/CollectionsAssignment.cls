public class CollectionsAssignment {
    
    public static void listOperations() {
        
        List<String> fruits = new List<String>();
        List<String> allFruits = new List<String>();        
        fruits.add('Apple');
        fruits.add('Banana');
        fruits.add('Orange');
        fruits.add('Apple');
        fruits.add('Grapes');

        // Removing the Duplicate Strings from List
        for(Integer i=0;i<fruits.size()-1;i++) {
            for(integer j = i+1;j<fruits.size();j++) {
                if(fruits[i] == fruits[j])
                    fruits.remove(j);
                
            }
        }
        
        System.debug('After Removing Duplicated from Fruits ='+ allFruits );
        
        Set<Integer> productIds = new Set<Integer>();
        
        productIds.add(101);
        productIds.add(102);
        productIds.add(103);
        productIds.add(104);
        productIds.add(105);
        
        System.debug('Before adding duplicate ID: ' + productIds.size());
        
        // Add one duplicate product ID 
        productIds.add(101); 
        productIds.add(101);        
        System.debug('After adding duplicate ID: ' + productIds.size());
    }
}