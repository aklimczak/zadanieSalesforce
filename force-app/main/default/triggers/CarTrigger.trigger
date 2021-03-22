trigger CarTrigger on Car__c (before insert) {

    new CarTriggerHandler().run();
}