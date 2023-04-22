//
//  SleepGraphView.swift
//  g11-sleep-ios
//
//  Created by Alexander Johansson on 22/04/2023.
//

import Foundation
import SwiftUI
import Charts

struct SleepChart: View {
    @State private var selectedStage: Stage?
    @State private var plotWidth: CGFloat = 0
    
    var headerTitle: String
    var chartXScaleRangeStart: Date
    var chartXScaleRangeEnd: Date
    
    var stages: [Stage]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(headerTitle)
                .font(.title3.bold())
            
            Chart {
                ForEach(stages, id: \.stageId) { stage in
                    Plot {
                        BarMark(
                            xStart: .value("Start", stage.startDate),
                            xEnd: .value("End", stage.endDate),
                            y: .value("Stage", stage.stageName)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                        .foregroundStyle(stage.stageColor)
                    }
                    .accessibilityLabel("Stage: \(stage.stageName)")
                    .accessibilityValue("Start: \(stage.startDate.formatted(date: .abbreviated, time: .standard)), End: \(stage.endDate.formatted(date: .abbreviated, time: .standard))")
                }
            }
            .padding(.top, 40)
            .frame(height: 300)
            .chartXScale(domain: chartXScaleRangeStart...chartXScaleRangeEnd)
            .chartOverlay { proxy in
                GeometryReader { geoProxy in
                    Rectangle()
                        .fill(.clear).contentShape(Rectangle())
                        .gesture(
                            SpatialTapGesture()
                                .onEnded { value in
                                    let location = value.location
                                    
                                    if let date: Date = proxy.value(atX: location.x) {
                                        if let stage = stages.first(where: {
                                            date >= $0.startDate && date <= $0.endDate
                                        }) {
                                            self.selectedStage = stage
                                            self.plotWidth = proxy.plotAreaSize.width
                                        }
                                    }
                                }
                        )
                }
            }
        }
    }
}
