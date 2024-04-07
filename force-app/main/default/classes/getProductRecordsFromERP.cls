public class getProductRecordsFromERP {
    @future(Callout=true)
    public static void getProducts(){
        
        HTTP h = new HTTP();
        HTTPRequest request =new HTTPRequest();
        
        request.setMethod('GET');
        request.setEndpoint('https://wisequarter1--erp.sandbox.my.salesforce.com/services/apexrest/ProductWebService');
        request.setHeader('Authorization', 'Bearer 00D780000008gDM!AQcAQDbdbzqIZGm6CPln_q7eHEci7VM2hE64xQGc4OnkFPxcuZydFhpar8RbT9HG_11POGlPDOXnptcmdptTmy2aY_g6HoaZ');
        request.setHeader('Content-Type', 'application/json; charset=utf-8');
        
        HTTPResponse response = h.send(request);
        String jsonBody = response.getBody();
        System.debug('jsonBody>> '+ jsonBody);
        /*jsonBody>> {"prodList":[{"wheelDrive":"Front-Wheel Drive","unitPrice":100.00,"productName":"Test Product1","productERPId":"01t78000000eME6AAM",
        "productCode":"112233","isActive":true,"gear":"Manual","fuelType":"Diesel","engineCapacity":"1000 to 1500","description":"TESTTT","bodyType":"Sedan
        */
       Map<string, Object> jsonBody1 =(Map<String, Object>)JSON.deserializeUntyped(response.getBody());
         System.debug('jsonBody1>>'+jsonBody1);

        /*jsonBody1>>{prodList=({bodyType=Sedan, description=TESTTT, engineCapacity=1000 to 1500, fuelType=Diesel, 
         * gear=Manual, isActive=true, productCode=112233, productERPId=01t78000000eME6AAM, productName=Test Product1, 
         * unitPrice=100.00, ...}, {bodyType=Sedan, description=Honda City is B segment, engineCapacity=1000 to 1500, 
         * fuelType=Gasoline, gear=Manual, isActive=true, productCode=HNCS157965, productERPId=01t78000000eYSoAAM, 
         * productName=Honda City 1.4, unitPrice=2000.00, ...}, {bodyType=Sedan, d
         */
        List<Object> JsonBodyList = (List<Object>)jsonBody1.get('prodList');
        System.debug('JsonBodyList>>'+JsonBodyList);
        /*JsonBodyList>>({bodyType=Sedan, description=TESTTT, engineCapacity=1000 to 1500, fuelType=Diesel, 
         * gear=Manual, isActive=true, productCode=112233, productERPId=01t78000000eME6AAM, productName=Test Product1,
         *  unitPrice=100.00, ...}, {bodyType=Sedan, description=Honda City is B segment, engineCapacity=1000 to 1500,
         *  fuelType=Gasoline, gear=Manual, isActive=true, productCode=HNCS157965, productERPId=01t78000000eYSoAAM,
         *  productName=Honda City 1.4, unitPrice=2000.00, ...}, {bodyType=Sedan, descript
         */
 
        List<Product2> productList =new List<product2>();
        for(Object o: JsonBodyList){
            Map<String,Object> mapobj = (Map<String,Object>)o;
            System.debug('mapobj>> '+ mapobj);
            Product2 product = new Product2();
            product.Wheel_Drive__c = (String)mapobj.get('wheelDrive');
            product.Name = (String)mapobj.get('productName');
            product.productERPId__c= (String)mapobj.get('productERPId');
            product.ProductCode= (String)mapobj.get('productCode');
            product.IsActive= true;
            product.Gear__c= (String)mapobj.get('gear');
            product.Fuel_Type__c= (String)mapobj.get('fuelType');
            product.Engine_Capacity_cc_c__c= (String)mapobj.get('engineCapacity');
            product.Description= (String)mapobj.get('description');
            product.Body_Type__c= (String)mapobj.get('bodyType');
            
			productList.add(product);       
        }
        	Database.insert(productList);
    }

}