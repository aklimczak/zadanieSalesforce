public class CarUpdateBatchScheduler implements Schedulable{
    public void execute(SchedulableContext ctx){
        Database.executeBatch(new CarUpdateBatch());
    }
}
