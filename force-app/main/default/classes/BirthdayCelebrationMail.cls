global class BirthdayCelebrationMail implements Database.Batchable<sObject> {
    global Database.QueryLocator start(Database.BatchableContext BC) {
        // Query the contacts whose birthdays match the current date
        Integer day = Date.today().day();
        Integer month = Date.today().month();
        String query = 'SELECT Id, LastName, FirstName, Email, Birthdate FROM Contact WHERE Email!=null AND DAY_IN_MONTH(Birthdate) = :day AND CALENDAR_MONTH(Birthdate) = :month';
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<Contact> scope) {
        // Send the birthday emails to the contacts in the current batch
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        for (Contact contact : scope) {
            try {
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setToAddresses(new List<String>{contact.Email});
                email.setSubject('Happy Birthday ' + contact.FirstName + ' ' + contact.LastName + '!');
                email.setPlainTextBody('As a Silverline family, we wish you a very happy birthday and send you best wishes for much happiness in your life!');
                emails.add(email);
            } catch (Exception e) {
                // Handle the exception or log the error message
                System.debug('An error occurred while creating an email: ' + e.getMessage());
            }
        }
        
        Messaging.SendEmailResult[] results = Messaging.sendEmail(emails);
        
        for (Messaging.SendEmailResult result : results) {
            if (result.Success) {
                System.debug('The email was successfully sent by Batch Apex');
            } else {
                System.debug('The email failed to send: ' + result.getErrors());
            }
        }
    }

    global void finish(Database.BatchableContext context) {
        // Perform any post-processing or cleanup tasks if needed
    }

    global void execute(SchedulableContext sc) {
        BirthdayCelebrationMail b = new BirthdayCelebrationMail();
        Database.executeBatch(b);
    }
}