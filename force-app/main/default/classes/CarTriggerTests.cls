@isTest
public with sharing class CarTriggerTests {

    @isTest
    private static void shouldCalculateDaysUntilInsuranceExpiryAndCarReview(){

        List<Car__c> carsToAdd = new List<Car__c>();
        Date carReview = date.newInstance(2020, 7, 13);
        Date insuranceEnd = date.newInstance(2021, 8, 13);

        for(Integer i=0; i<10; i++){
    
            carsToAdd.add(new Car__c(Name='car ' + i, Production_Year__c=2005, Last_Car_Review_Date__c=carReview,
                                Insurance_Expiry_Date__c = insuranceEnd, Mileage__c=100000));
    
        }
        
        System.Test.startTest();
            List<Database.SaveResult> results = Database.insert(carsToAdd, false);
        System.Test.stopTest();
        
        Integer daysUntilCarReview = System.today().daysBetween(carReview.addYears(1));
        Integer daysUntilInsuraceEnd = System.today().daysBetween(insuranceEnd);

        for(Database.SaveResult res : results){
            System.assert(res.isSuccess());
        }
        
        System.assertEquals(10, [SELECT COUNT() FROM Car__c WHERE Days_Until_Next_Car_Review__c = :daysUntilCarReview AND Days_Until_Insurance_s_End__c = :daysUntilInsuraceEnd]);
    }
}
