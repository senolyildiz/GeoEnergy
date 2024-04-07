@isTest
public class LeadTriggerHandlerTest {
    
    @isTest
    private static void stateAddressFieldfromCustomStatePicklistTest(){
        
        Lead ld = new Lead();
        ld.LastName = 'Test trigger';
        ld.LeadSource = 'Website';
        ld.State__c = 'CA: California';
        insert ld;
        
        Lead insertLd = [SELECT State FROM Lead WHERE id=:ld.Id];
        system.assertEquals('CA', insertLd.State);
        system.assertNotEquals('CD', insertLd.State);
        
        ld.State__c = 'AL: Alabama';
        update ld;
       
        
        Lead updateLd = [SELECT State FROM Lead WHERE id=:ld.Id];
        system.assertEquals('AL', updateLd.State);
        system.assertNotEquals('AD', updateLd.State);
        
        
       
        
    }
    

}