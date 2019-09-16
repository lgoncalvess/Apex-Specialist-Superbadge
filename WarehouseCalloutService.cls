public with sharing class WarehouseCalloutService {

    private static final String WAREHOUSE_URL = 'https://th-superbadge-apex.herokuapp.com/equipment';
    
    // complete this method to make the callout (using @future) to the
    // REST endpoint and update equipment on hand.
    @future(callout=true)
    public static void runWarehouseEquipmentSync(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(WAREHOUSE_URL);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
	    List<Product2> equipment = new List<Product2>();  
        
        if(response.getStatusCode() == 200){
            List<Object> result = (List<Object>)JSON.deserializeUntyped(response.getBody());
            
            for(Object a : result){
                map<String, Object> eqp = (Map<String,Object>) a;
               	Product2 newProd = new Product2();
                newProd.Name = (String) eqp.get('name');
                newProd.Replacement_Part__c = true;
                newProd.Current_Inventory__c = (Integer) eqp.get('quantity');
                newProd.Maintenance_Cycle__c = (Integer) eqp.get('maintenanceperiod');
                newProd.Lifespan_Months__c = (Integer) eqp.get('lifespan');
                newProd.Cost__c = (Double) eqp.get('cost');
                newProd.Warehouse_SKU__c = (String) eqp.get('sku');
                equipment.add(newProd);
            }          
        }
        upsert equipment;
    }

}