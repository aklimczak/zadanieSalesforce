@isTest
public with sharing class RepairTriggerHandlerTests {
    @TestSetup
    public static void makeData(){
        Car__c car = TestDataFactory.createCars(1, 2005, date.newInstance(2020, 7, 13), date.newInstance(2021, 8, 13), 100000, 50000).get(0);
        insert car;

    }
    
    @isTest
    private static void shouldChangeStatusToToDo(){

        Car__c car = [SELECT Id FROM Car__c LIMIT 1];
        List<Repair__c> repairsToAdd = TestDataFactory.createRepairs(10, car.Id, 'In progress', 'reason', 10000);
        System.Test.startTest();
            List<Database.SaveResult> results = Database.insert(repairsToAdd);
        System.Test.stopTest();

        System.assertEquals(10, [SELECT COUNT() FROM Repair__c WHERE Status__c='To do']);
    }

    @isTest
    private static void shouldSetInProgressStartDate(){
        Car__c car = [SELECT Id FROM Car__c LIMIT 1];
        List<Repair__c> repairsToAdd = TestDataFactory.createRepairs(10, car.Id, 'In progress', 'reason', 10000);
        List<Repair__c> repairsToUpdate = new List<Repair__c>();
        insert repairsToAdd;

        System.Test.startTest();
            for(Repair__c repair : [SELECT Status__c FROM Repair__c]){
                repair.Status__c = 'In progress';
                repairsToUpdate.add(repair);
            }
            update repairsToUpdate;
        System.Test.stopTest();

        System.assertEquals(10, [SELECT COUNT() FROM Repair__c WHERE Start_Date__c = :System.today()]);
    }

    @isTest
    private static void shouldSetDoneEndDate(){
        Car__c car = [SELECT Id FROM Car__c LIMIT 1];
        List<Repair__c> repairsToAdd = TestDataFactory.createRepairs(10, car.Id, 'In progress', 'reason', 10000);
        List<Repair__c> repairsToUpdate = new List<Repair__c>();
        insert repairsToAdd;
        update TestDataFactory.changeRepairsStatusToInProgress([SELECT Status__c FROM Repair__c]);

        System.Test.startTest();
            for(Repair__c repair : [SELECT Status__c FROM Repair__c]){
                repair.Status__c = 'Done';
                repairsToUpdate.add(repair);
            }
            update repairsToUpdate;
        System.Test.stopTest();

        System.assertEquals(10, [SELECT COUNT() FROM Repair__c WHERE End_Date__c = :System.today()]);
    }
}