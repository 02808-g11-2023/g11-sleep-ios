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
                    Chart {
                        BarMark(
                            x: .value("Name", "Awake"),
                            y: .value("Value", 10)
                        )
                        BarMark(
                            x: .value("Name", "REM"),
                            y: .value("Value", 70)
                        )
                        BarMark(
                            x: .value("Name", "Core"),
                            y: .value("Value", 40)
                        )
                        BarMark(
                            x: .value("Name", "Deep"),
                            y: .value("Value", 30)
                        )
                    }
                    .frame(height: 275)
                    Chart {
                        BarMark(
                            x: .value("Value", 10),
                            y: .value("Name", "Awake")
                        )
                        BarMark(
                            x: .value("Value", 70),
                            y: .value("Name", "REM")
                        )
                        BarMark(
                            x: .value("Value", 40),
                            y: .value("Name", "Core")
                        )
                        BarMark(
                            x: .value("Value", 30),
                            y: .value("Name", "Deep")
                        )
                    }
                    .frame(height: 275)
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
