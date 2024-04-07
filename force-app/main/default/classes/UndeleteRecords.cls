public class UndeleteRecords{
public class FlowInputs {
        @InvocableVariable public String sobjectType;
        @InvocableVariable public List<Id> recordIds;
    }
    
    @InvocableMethod(label='Undelete Records')
    public static void undeleteAllRecords(List<FlowInputs> params){
        List<Id> allIds= new List<Id> (); 
        for (String eachid:params[0].recordIds){
            allIds.add(eachid);   
        }
        String query = 'SELECT Id FROM ' + params[0].sobjectType + ' WHERE Id IN :allIds ALL ROWS';
        system.debug(query);
        List<sObject> deletedRecords = Database.query(query);
        if (!deletedRecords.isEmpty()) {
            undelete deletedRecords;
        }
    }
}