@isTest
public with sharing class CarTriggerHandlerTests {
    @isTest
    private static void shouldCalculateDaysUntilInsuranceExpiryDateAndCarReview(){

        Date lastCarReviewDate = date.newInstance(2020, 7, 13);
        Date insuranceEndDate = date.newInstance(2021, 8, 13);

        List<Car__c> carsToAdd = TestDataFactory.createCars(10, 2005, lastCarReviewDate, insuranceEndDate, 100000, 50000);

        System.Test.startTest();
                List<Database.SaveResult> results = Database.insert(carsToAdd, false);
        System.Test.stopTest();
        
        Integer daysUntilNextCarReview = System.today().daysBetween(lastCarReviewDate.addYears(1));
        Integer daysUntilInsuraceEnd = System.today().daysBetween(insuranceEndDate);

        System.assertEquals(10, [SELECT COUNT() FROM Car__c WHERE Days_Until_Next_Car_Review__c = :daysUntilNextCarReview AND Days_Until_Insurance_s_End__c = :daysUntilInsuraceEnd]);
    }
}
