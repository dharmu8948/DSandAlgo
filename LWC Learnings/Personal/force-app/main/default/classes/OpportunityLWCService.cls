/**
 * @description       : Demostration of Decorator Design Pattern
 * @author            : Dharmendra Kumar
 * @group             : 
 * @last modified on  : 12-March-2024
 * @last modified by  : Dharmendra Kumar
**/

/*
 * Execute below snippet From Annanymous window
 * 
    List<OpportunityLWCService.OpportunityWrapper> wrapper = OpportunityLWCService.getAllOpportunity();
    System.debug('wrapper: \n '+ JSON.serialize(wrapper) );
*/
public with sharing class OpportunityLWCService {

    private static void testOpportunity(){
        List<OpportunityWrapper> wrapper = OpportunityLWCService.getAllOpportunity();
        System.debug('wrapper: \n '+ JSON.serialize(wrapper) );
    }

    @AuraEnabled(cacheable = true)
    public static List<OpportunityWrapper> getAllOpportunity(){

        List<OpportunityWrapper> opportunityWrappers = new List<OpportunityWrapper>();

        for(Opportunity opp : [ SELECT Id, Name, AccountId, Account.Name, Amount, CloseDate
            FROM Opportunity LIMIT 10 ]){
            opportunityWrappers.add( new OpportunityWrapper(opp) );
        }
        return opportunityWrappers;
    }

    public class OpportunityWrapper {

        public Opportunity opportunityRecord { get; private set; }
        public Decimal amountInINR { get; private set; }
        public Decimal amountInEUR { get; private set; }
        public Decimal amountInAUD { get; private set; }

        public OpportunityWrapper(Opportunity opportunityRecord){
            this.opportunityRecord = opportunityRecord;
            this.amountInINR = opportunityRecord.Amount * 79; // convert to INR from USD
            this.amountInEUR = opportunityRecord.Amount * 0.75; // convert to EUR from USD
            this.amountInAUD = opportunityRecord.Amount * 1.31; // convert to AUD from USD
        }
        
    }

}