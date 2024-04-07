@isTest
public class DataFactory {
    public static Opportunity createOpportunity(){
       Opportunity opp = new Opportunity();
       opp.Name= 'test';
       opp.CloseDate = Date.today() +2;
       opp.StageName='New';
       
        return opp;
    }
    
}