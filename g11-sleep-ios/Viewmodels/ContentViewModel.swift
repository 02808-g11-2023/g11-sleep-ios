//
//  ContentViewModel.swift
//  g11-sleep-ios
//
//

import Foundation
import HealthKit
import SwiftUI

class ContentViewModel: ObservableObject {
    
    @Published var heartRates: [HeartRate] = []
    
    @Published var minBPM: Double = 0
    @Published var maxBPM: Double = 0
    @Published var averageHeartRate: Double = 0
    
    @Published var asleepRem: [Stage] = []
    @Published var asleepDeep: [Stage] = []
    @Published var asleepCore: [Stage] = []
    @Published var awake: [Stage] = []
    @Published var inBed: [Stage] = []
    @Published var allStages: [Stage] = []
    
    @Published var timeInBed: Double = 0
    @Published var timeAsleep: Double = 0
    
    @Published var sleepAxisStartDate: Date = Date()
    @Published var sleepAxisEndDate: Date = Date()
    
    @Published var currentDateSelection: Date = Date()
    
    private var healthStore = HKHealthStore()
    private var healthManager = HealthKitManager()
    
    init() {
        healthManager.setUpHealthRequest(healthStore: healthStore) {
            let startOfDay = Calendar.current.startOfDay(for: Date())
            self.readSleepAnalysisBetween(from: startOfDay, to: Date())
            self.readHeartRateBetween(from: startOfDay, to: Date())
        }
    }
    
    func update() {
        healthManager.setUpHealthRequest(healthStore: healthStore) {
            let startOfDay = Calendar.current.startOfDay(for: self.currentDateSelection)
            let endOfDay = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: self.currentDateSelection) ?? Date()
            self.readSleepAnalysisBetween(from: startOfDay, to: endOfDay)
            self.readHeartRateBetween(from: startOfDay, to: endOfDay)
        }
    }
    
    func readSleepAnalysisBetween(from: Date, to: Date) {
        self.healthManager.readSleepAnalysis(startDate: from, endDate: to, healthStore: healthStore) { asleepRem, asleepDeep, asleepCore, awake, inBed in
            var mergedList = (asleepRem + asleepDeep + asleepCore + awake).sorted {
                $0.startDate < $1.startDate
            }
            
            DispatchQueue.main.async {
                self.asleepRem = asleepRem.map {
                    Stage(stageName: "REM", stageId: $0.value, startDate: $0.startDate, endDate: $0.endDate, stageColor: .cyan)
                }
                self.asleepDeep = asleepDeep.map {
                    Stage(stageName: "Deep", stageId: $0.value, startDate: $0.startDate, endDate: $0.endDate, stageColor: .purple)
                }
                self.asleepCore = asleepCore.map {
                    Stage(stageName: "Core", stageId: $0.value, startDate: $0.startDate, endDate: $0.endDate, stageColor: .blue)
                }
                self.awake = awake.map {
                    Stage(stageName: "Awake", stageId: $0.value, startDate: $0.startDate, endDate: $0.endDate, stageColor: .orange)
                }
                self.inBed = inBed.map {
                    Stage(stageName: "In Bed", stageId: $0.value, startDate: $0.startDate, endDate: $0.endDate, stageColor: .blue)
                }
                self.allStages = self.awake + self.asleepRem + self.asleepCore + self.asleepDeep
                
                let asleepStages = self.asleepRem + self.asleepCore + self.asleepDeep
                self.timeAsleep = (asleepStages.reduce(0.0) {
                    $0 + $1.endDate.timeIntervalSince($1.startDate)
                }) / 60
                
                self.timeInBed = (self.inBed.reduce(0.0) {
                    $0 + $1.endDate.timeIntervalSince($1.startDate)
                }) / 60
                
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
                let allMappedSamples = samples.map {
                    HeartRate(id: $0.uuid.uuidString, minHeartRate: $0.quantity.doubleValue(for: HKUnit.init(from: "count/min")), maxHeartRate: $0.quantity.doubleValue(for: HKUnit.init(from: "count/min")), startDate: $0.startDate, endDate: $0.endDate)
                }
                
                let groupedByHour = self.groupedDataByHour(data: allMappedSamples)
                var entries: [HeartRate] = []
                groupedByHour.forEach { group in
                    let min = group.value.min {
                        $0.minHeartRate < $1.minHeartRate
                    }?.minHeartRate ?? 0.0
                    
                    let max = group.value.max {
                        $0.maxHeartRate < $1.maxHeartRate
                    }?.maxHeartRate ?? 0.0
                    
                    let sortedGroup = group.value.sorted {
                        $0.endDate < $1.endDate
                    }
                        
                    entries.append(
                        HeartRate(
                            id: UUID().uuidString,
                            minHeartRate: min,
                            maxHeartRate: max,
                            startDate: sortedGroup.first?.startDate ?? Date(),
                            endDate: sortedGroup.last?.endDate ?? Date()
                        )
                    )
                }
                
                self.heartRates = entries
                
                self.minBPM = self.heartRates.min {
                    $0.minHeartRate < $1.minHeartRate
                }?.minHeartRate ?? 0.0
                
                self.maxBPM = self.heartRates.max {
                    $0.maxHeartRate < $1.maxHeartRate
                }?.maxHeartRate ?? 0.0
                
                self.averageHeartRate = (allMappedSamples.count > 0 ? (allMappedSamples.reduce(0.0) { $0 + $1.minHeartRate }) / Double(allMappedSamples.count) : 0.0)
            }
        }
    }
    
    func groupedDataByHour(data: [HeartRate]) -> [Date: [HeartRate]] {
        let initial: [Date: [HeartRate]] = [:]
        let groupedByDateComponents = data.reduce(into: initial) { acc, cur in
            let components = Calendar.current.dateComponents([.hour], from: cur.startDate)
            let date = Calendar.current.date(from: components)!
            let existing = acc[date] ?? []
            acc[date] = existing + [cur]
        }
        
        return groupedByDateComponents
    }
    
}
