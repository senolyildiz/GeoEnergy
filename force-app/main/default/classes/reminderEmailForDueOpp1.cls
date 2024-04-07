public class reminderEmailForDueOpp1 implements Database.Batchable<sObject> {
    public Database.QueryLocator start(Database.BatchableContext BC) {
             return Database.getQueryLocator([SELECT OwnerId, Name,isClosed, CloseDate, Owner.Name, Owner.Email
                                                 FROM Opportunity 
                                                 WHERE isClosed = false 
                                                 AND CloseDate = NEXT_N_DAYS:3]);
        
    }

    public void execute(Database.BatchableContext BC, List<Opportunity> oppList) {
        
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();

        for (Opportunity Opp : oppList) {
                
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

                    List<String> sendTo = new List<String>();
                    sendTo.add(opp.owner.Email);
                    mail.setToAddresses(sendTo);
                   
                    mail.setSubject(opp.Name  + 'Opportunity required action!' ); 
                    String body = 'Hello ' + opp.owner.Name + ',\n' +
                        opp.Name +'Opportunity has to be closed before ' + opp.CloseDate.format() + '.\n' +
                         'Please finalize your sales process.';
                  
                    mail.setplaintextbody(body);
                    mails.add(mail);
                
             }
                   Messaging.sendEmail(mails);
       try {
            update oppList;
            system.debug('success');

           } catch(Exception e) {
            System.debug(e);
          }
        }
     
    public void finish(Database.BatchableContext BC) {
 }     
    
    public void execute(SchedulableContext SC) {
      
      reminderEmailForDueOpp1 myBatchObject = new reminderEmailForDueOpp1(); 
      Id batchId = Database.executeBatch(myBatchObject);

   }
 }