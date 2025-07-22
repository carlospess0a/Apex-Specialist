public with sharing class MaintenanceRequestHelper {
    static List<String> allowedTypesForMaintenance = new List<String>{'Repair', 'Routine Maintenance'};

    public static void createFutureMaintenance(List<Case> cases, Map<Id, Case> oldCasesById){
        List<Case> casesForRoutine = getCasesForRoutineMaintenance(cases, oldCasesById);
        Map<Id, List<Equipment_Maintenance_Item__c>> equipmentsByCaseId = getEquipmentMaintenanceByCaseId(casesForRoutine);
        
        List<Case> clonedCases = getClonedCases(casesForRoutine, equipmentsByCaseId);
        if(clonedCases.isEmpty()){
            return;
        }

        cloneAndInsertEquipmentsFromCases(clonedCases, equipmentsByCaseId);
    }

    private static void cloneAndInsertEquipmentsFromCases(List<Case> clonedCases, Map<Id, List<Equipment_Maintenance_Item__c>> equipmentsByCaseId){
        List<Equipment_Maintenance_Item__c> clonedEquipments = new List<Equipment_Maintenance_Item__c>();
        for(Case clonedCase : clonedCases){
            List<Equipment_Maintenance_Item__c> equipments = equipmentsByCaseId.get(clonedCase.ParentId);
            if(equipments == null || equipments.isEmpty()){
                continue;
            }

            for(Equipment_Maintenance_Item__c equip : equipments){
                Equipment_Maintenance_Item__c clonedEquip = equip.clone(false, true, false, false);
                clonedEquip.Maintenance_Request__c = clonedCase.Id;
                clonedEquipments.add(clonedEquip);
            }
        }

        if(!clonedEquipments.isEmpty()){
            insert clonedEquipments;
        }
    }

    private static List<Case> getClonedCases(List<Case> casesForRoutine, Map<Id, List<Equipment_Maintenance_Item__c>> equipmentsByCaseId){
        List<Case> clonedCases = new List<Case>();
        for(Case maintenanceRequest : casesForRoutine){
            Case clonedCase = maintenanceRequest.clone(false, true, false, false);
            clonedCase.Status = 'New';
            clonedCase.Date_Reported__c = Date.today();
            clonedCase.Subject = 'Maintenance Request';
            clonedCase.Type = 'Routine Maintenance';
            clonedCase.Date_Due__c = getNextMaintenanceDate(equipmentsByCaseId.get(maintenanceRequest.Id));
            clonedCase.ParentId = maintenanceRequest.Id;
            clonedCases.add(clonedCase);
        }

        if(!clonedCases.isEmpty()){
            insert clonedCases;
        }

        return clonedCases;
    }

    private static Date getNextMaintenanceDate(List<Equipment_Maintenance_Item__c> equipments){
        if(equipments.isEmpty()){
            return Date.today();
        }

        Decimal lowestCycle = equipments[0].Equipment__r.Maintenance_Cycle__c;
        for(Equipment_Maintenance_Item__c equip : equipments){
            if(equip.Equipment__r.Maintenance_Cycle__c < lowestCycle){
                lowestCycle = equip.Equipment__r.Maintenance_Cycle__c;
            }
        }

        return Date.today().addDays(lowestCycle.intValue());
    }

    private static Map<Id, List<Equipment_Maintenance_Item__c>> getEquipmentMaintenanceByCaseId(List<Case> casesForRoutine){
        List<Equipment_Maintenance_Item__c> equipments = [
            SELECT
                Id,
                Equipment__c,
                Equipment__r.Maintenance_Cycle__c,
                Quantity__c,
                Maintenance_Request__c
            FROM
                Equipment_Maintenance_Item__c
            WHERE
                Maintenance_Request__c IN: casesForRoutine
        ];

        
        Map<Id, List<Equipment_Maintenance_Item__c>> equipmentsByCaseId = new Map<Id, List<Equipment_Maintenance_Item__c>>();
        for(Equipment_Maintenance_Item__c equip : equipments){
            if(!equipmentsByCaseId.containsKey(equip.Maintenance_Request__c)){
                equipmentsByCaseId.put(
                    equip.Maintenance_Request__c,
                    new List<Equipment_Maintenance_Item__c>()
                );
            }

            equipmentsByCaseId.get(equip.Maintenance_Request__c).add(equip);
        }

        return equipmentsByCaseId;
    }

    private static List<Case> getCasesForRoutineMaintenance(List<Case> cases, Map<Id, Case> oldCasesById){
        List<Case> casesForRoutine = new List<Case>();
        for(Case maintenanceRequest : cases){
            Case oldCase = oldCasesById.get(maintenanceRequest.Id);
            if(oldCase.Status == maintenanceRequest.Status){
                continue;
            }

            if(maintenanceRequest.Status != 'Closed'){
                continue;
            }

            if(!allowedTypesForMaintenance.contains(maintenanceRequest.Type)){
               continue;
            }

            casesForRoutine.add(maintenanceRequest);
        }

        return casesForRoutine;
    }
}