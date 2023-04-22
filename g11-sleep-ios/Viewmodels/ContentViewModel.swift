//
//  ContentViewModel.swift
//  g11-sleep-ios
//
//

import Foundation
import HealthKit
import SwiftUI

class ContentViewModel: ObservableObject {
    
    @Published var userStepCount: Double = 0.0
    @Published var heartRates: [Double] = []
    
    @Published var asleepRem: [Stage] = []
    @Published var asleepDeep: [Stage] = []
    @Published var asleepCore: [Stage] = []
    @Published var awake: [Stage] = []
    @Published var allStages: [Stage] = []
    
    @Published var sleepAxisStartDate: Date = Date()
    @Published var sleepAxisEndDate: Date = Date()
    
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
            var mergedList = (asleepRem + asleepDeep + asleepCore + awake).sorted {
                $0.startDate < $1.startDate
            }
            
            DispatchQueue.main.async {
                self.asleepRem = asleepRem.map {
                    // Color.init(red: 129, green: 207, blue: 250)
                    Stage(stageName: "REM", stageId: $0.value, startDate: $0.startDate, endDate: $0.endDate, stageColor: .blue)
                }
                self.asleepDeep = asleepDeep.map {
                    // .init(red: 53, green: 52, blue: 157)
                    Stage(stageName: "Deep", stageId: $0.value, startDate: $0.startDate, endDate: $0.endDate, stageColor: .purple)
                }
                self.asleepCore = asleepCore.map {
                    // .init(red: 58, green: 130, blue: 247)
                    Stage(stageName: "Core", stageId: $0.value, startDate: $0.startDate, endDate: $0.endDate, stageColor: .blue)
                }
                self.awake = awake.map {
                    // .init(red: 255, green: 116, blue: 89)
                    Stage(stageName: "Awake", stageId: $0.value, startDate: $0.startDate, endDate: $0.endDate, stageColor: .orange)
                }
                self.allStages = self.awake + self.asleepRem + self.asleepCore + self.asleepDeep
                
                self.sleepAxisStartDate = Calendar.current.date(byAdding: .minute, value: -15, to: mergedList.first?.startDate ?? Date()) ?? Date()
                mergedList = mergedList.sorted {
                    $0.endDate < $1.endDate
                }
                self.sleepAxisEndDate = Calendar.current.date(byAdding: .minute, value: 15, to: mergedList.last?.endDate ?? Date()) ?? Date()
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
