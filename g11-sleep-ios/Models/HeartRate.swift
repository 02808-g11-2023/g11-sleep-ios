//
//  HeartRate.swift
//  g11-sleep-ios
//
//

import Foundation

struct HeartRate: Equatable {
    var id: String
    var minHeartRate: Double
    var maxHeartRate: Double
    var startDate: Date
    var endDate: Date
    
    init(id: String, minHeartRate: Double, maxHeartRate: Double, startDate: Date, endDate: Date) {
        self.id = id
        self.minHeartRate = minHeartRate
        self.maxHeartRate = maxHeartRate
        self.startDate = startDate
        self.endDate = endDate
    }
}
