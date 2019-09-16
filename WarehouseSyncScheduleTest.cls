@isTest
global class WarehouseSyncScheduleTest {
	public static String CRON_EXP = '0 0 0 15 3 ? 2022';
    
    static testmethod void testScheduledJob() {
         List<Case> maintenances = new List<Case>();
        List<Vehicle__c> veiculo = new List<Vehicle__c>();
        
        
        Product2 newProd1 = new Product2();
        newProd1.Name = 'Teste prod 1';
        newProd1.Replacement_Part__c = true;
        newProd1.Current_Inventory__c = 33;
        newProd1.Maintenance_Cycle__c = 22;
        newProd1.Lifespan_Months__c = 4;
        newProd1.Cost__c = 25;
        newProd1.Warehouse_SKU__c = '100015';
        insert newProd1;
        
        Product2 newProd2 = new Product2();
        newProd2.Name = 'Teste prod 3';
        newProd2.Replacement_Part__c = true;
        newProd2.Current_Inventory__c = 22;
        newProd2.Maintenance_Cycle__c = 4;
        newProd2.Lifespan_Months__c = 2;
        newProd2.Cost__c = 45;
        newProd2.Warehouse_SKU__c = '100016';
        insert newProd2;
        
        Product2 newProd3 = new Product2();
        newProd3.Name = 'Teste prod 3';
        newProd3.Replacement_Part__c = true;
        newProd3.Current_Inventory__c = 22;
        newProd3.Maintenance_Cycle__c = 4;
        newProd3.Lifespan_Months__c = 2;
        newProd3.Cost__c = 45;
        newProd3.Warehouse_SKU__c = '100016';
        insert newProd3;
        
        for(integer i = 0;i<300;i++){
            Vehicle__c veic = new Vehicle__c(Name='test'+i);
            veiculo.add(veic);
        }
        
        insert veiculo;
        
        for(integer i = 0;i<300;i++){
            if(i <= 100){
                Case maintenance = new Case(Vehicle__c = veiculo[i].Id,
                                       Equipment__c = newProd1.Id,
                                       Type = 'Routine Maintenance',
                                       Subject = 'XXX',
                                       Date_Reported__c = date.today(),
                                       Status = 'Closed');
            	maintenances.add(maintenance);
            }else if(i>100 && i<199){
                Case maintenance = new Case(Vehicle__c = veiculo[i].Id,
                                       Equipment__c = newProd2.Id,
                                       Type = 'Routine Maintenance',
                                       Subject = 'XXX',
                                       Date_Reported__c = date.today(),
                                       Status = 'Closed');
            	maintenances.add(maintenance);
            }else if(i>199){
                Case maintenance = new Case(Vehicle__c = veiculo[i].Id,
                                       Equipment__c = newProd3.Id,
                                       Type = 'Routine Maintenance',
                                       Subject = 'XXX',
                                       Date_Reported__c = date.today(),
                                       Status = 'Closed');
            	maintenances.add(maintenance);
            }
        }
        
        insert maintenances;
        update maintenances;

        Test.startTest();
        String jobId = System.schedule('ScheduledApexTest',
            CRON_EXP, 
            new WarehouseSyncSchedule());         
        Test.stopTest();
    }
}