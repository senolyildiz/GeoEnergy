public with sharing class AssetProductControllerLWC {
    
        @AuraEnabled(cacheable=true)
        public static List<AssetProductListWrapper> getAssetAndProduct(){
            
            List<AssetProductListWrapper> assPrdWrapperList = new List<AssetProductListWrapper>();
            List<Asset> assAndPrdList = [SELECT Id, SerialNumber, Interior_Color__c, Exterior_Color__c, Product2.Name
                                        FROM Asset
                                        WHERE Opportunity__c = NULL];
            try {
                
                if(!assAndPrdList.isEmpty()){
                    for(Asset ap : assAndPrdList){
                        AssetProductListWrapper assetProductWrapper  = new AssetProductListWrapper();
                        assetProductWrapper.assetId = ap.Id;
                        assetProductWrapper.serialNumber = ap.SerialNumber;
                        assetProductWrapper.interiorColor = ap.Interior_Color__c;
                        assetProductWrapper.exteriorColor = ap.Exterior_Color__c;
                        assetProductWrapper.productName = ap.Product2.Name;
                        assPrdWrapperList.add(assetProductWrapper);
                    }
                }
                
                return assPrdWrapperList;
    
            } catch (Exception e) {
                throw new AuraHandledException(e.getMessage());
            }
        }

        public class AssetProductListWrapper{
            @AuraEnabled
            public Id assetId{get; set;}
            @AuraEnabled
            public String serialNumber{get; set;}
            @AuraEnabled
            public String interiorColor{get; set;}
            @AuraEnabled
            public String exteriorColor{get; set;}
            @AuraEnabled
            public String productName{get; set;}
    }

    @AuraEnabled
    public static Integer linkOppToAssets(Id oppId, List<AssetProductListWrapper> assPrdList){

        Integer response;

        if(assPrdList != null){

            try {

                Set<Id> assetIds = new Set<Id>();

                for(AssetProductListWrapper astFromLWC : assPrdList){
                    assetIds.add(astFromLWC.assetId);
                }

                List<Asset> assetsToUpdate = [SELECT Id, Opportunity__c
                                            FROM Asset
                                            WHERE Id IN :assetIds];
            

                for(Asset ast : assetsToUpdate){
                    ast.Opportunity__c = oppId;
                }

                update assetsToUpdate;

                for(Asset ast : assetsToUpdate){
                    if(ast.Opportunity__c == null){
                        response = 0;
                    }else{
                        response = 1;
                    }
                }
                
            } catch (Exception e) {
                throw new AuraHandledException(e.getMessage());
            }
        }

        return response;
    }
}