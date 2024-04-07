@isTest
public class remainderEmailOppTest1 {
    
    @isTest
    Private static void remainderEmailTest(){
        
        Date todayPlusThree = Date.today() + 3;
        
        Opportunity opp = DataFactory.createOpportunity();
        opp.CloseDate = todayPlusThree;
        
        
        
       Test.startTest();
insert new List<Opportunity>{opp};        
         reminderEmailForDueOpp1 process = new reminderEmailForDueOpp1();
         Id batchId = database.executeBatch(process);
        
        Test.stopTest();
        

    }
}