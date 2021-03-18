public class CarUpdateBatch implements Database.Batchable<sObject> {
    
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('SELECT Id, Days_Until_Insurance_s_End__c, Days_Until_Next_Car_Review__c, ' + 
                                    'Does_Need_Timing_Replacement__c, Last_Car_Review_Date__c, Insurance_Expiry_Date__c, Status__c FROM Car__c');
    }

    public static void execute(Database.BatchableContext bc, List<Car__c> scope){
        List<Car__c> carsToUpdate = new List<Car__c>();

        for(Car__c car : scope){
            car.Days_Until_Next_Car_Review__c = System.today().daysBetween(car.Last_Car_Review_Date__c.addYears(1));
            car.Days_Until_Insurance_s_End__c = System.today().daysBetween(car.Insurance_Expiry_Date__c);

            if(car.Days_Until_Insurance_s_End__c <= 0 && car.Does_Need_Timing_Replacement__c == 'ZDECYDOWANIE TAK'){
                car.Status__c = 'Probably dead';
            }
            else if(car.Does_Need_Timing_Replacement__c == 'ZDECYDOWANIE TAK'){
                car.Status__c = 'Need a repair';
            }
            else if(car.Days_Until_Insurance_s_End__c <= 0){
                car.Status__c = 'Need a review';
            }

            System.debug('yyyy ' + car.Status__c);
            carsToUpdate.add(car);
        }
        update carsToUpdate;
    }

    public static void finish(Database.BatchableContext bc){}
}
