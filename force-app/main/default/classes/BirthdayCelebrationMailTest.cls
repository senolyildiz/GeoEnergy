@IsTest
public class BirthdayCelebrationMailTest {
    @IsTest
    static void testBirthdayCelebrationMailBatch() {
        // Create test data - Contact records with matching birthdays
        List<Contact> testContacts = new List<Contact>();
        Integer day = Date.today().day();
        Integer month = Date.today().month();
        for (Integer i = 0; i < 5; i++) {
            Contact c = new Contact(
                FirstName = 'TestFirstName' + i,
                LastName = 'TestLastName' + i,
                Email = 'test' + i + '@example.com',
                Birthdate = Date.newInstance(2020, month, day)
            );
            testContacts.add(c);
        }
        insert testContacts;

        Test.startTest();

        // Start the batch job
        BirthdayCelebrationMail batchJob = new BirthdayCelebrationMail();
        Database.executeBatch(batchJob);

        Test.stopTest();

        // Verify that emails were sent to the test contacts
        List<EmailMessage> sentEmails = [SELECT Id, ToAddress, Subject, TextBody FROM EmailMessage WHERE ToAddress LIKE 'test%@example.com'];
        System.assertEquals(5, sentEmails.size());
        for (Integer i = 0; i < 5; i++) {
            Contact c = testContacts[i];
            EmailMessage email = sentEmails[i];
            System.assertEquals(c.Email, email.ToAddress);
            System.assertEquals('Happy Birthday ' + c.FirstName + ' ' + c.LastName + '!', email.Subject);
            System.assertEquals('As a Silverline family, we wish you a very happy birthday and send you best wishes for much happiness in your life!', email.TextBody);
        }
    }
}