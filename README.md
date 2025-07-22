# 🚀 Apex Specialist - Super Badge

[![Salesforce](https://img.shields.io/badge/Salesforce-00A1E0?style=flat&logo=salesforce&logoColor=white)](https://trailhead.salesforce.com/)
[![Apex](https://img.shields.io/badge/Apex-1798C1?style=flat&logo=salesforce&logoColor=white)](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/)
[![Status](https://img.shields.io/badge/Status-In%20Progress-yellow?style=flat)](https://github.com/)

## 📋 Challenge Overview

This repository contains the implementation for the **Apex Specialist Super Badge** challenge on Salesforce Trailhead. The project demonstrates advanced Apex development skills including automation, integration, scheduling, and comprehensive testing.

## ✅ Progress Tracker

### 1. 🔄 Automate Record Creation
- [x] **Status**: Completed ✅
- **Objective**: Install the unlocked package and configure the development org.
- **Implementation**: Use the included package content to automatically create a Routine Maintenance request every time a maintenance request of type Repair or Routine Maintenance is updated to Closed. Follow the specifications and naming conventions outlined in the business requirements.

### 2. 🔗 Synchronize Salesforce Data with External System
- [ ] **Status**: Pending 🔄
- **Objective**: Implement an Apex class called `WarehouseCalloutService`
- **Implementation**: Create a class that implements the queueable interface and makes a callout to the external service used for warehouse inventory management. This service receives updated values in the external system and updates the related records in Salesforce. Before checking this section, enqueue the job at least once to confirm that it's working as expected.

### 3. ⏰ Schedule Synchronization
- [ ] **Status**: Pending 🔄
- **Objective**: Build scheduling logic for daily execution
- **Implementation**: Build scheduling logic that executes your callout and runs your code daily. The name of the schedulable class should be `WarehouseSyncSchedule`, and the scheduled job should be named `WarehouseSyncScheduleJob`.

### 4. 🧪 Test Automation Logic
- [ ] **Status**: Pending 🔄
- **Objective**: Build comprehensive tests with 100% coverage
- **Implementation**: Build tests for all cases (positive, negative, and bulk) specified in the business requirements by using a class named `MaintenanceRequestHelperTest`. You must have 100% test coverage to pass this section and assert values to prove that your logic is working as expected. Choose Run All Tests in the Developer Console at least once before attempting to submit this section. Be patient as it may take 10-20 seconds to process the challenge check.

### 5. 🌐 Test Callout Logic
- [ ] **Status**: Pending 🔄
- **Objective**: Build tests for callout functionality
- **Implementation**: Build tests for your callout using the included class for the callout mock (`WarehouseCalloutServiceMock`) and callout test class (`WarehouseCalloutServiceTest`) in the package. You must have 100% test coverage to pass this challenge and assert values to prove that your logic is working as expected.

### 6. ⏱️ Test Scheduling Logic
- [ ] **Status**: Pending 🔄
- **Objective**: Build unit tests for scheduling
- **Implementation**: Build unit tests for the class `WarehouseSyncSchedule` in a class named `WarehouseSyncScheduleTest`. You must have 100% test coverage to pass this challenge and assert values to prove that your logic is working as expected.

## 🔗 Useful Links

- [Apex Specialist Super Badge](https://trailhead.salesforce.com/content/learn/superbadges/superbadge_apex)
- [Salesforce Apex Developer Guide](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/)
- [Testing Best Practices](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_testing_best_practices.htm)

---

**⭐ Star this repository if it helps you with your Salesforce journey!**

Readme created using AI.