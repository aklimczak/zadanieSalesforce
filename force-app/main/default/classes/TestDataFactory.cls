@isTest
public class TestDataFactory {
    public static List<Car__c> createCars(Integer numberOfCarsToCreate, Integer productionYear, Date lastCarReviewDate, Date insuranceExpiryDate, Integer mileage, Integer lastTimingReplacementMileage){
        List<Car__c> carsToCreate = new List<Car__c>();

        for(Integer i=0; i<numberOfCarsToCreate; i++){
                carsToCreate.add(new Car__c(Production_Year__c = productionYear, Last_Car_Review_Date__c=lastCarReviewDate,
                Insurance_Expiry_Date__c = insuranceExpiryDate, Mileage__c = mileage, Mileage_When_Last_Timing_Replacement__c = lastTimingReplacementMileage));   
        }
        return carsToCreate;

    }

    public static List<Repair__c> createRepairs(Integer numberOfRepairs, Id carId, String status, String reason, Integer cost){
        List<Repair__c> repairsToCreate = new List<Repair__c>();

        for(Integer i=0; i<numberOfRepairs; i++){
            repairsToCreate.add(new Repair__c(Name='repairName ' + i, Car__c=carId, Status__c=status, Reason__c=reason, Cost__c=cost));
        }
        return repairsToCreate;
    }

    public static List<Repair__c> changeRepairsStatusToInProgress(List<Repair__c> repairsToUpdate){
        for(Repair__c repair : repairsToUpdate){
            repair.Status__c = 'In progress';
        }
        return repairsToUpdate;
    }

}