//
//  SleepQualityManager.swift
//  g11-sleep-ios
//
//  Created by Alexander Johansson on 22/04/2023.
//

import Foundation

struct Consts {
    // REM threshold
    var remGoodSleepMin: Double = 0.21
    var remGoodSleepMax: Double = 0.30
    
    // If above 40%, indicates bad sleep
    var remBadSleep: Double = 0.40
    
    // Awakenings per night 0-1, 4+ bad
    var awakeningsGoodMin: Int = 1
    var awakeningBadMax: Int = 4
    
    // Wake after sleep onset (WASO)
    var sleepWASOMax: Int = 51
    var sleepWASOMin: Int = 20
    
    // Sleep latency (<15 mins good, >45 mins bad)
    var sleepGoodLatency: Int = 15
    var sleepBadLatency: Int = 45
}

// Four different types of metrics:
// - REM
// - Awakenings
// - WASO
// - Latency
// Bad if you have three or more outside of thresholds, or inside "bad" thresholds
// Good if you three or more that are within "good" thresholds
class SleepQualityManager {
    
    
    
}
