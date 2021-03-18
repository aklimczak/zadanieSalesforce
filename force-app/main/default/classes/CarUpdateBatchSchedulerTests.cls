@isTest
public class CarUpdateBatchSchedulerTests {
    public static String CRON_EXP = '0 0 10 * * ?';

    @TestSetup
    static void makeData(){
        List<Car__c> carsToAdd = new List<Car__c>();
        Date carReview = date.newInstance(2020, 7, 13);
        Date insuranceEnd = date.newInstance(2020, 8, 13);

        for(Integer i=0; i<5; i++){
            carsToAdd.add(new Car__c(Name = 'car ' + i, Production_Year__c = 2005, Last_Car_Review_Date__c=carReview,
            Insurance_Expiry_Date__c = insuranceEnd, Mileage__c = 300000, Mileage_When_Last_Timing_Replacement__c = 5000));
        }
        insert carsToAdd;
    }

    @isTest
    private static void testScheduler(){
        System.Test.startTest();
            System.schedule('TEST SCHEDULER', CRON_EXP, new CarUpdateBatchScheduler());
            System.assertEquals(0, [SELECT COUNT() FROM Car__c WHERE Status__c = 'Probably dead']);
        System.Test.stopTest();

        System.assertEquals(5, [SELECT COUNT() FROM Car__c WHERE Status__c = 'Probably dead']);
    }
}
