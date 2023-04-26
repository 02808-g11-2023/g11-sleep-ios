//
//  HealthKitManager.swift
//  g11-sleep-ios
//
//

import Foundation
import HealthKit

class HealthKitManager {
    
    func setUpHealthRequest(healthStore: HKHealthStore, completion: @escaping () -> Void) {
        if HKHealthStore.isHealthDataAvailable(),
           let sleepAnalysis = HKObjectType.categoryType(forIdentifier: .sleepAnalysis),
           let heartRate = HKObjectType.quantityType(forIdentifier: .heartRate),
           let stepCount = HKObjectType.quantityType(forIdentifier: .stepCount)
        {
            healthStore.requestAuthorization(toShare: [], read: [sleepAnalysis, heartRate, stepCount]) { success, error in
                if success {
                    completion()
                }
            }
        }
    }
    
    func readStepCount(forToday: Date, healthStore: HKHealthStore, completion: @escaping (Double) -> Void) {
        guard let stepQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount) else { return }
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: stepQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
            
            guard let result = result, let sum = result.sumQuantity() else {
                completion(0.0)
                return
            }
            
            completion(sum.doubleValue(for: HKUnit.count()))
        
        }
        
        healthStore.execute(query)
    }
    
    func readHeartRate(startDate: Date, endDate: Date, healthStore: HKHealthStore, completion: @escaping ([HKQuantitySample]) -> Void) {
        guard let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate) else { return }
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        
        let query = HKSampleQuery(sampleType: heartRateType, predicate: predicate, limit: 10000, sortDescriptors: [sortDescriptor]) { (query, result, error) in
            if let result {
                let samples = result.compactMap({ $0 as? HKQuantitySample})
                completion(samples)
            }
        }
        
        healthStore.execute(query)
    }
    
    func readSleepAnalysis(startDate: Date, endDate: Date, healthStore: HKHealthStore, completion: @escaping (_ asleepRem: [HKCategorySample], _ asleepDeep: [HKCategorySample], _ asleepCore: [HKCategorySample], _ awake: [HKCategorySample], _ inBed: [HKCategorySample]) -> Void) {
        guard let sleepAnalysisType = HKCategoryType.categoryType(forIdentifier: .sleepAnalysis) else { return }
        
        let typesToFetch: Set = [HKCategoryValueSleepAnalysis.asleepREM, HKCategoryValueSleepAnalysis.asleepDeep, HKCategoryValueSleepAnalysis.asleepCore, HKCategoryValueSleepAnalysis.awake, HKCategoryValueSleepAnalysis.inBed]
        let typesPredicate = HKCategoryValueSleepAnalysis.predicateForSamples(equalTo: typesToFetch)
        let dateRangePredicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [dateRangePredicate, typesPredicate])

        let query = HKSampleQuery(sampleType: sleepAnalysisType, predicate: predicate, limit: 10000, sortDescriptors: [sortDescriptor]) { (query, result, error) in
            if let result {
                let samples = result.compactMap({ $0 as? HKCategorySample })
                
                let asleepRem = samples.filter {
                    $0.value == HKCategoryValueSleepAnalysis.asleepREM.rawValue
                }
                
                let asleepDeep = samples.filter {
                    $0.value == HKCategoryValueSleepAnalysis.asleepDeep.rawValue
                }
                
                let asleepCore = samples.filter {
                    $0.value == HKCategoryValueSleepAnalysis.asleepCore.rawValue
                }
                
                let awake = samples.filter {
                    $0.value == HKCategoryValueSleepAnalysis.awake.rawValue
                }
                
                let inBed = samples.filter {
                    $0.value == HKCategoryValueSleepAnalysis.inBed.rawValue
                }
                
                completion(asleepRem, asleepDeep, asleepCore, awake, inBed)
            }
        }
        
        healthStore.execute(query)
    }
    
}
