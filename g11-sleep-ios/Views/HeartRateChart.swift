//
//  HeartRateChart.swift
//  g11-sleep-ios
//
//

import Foundation
import SwiftUI
import Charts

struct HeartRateChart: View {
    var data: [HeartRate]
    var minBPM: Double = 0.0
    var maxBPM: Double = 0.0
    var averageHeartRate: Double = 0.0

    @State private var barWidth = 13.0
    @State private var chartColor: Color = .red
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 16) {
                VStack(alignment: .leading) {
                    Text("RANGE")
                        .font(.system(.caption, design: .rounded))
                        .foregroundColor(.gray)
                    
                    Text("\(Int(minBPM))-\(Int(maxBPM)) ")
                        .font(.system(.title, design: .rounded))
                        .foregroundColor(.primary)
                    + Text("BPM")
                        .foregroundColor(.gray)
                }
                .fontWeight(.semibold)
                .animation(.easeInOut, value: minBPM)
                
                VStack(alignment: .leading) {
                    Text("AVERAGE")
                        .font(.system(.caption, design: .rounded))
                        .foregroundColor(.gray)
                    
                    Text("\(Int(averageHeartRate)) ")
                        .font(.system(.title, design: .rounded))
                        .foregroundColor(.primary)
                    + Text("BPM")
                        .foregroundColor(.gray)
                }
                .fontWeight(.semibold)
                .animation(.easeInOut, value: averageHeartRate)
            }
            
            Chart(data, id: \.id) { hour in
                Plot {
                    BarMark(
                        x: .value("Hour", hour.startDate, unit: .hour),
                        yStart: .value("BPM Min", hour.minHeartRate),
                        yEnd: .value("BPM Max", hour.maxHeartRate),
                        width: .fixed(barWidth)
                    )
                    .clipShape(Capsule())
                    .foregroundStyle(chartColor.gradient)
                }
                .accessibilityLabel("\(hour.startDate)")
                .accessibilityValue("\(hour.minHeartRate) to \(hour.maxHeartRate) BPM")
            }
            .frame(height: 300)
            .animation(.easeInOut, value: data)
        }
    }
}

struct HeartRateChart_Previews: PreviewProvider {
    static var previews: some View {
        HeartRateChart(data: [], minBPM: 100, maxBPM: 160, averageHeartRate: 130)
    }
}
