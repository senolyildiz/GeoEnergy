public class LeadTriggerHandler {
    
    public static void stateAddressFieldfromCustomStatePicklist(List<Lead> leadList){
        
         for(Lead ld : leadList){
                
                if(ld.LeadSource == 'Website' && ld.State__c!=null){
                
              String str = ld.State__c;
              List<String> strList = str.split(':');
              ld.State = strList[0];
                    
             // ld.State = ld.State__c.substring(0, 2);
                    
               
            }
        
        
        }
        
    }

}