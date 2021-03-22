trigger RepairTrigger on Repair__c (before insert, before update) {

    new RepairTriggerHandler().run();
}