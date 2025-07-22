trigger MaintenanceRequest on Case (before update, after update) {
    if(Trigger.isAfter && Trigger.isUpdate){
        MaintenanceRequestHelper.createFutureMaintenance(Trigger.new, Trigger.oldMap);
    }
}