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
           let heartRate = HKObjectType.quantityType(forIdentifier: .heartRate)
        {
            healthStore.requestAuthorization(toShare: [], read: [sleepAnalysis, heartRate]) { success, error in
                if success {
                    completion()
                }
            }
        }
    }
    
    func readHeartRate(startDate: Date, endDate: Date, healthStore: HKHealthStore, completion: @escaping ([HKQuantitySample]) -> Void) {
        guard let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate) else { return }
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        
        let query = HKSampleQuery(sampleType: heartRateType, predicate: predicate, limit: 10000, sortDescriptors: [sortDescriptor]) { (query, result, error) in
            if let result {
                let samples = result.compactMap({ $0 as? HKQuantitySample })
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
