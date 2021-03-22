public with sharing class RepairTriggerHandler extends TriggerHandler{
    public override void beforeInsert(){
        for(Repair__c repair : (List<Repair__c>) Trigger.New){
            repair.Status__c = 'To do';
        }
    }

    public override void beforeUpdate(){
        Map <Id, Repair__c> oldRepairsMap = (Map<Id, Repair__c>) Trigger.oldMap;
        Map <Id, Repair__c> newRepairsMap = (Map<Id, Repair__c>) Trigger.newMap;

        for(Repair__c repair : (List<Repair__c>) Trigger.New){
            if(oldRepairsMap.get(repair.Id).Status__c == 'To do' && newRepairsMap.get(repair.Id).Status__c == 'In progress'){
                repair.Start_Date__c = System.today();
            }
            else if(oldRepairsMap.get(repair.Id).Status__c == 'In progress' && newRepairsMap.get(repair.Id).Status__c == 'Done'){
                repair.End_Date__c = System.today();
            }
        }
    }
}