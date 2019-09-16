@isTest
private class WarehouseCalloutServiceTest {
  	@isTest 
    static void testWarehouseCalloutService() {
        Test.setMock(HttpCalloutMock.class, new WarehouseCalloutServiceMock()); 
        test.startTest();
        WarehouseCalloutService.runWarehouseEquipmentSync();
        test.stopTest();
	}
}