//
//  ContentView.swift
//  g11-sleep-ios
//
//

import SwiftUI
import Charts

struct ContentView: View {
    @State private var showFeedbackSheet = false
    @State private var timelineSelection: Timeline = .day
    
    @EnvironmentObject var vm: ContentViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Picker("Timeline", selection: $timelineSelection) {
                        Text("Day").tag(Timeline.day)
                        Text("Week").tag(Timeline.week)
                        Text("Month").tag(Timeline.month)
                        Text("Year").tag(Timeline.year)
                    }
                    .pickerStyle(.segmented)
                    SleepChart(headerTitle: "Chart",
                               chartXScaleRangeStart: vm.sleepAxisStartDate,
                               chartXScaleRangeEnd: vm.sleepAxisEndDate,
                               stages: vm.allStages)
                }
            }
                .padding(20)
                .navigationTitle("Hi Alexander!")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showFeedbackSheet.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }
                        .sheet(isPresented: $showFeedbackSheet) {
                            FeedbackView()
                        }
                    }
                }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ContentViewModel())
    }
}
