@isTest
public class CarUpdateBatchTests {
    @TestSetup
    static void makeData(){

        List<Car__c> carsProbablyDead = TestDataFactory.createCars(5, 2005, date.newInstance(2020, 7, 13), date.newInstance(2020, 8, 13), 300000, 50000);
        List<Car__c> carsToReview = TestDataFactory.createCars(5, 2005, date.newInstance(2020, 7, 13), date.newInstance(2020, 8, 13), 100000, 50000);
        List<Car__c> carsToRepair = TestDataFactory.createCars(5, 2005, date.newInstance(2020, 7, 13), date.newInstance(2022, 8, 13), 300000, 50000);

        insert carsProbablyDead;
        insert carsToReview;
        insert carsToRepair;
    }

    @isTest
    public static void shouldUpdateStatusToNeedReview(){
        System.Test.startTest();
            Database.executeBatch(new CarUpdateBatch());
            System.assertEquals(0, [SELECT COUNT() FROM Car__c WHERE Status__c = 'Need a Review']);
        System.Test.stopTest();

        System.assertEquals(5, [SELECT COUNT() FROM Car__c WHERE Status__c = 'Need a Review']);
    }

    @isTest
    public static void shouldUpdateStatusToNeedRepair(){
        System.Test.startTest();
            Database.executeBatch(new CarUpdateBatch());
            System.assertEquals(0, [SELECT COUNT() FROM Car__c WHERE Status__c = 'Need a Repair']);
        System.Test.stopTest();

        System.assertEquals(5, [SELECT COUNT() FROM Car__c WHERE Status__c = 'Need a Repair']);
    }

    @isTest
    public static void shouldUpdateStatusToProbablyDead(){
        System.Test.startTest();
            Database.executeBatch(new CarUpdateBatch());
            System.assertEquals(0, [SELECT COUNT() FROM Car__c WHERE Status__c = 'Probably dead']);
        System.Test.stopTest();

    System.assertEquals(5, [SELECT COUNT() FROM Car__c WHERE Status__c = 'Probably dead']);
    }
}
