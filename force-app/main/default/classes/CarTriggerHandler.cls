public class CarTriggerHandler extends TriggerHandler{

    public override void beforeInsert(){
        for(Car__c car : (List<Car__c>) Trigger.New){
            car.Days_Until_Next_Car_Review__c = System.today().daysBetween(car.Last_Car_Review_Date__c.addYears(1));
            car.Days_Until_Insurance_s_End__c = System.today().daysBetween(car.Insurance_Expiry_Date__c);
        }
    }
}
