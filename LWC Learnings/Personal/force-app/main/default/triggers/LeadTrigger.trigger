//Create a duplicate lead when a lead in insert.
trigger LeadTrigger on Lead (before insert) {
    if(checkRecursive.runOnce()) {
     List<Lead> leadList = new List<Lead>();   
     leadList = Trigger.new.deepClone();
     insert leadList; 
   }
}