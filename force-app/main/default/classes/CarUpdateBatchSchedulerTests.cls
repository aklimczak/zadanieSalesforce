@isTest
public class CarUpdateBatchSchedulerTests {
    public static String CRON_EXP = '0 0 10 * * ?';

    @TestSetup
    static void makeData(){
        List<Car__c> carsProbablyDead = TestDataFactory.createCars(5, 2005, date.newInstance(2020, 7, 13), date.newInstance(2020, 8, 13), 300000, 50000);

        insert carsProbablyDead;
    }

    @isTest
    private static void testScheduler(){

        List<AsyncApexJob> jobsBeforeSchedulerExecute = [select Id, ApexClassID, ApexClass.Name, Status, JobType from AsyncApexJob];
        System.assertEquals(0, jobsBeforeSchedulerExecute.size());

        System.Test.startTest();
            System.schedule('TEST SCHEDULER', CRON_EXP, new CarUpdateBatchScheduler());
        System.Test.stopTest();
        
        List<AsyncApexJob> jobsAfterSchedulerExecute = [SELECT Id, ApexClassID, ApexClass.Name, Status, JobType FROM AsyncApexJob WHERE JobType = 'ScheduledApex'];
        System.debug('aftre execute: ' + jobsAfterSchedulerExecute);
        System.assertEquals(1, jobsAfterSchedulerExecute.size());    

        List<AsyncApexJob> jobsApexBatch = [SELECT Id, ApexClassID, ApexClass.Name, Status, JobType FROM AsyncApexJob WHERE JobType = 'BatchApex'];
        System.assertEquals(1, jobsApexBatch.size());
    }
}