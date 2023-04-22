//
//  UserFeedback.swift
//  g11-sleep-ios
//
//

import Foundation

enum FeedbackLevel: Int, Codable {
    case one
    case two
    case three
    case four
    case five
}

struct UserFeedback: Codable {
    var sleepQuality: FeedbackLevel
    var exerciseQuality: FeedbackLevel
    var optionalFeedback: String
}
