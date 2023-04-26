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
    
    var chartXScaleRangeStart: Date
    var chartXScaleRangeEnd: Date
    
    var minutesInBed: Double = 0.0
    var timeAsleep: Double = 0.0
    
    var stages: [Stage]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 16) {
                VStack(alignment: .leading) {
                    Text("TIME IN BED")
                        .font(.system(.caption, design: .rounded))
                        .foregroundColor(.gray)
                    
                    if (minutesInBed > 60) {
                        let remainder = minutesInBed.truncatingRemainder(dividingBy: 60.0)
                        
                        if (remainder > 0) {
                            Text("\(Int(minutesInBed / 60))")
                                .font(.system(.title, design: .rounded))
                                .foregroundColor(.primary) +
                            Text(" hr ")
                                .foregroundColor(.gray) +
                            Text("\(Int(minutesInBed.truncatingRemainder(dividingBy: 60.0)))")
                                .font(.system(.title, design: .rounded))
                                .foregroundColor(.primary) +
                            Text(" min")
                                .foregroundColor(.gray)
                        } else {
                            Text("\(Int(minutesInBed / 60))")
                                .font(.system(.title, design: .rounded))
                                .foregroundColor(.primary) +
                            Text(" hr")
                                .foregroundColor(.gray)
                        }
                    } else {
                        Text("\(Int(minutesInBed))")
                            .font(.system(.title, design: .rounded))
                            .foregroundColor(.primary) +
                        Text(" min")
                    }
                }
                .fontWeight(.semibold)
                
                VStack(alignment: .leading) {
                    Text("TIME ASLEEP")
                        .font(.system(.caption, design: .rounded))
                        .foregroundColor(.gray)
                    
                    if (timeAsleep > 60) {
                        let remainder = timeAsleep.truncatingRemainder(dividingBy: 60.0)
                        
                        if (remainder > 0) {
                            Text("\(Int(timeAsleep / 60))")
                                .font(.system(.title, design: .rounded))
                                .foregroundColor(.primary) +
                            Text(" hr ")
                                .foregroundColor(.gray) +
                            Text("\(Int(timeAsleep.truncatingRemainder(dividingBy: 60.0)))")
                                .font(.system(.title, design: .rounded))
                                .foregroundColor(.primary) +
                            Text(" min")
                                .foregroundColor(.gray)
                        } else {
                            Text("\(Int(timeAsleep / 60))")
                                .font(.system(.title, design: .rounded))
                                .foregroundColor(.primary) +
                            Text(" hr")
                                .foregroundColor(.gray)
                        }
                    } else {
                        Text("\(Int(timeAsleep))")
                            .font(.system(.title, design: .rounded))
                            .foregroundColor(.primary) +
                        Text(" min")
                    }
                }
                .fontWeight(.semibold)
            }
            
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
            .padding(.top, 10)
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

struct SleepChart_Previews: PreviewProvider {
    static var previews: some View {
        SleepChart(
            chartXScaleRangeStart: Date(),
            chartXScaleRangeEnd: Date(),
            minutesInBed: 360.0,
            timeAsleep: 413.0,
            stages: []
        )
    }
}
