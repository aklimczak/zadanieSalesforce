@isTest
public class CarUpdateBatchTests {
    @TestSetup
    static void makeData(){
        List<Car__c> carsToAdd = new List<Car__c>();
        Date carReview = date.newInstance(2020, 7, 13);
        Date insuranceEnd = date.newInstance(2020, 8, 13);

        for(Integer i=0; i<15; i++){
            if(i<5){
                carsToAdd.add(new Car__c(Name = 'car ' + i, Production_Year__c = 2005, Last_Car_Review_Date__c=carReview,
                Insurance_Expiry_Date__c = insuranceEnd.addYears(2), Mileage__c = 300000, Mileage_When_Last_Timing_Replacement__c = 5000));            
            }
            else if(i>=5 && i<10){
                carsToAdd.add(new Car__c(Name = 'car ' + i, Production_Year__c = 2005, Last_Car_Review_Date__c=carReview,
                Insurance_Expiry_Date__c = insuranceEnd, Mileage__c = 300000, Mileage_When_Last_Timing_Replacement__c = 5000));
            }
            else{
                carsToAdd.add(new Car__c(Name = 'car ' + i, Production_Year__c = 2005, Last_Car_Review_Date__c=carReview,
                Insurance_Expiry_Date__c = insuranceEnd, Mileage__c = 30000, Mileage_When_Last_Timing_Replacement__c = 5000));
            }
        }

        insert carsToAdd;
    }

    @isTest
    public static void shouldUpdateStatusToNeedReview(){
        System.Test.startTest();
            Database.executeBatch(new CarUpdateBatch());
        System.Test.stopTest();

        System.assertEquals(5, [SELECT COUNT() FROM Car__c WHERE Status__c = 'Need a Review']);
    }
    @isTest
    public static void shouldUpdateStatusToNeedRepair(){
        System.Test.startTest();
            Database.executeBatch(new CarUpdateBatch());
        System.Test.stopTest();

        System.assertEquals(5, [SELECT COUNT() FROM Car__c WHERE Status__c = 'Need a Repair']);
    }

    @isTest
    public static void shouldUpdateStatusToProbablyDead(){
        System.Test.startTest();
            Database.executeBatch(new CarUpdateBatch());
        System.Test.stopTest();

    System.assertEquals(5, [SELECT COUNT() FROM Car__c WHERE Status__c = 'Probably dead']);
    }
}
