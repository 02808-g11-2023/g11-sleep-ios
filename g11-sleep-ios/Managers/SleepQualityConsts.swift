//
//  SleepQualityConsts.swift
//  g11-sleep-ios
//
//  Created by Alexander Johansson on 22/04/2023.
//

struct SleepQualityConsts {
    // REM threshold
    static let remGoodSleepMin: Double = 0.21
    static let remGoodSleepMax: Double = 0.30
    
    // If above 40%, indicates bad sleep
    static let remBadSleep: Double = 0.40
    
    // Awakenings per night 0-1, 4+ bad
    static let awakeningsGoodMin: Int = 1
    static let awakeningBadMax: Int = 4
    
    // Wake after sleep onset (WASO)
    static let sleepWASOMax: Int = 51
    static let sleepWASOMin: Int = 20
    
    // Sleep latency (<15 mins good, >45 mins bad)
    static let sleepGoodLatency: Int = 15
    static let sleepBadLatency: Int = 45
}

// Four different types of metrics:
// - REM
// - Awakenings
// - WASO
// - Latency
// Bad if you have three or more outside of thresholds, or inside "bad" thresholds
// Good if you three or more that are within "good" thresholds
