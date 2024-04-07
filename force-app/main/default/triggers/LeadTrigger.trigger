trigger LeadTrigger on Lead (before insert , before update , before delete , 
			after insert , after update, after delete, after undelete) {

SWITCH on Trigger.operationType {
        
        WHEN BEFORE_INSERT  { 
        
        		LeadTriggerHandler.stateAddressFieldfromCustomStatePicklist(Trigger.new);

        }
        WHEN BEFORE_UPDATE  {
            
        		LeadTriggerHandler.stateAddressFieldfromCustomStatePicklist(Trigger.new);
            
        }
        WHEN BEFORE_DELETE  { }
        WHEN AFTER_INSERT   { }
        WHEN AFTER_UPDATE   { }
        WHEN AFTER_DELETE   { }
        WHEN AFTER_UNDELETE { }

 }
}