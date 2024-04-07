@isTest
private class getProductRecordsFromERPTest {
    @isTest
    static void testGetProducts() {
        // Create a mock HTTP callout
        Test.setMock(HttpCalloutMock.class, new getProductRecordsFromERPMock());

        // Call the retrieveProduct method
        Test.startTest();
        getProductRecordsFromERP.getProducts();
        Test.stopTest();

        // Verify the product insertion
        List<Product2> insertedProducts = [SELECT Name FROM Product2];
        System.assertEquals(1, insertedProducts.size());
        System.assertEquals('Test Product1', insertedProducts[0].Name);
    }

    // Custom mock class to simulate the HTTP response
    private class getProductRecordsFromERPMock implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest request) {
            // Create a mock HTTP response
            HttpResponse mockResponse = new HttpResponse();
            mockResponse.setStatusCode(200);
            mockResponse.setBody('{"prodList":[{"wheelDrive":"Front-Wheel Drive","unitPrice":100.00,"productName":"Test Product1","productERPId":"01t78000000eME6AAM","productCode":"112233","isActive":true,"gear":"Manual","fuelType":"Diesel","engineCapacity":"1000 to 1500","description":"TESTTT","bodyType":"Sedan"}]}');
            return mockResponse;
        }
    }
}
/*In this updated test class, we have defined a custom inner class getProductRecordsFromERPMock that implements the HttpCalloutMock interface. The respond method in the mock class returns a mock HTTP response with a sample JSON body.

By using the custom mock class getProductRecordsFromERPMock, we can simulate the HTTP callout and test the getProducts method. This allows us to control the response and verify the behavior of the code under test.

Please replace the getProductRecordsFromERPMock class and adjust the test assertions as per your specific requirements.
*/