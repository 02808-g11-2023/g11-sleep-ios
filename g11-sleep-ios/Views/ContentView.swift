//
//  ContentView.swift
//  g11-sleep-ios
//
//

import SwiftUI
import Charts

struct ContentView: View {
    @State private var showFeedbackSheet = false
    @State private var showInsightsSheet = false
    @State var calendarId: UUID = UUID()
    
    @EnvironmentObject var vm: ContentViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    ZStack {
                        Button(action: {
                            showInsightsSheet.toggle()
                        }) {
                            Text("Insights")
                                .foregroundColor(.accentColor)
                            Image(systemName: "chevron.forward")
                                .foregroundColor(.accentColor)
                        }
                        .sheet(isPresented: $showInsightsSheet) {
                            InsightsView()
                                .environmentObject(vm)
                        }
                        .offset(x: 130, y: -160)
                        
                        SleepChart(
                            chartXScaleRangeStart: vm.sleepAxisStartDate,
                            chartXScaleRangeEnd: vm.sleepAxisEndDate,
                            minutesInBed: vm.timeInBed,
                            timeAsleep: vm.timeAsleep,
                            stages: vm.allStages
                        )
                    }
                    
                    HeartRateChart(
                        data: vm.heartRates,
                        minBPM: vm.minBPM,
                        maxBPM: vm.maxBPM,
                        averageHeartRate: vm.averageHeartRate
                    )
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
                                .environmentObject(FeedbackViewModel(currentSelectedDate: vm.currentDateSelection))
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        DatePicker(
                            "",
                            selection: $vm.currentDateSelection,
                            in: ...Date(),
                            displayedComponents: [.date]
                        )
                        .datePickerStyle(.automatic)
                        .padding(1)
                        .labelsHidden()
                        .id(calendarId)
                        .onChange(of: vm.currentDateSelection) { date in
                            calendarId = UUID()
                            vm.update()
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
