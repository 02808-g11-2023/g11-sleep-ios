//
//  ContentViewModel.swift
//  g11-sleep-ios
//
//

import Foundation
import HealthKit

class ContentViewModel: ObservableObject {
    
    @Published var userStepCount: Double = 0.0
    @Published var heartRates: [Double] = []
    
    private var healthStore = HKHealthStore()
    private var healthManager = HealthKitManager()
    
    init() {
        healthManager.setUpHealthRequest(healthStore: healthStore) {
            self.readStepsTakenToday()
            
            // TODO: define date range
            let startOfDay = Calendar.current.startOfDay(for: Date())
            self.readSleepAnalysisBetween(from: startOfDay, to: Date())
            self.readHeartRateBetween(from: startOfDay, to: Date())
        }
    }
    
    func readStepsTakenToday() {
        self.healthManager.readStepCount(forToday: Date(), healthStore: healthStore) { step in
            if step != 0.0 {
                DispatchQueue.main.async {
                    self.userStepCount = step
                }
            }
        }
    }
    
    func readSleepAnalysisBetween(from: Date, to: Date) {
        self.healthManager.readSleepAnalysis(startDate: from, endDate: to, healthStore: healthStore) { asleepRem, asleepDeep, asleepCore, awake in
            DispatchQueue.main.async {
                // do something with samples
            }
        }
    }
    
    func readHeartRateBetween(from: Date, to: Date) {
        self.healthManager.readHeartRate(startDate: from, endDate: to, healthStore: healthStore) { samples in
            DispatchQueue.main.async {
                // do something with samples
                let values = samples.compactMap { $0.quantity.doubleValue(for: HKUnit.init(from: "count/min")) }
                self.heartRates = values
            }
        }
    }
    
}
