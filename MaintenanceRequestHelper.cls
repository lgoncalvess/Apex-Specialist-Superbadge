public class MaintenanceRequestHelper {
    
    public static void updateWorkOrders(List<Case> Maintenances){
        
        List<Case> MaintenanceRequest = new List<Case>();
        List<Id> ids = new List<Id>();
        
        for(Case c : Maintenances){
            if(c.Status == 'Closed' && (c.Type == 'Routine Maintenance' || c.Type == 'Repair')){
                ids.add(c.Equipment__c);
            }            
        }
        
        List<Product2> ciclos = [SELECT Id, Maintenance_Cycle__c FROM Product2 WHERE Id IN:ids];
        system.debug(Maintenances);
        for(Case cs : Maintenances){
            if(cs.Status == 'Closed' && (cs.Type == 'Routine Maintenance' || cs.Type == 'Repair')){
                Case newMaintenance = new Case();
                integer menor = 0;
                newMaintenance.Vehicle__c = cs.Vehicle__c;
                newMaintenance.Equipment__c = cs.Equipment__c;
                newMaintenance.Type = 'Routine Maintenance';
                newMaintenance.Subject = 'xxx';
                newMaintenance.Date_Reported__c = date.today();
                if(ciclos.size() > 1){
                    for(integer i = 0;i < ciclos.size();i++){
                        if(i>0){
                            if (ciclos[i].Maintenance_Cycle__c < menor){
                                menor = ciclos[i].Maintenance_Cycle__c.intValue();
                            }
                        }else{
                        	menor = ciclos[i].Maintenance_Cycle__c.intValue();
                        }
                    }
                    newMaintenance.Date_Due__c = Date.today().addDays(menor);
                }else{
                    menor = ciclos[0].Maintenance_Cycle__c.intValue();
                    newMaintenance.Date_Due__c = Date.today().addDays(menor);
                }
             	MaintenanceRequest.add(newMaintenance);
            }
        }
                
        insert MaintenanceRequest;
        
    }        
    
}