//
//  ExerciseQualityConsts.swift
//  g11-sleep-ios
//
//

struct ExerciseQualityConsts {
    // If considered over 130, exercise is happening
    static let heartRateThresholdMin: Int = 130
    
    static let heartRateElevatedCountFirstLevel: Int = 2
    static let heartRateElevatedCountSecondLevel: Int = 6
    static let heartRateElevatedCountThirdLevel: Int = 80
    static let heartRateElevatedCountFourthLevel: Int = 140
    
    static func getExerciseLevel(heartRateEventsOverThreshold: Int) -> Int {
        if heartRateEventsOverThreshold < ExerciseQualityConsts.heartRateElevatedCountFirstLevel {
            return 0
        } else if heartRateEventsOverThreshold < ExerciseQualityConsts.heartRateElevatedCountSecondLevel {
            return 1
        } else if heartRateEventsOverThreshold < ExerciseQualityConsts.heartRateElevatedCountThirdLevel {
            return 2
        } else if heartRateEventsOverThreshold < ExerciseQualityConsts.heartRateElevatedCountFourthLevel {
            return 3
        } else {
            return 4
        }
    }
}
