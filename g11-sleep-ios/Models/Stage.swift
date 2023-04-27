//
//  Stage.swift
//  g11-sleep-ios
//
//

import Foundation
import SwiftUI

struct Stage: Equatable {
    var stageName: String
    var stageId: Int
    var startDate: Date
    var endDate: Date
    var stageColor: Color
    
    init(stageName: String, stageId: Int, startDate: Date, endDate: Date, stageColor: Color) {
        self.stageName = stageName
        self.stageId = stageId
        self.startDate = startDate
        self.endDate = endDate
        self.stageColor = stageColor
    }
}
