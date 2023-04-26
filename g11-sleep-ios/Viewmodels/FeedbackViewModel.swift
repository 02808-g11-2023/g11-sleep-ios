//
//  FeedbackViewModel.swift
//  g11-sleep-ios
//
//  Created by Alexander Johansson on 26/04/2023.
//

import Foundation

class FeedbackViewModel: ObservableObject {
    
    @Published var currentSelectedDate = Date()
    @Published var textInput: String = ""
    
    @Published var userFeedback: UserFeedback = UserFeedback()
    
    private var userFeedbackManager = UserFeedbackManager()
    
    init(currentSelectedDate: Date) {
        self.currentSelectedDate = currentSelectedDate
        
        self.loadFeedback()
    }
    
    func selectSleepQuality(feedbackLevel: FeedbackLevel) {
        self.userFeedback.sleepQuality = feedbackLevel
    }
    
    func selectExerciseQuality(feedbackLevel: FeedbackLevel) {
        self.userFeedback.exerciseQuality = feedbackLevel
    }
    
    func saveFeedback() {
        self.userFeedback.optionalFeedback = textInput
        userFeedbackManager.setUserFeedbackByDate(date: self.currentSelectedDate, userFeedback: self.userFeedback)
    }
    
    func loadFeedback() {
        self.userFeedback = userFeedbackManager.getUserFeedbackByDate(date: self.currentSelectedDate)
        self.textInput = self.userFeedback.optionalFeedback
    }
    
}
