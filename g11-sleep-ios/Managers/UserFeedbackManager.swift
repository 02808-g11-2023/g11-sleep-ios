//
//  UserFeedbackManager.swift
//  g11-sleep-ios
//
//

import Foundation

class UserFeedbackManager {
    
    private var encoder = JSONEncoder()
    private var decoder = JSONDecoder()
    
    private var dateFormatter = DateFormatter()
    
    private var defaults = UserDefaults.standard
    
    init() {
        dateFormatter.dateStyle = .short
    }
    
    func getUserFeedbackByDate(date: Date) -> UserFeedback? {
        let formattedDateTime = dateFormatter.string(from: date)
        if let userFeedback = defaults.object(forKey: formattedDateTime) as? Data {
            return try? decoder.decode(UserFeedback.self, from: userFeedback)
        }
        
        return nil
    }
    
    func setUserFeedbackByDate(date: Date, userFeedback: UserFeedback) {
        let formattedDateTime = dateFormatter.string(from: date)
        if let encoded = try? encoder.encode(userFeedback) {
            defaults.set(encoded, forKey: formattedDateTime)
        }
    }
    
}


