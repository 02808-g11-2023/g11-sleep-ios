//
//  InsightsView.swift
//  g11-sleep-ios
//
//

import SwiftUI

struct InsightsView: View {
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var vm: ContentViewModel
    
    var body: some View {
        NavigationView {
            List {
                Section(
                    header: Text("Insight"),
                    footer: Text("Based on data collected in the past four weeks")
                ) {
                    Text("Your sleep quality has improved following regular exercise. On days you've exercised, sleep quality has gone up by 7%! 🎉")
                        .font(.system(.subheadline, design: .rounded))
                }
                
                Section(
                    header: Text("Perceived feeling"),
                    footer: Text("Based on quantitative data collected in the past four weeks")
                ) {
                    Text("On days you've reported that you slept better than previous days, the overall sleep quality for the following night has been good. 👍")
                        .font(.system(.subheadline, design: .rounded))
                }
                
                Section(
                    header: Text("SLEEP QUALITY - ") + Text(vm.currentDateSelection.formatted(date: .abbreviated, time: .omitted)),
                    footer: Text("The percentage of REM sleep that you get throughout a night should typically fall between 21% and 30%.")
                ) {
                    HStack {
                        Text("REM Level: ") + Text("\(vm.remLevel)%").foregroundColor(.gray)
                        Spacer()
                        // TODO: logic for checkmark / x
                        Image(systemName: "checkmark.circle")
                            .foregroundColor(.green)
                        //Image(systemName: "x.circle")
                        //    .foregroundColor(.red)
                        //Image(systemName: "minus.circle")
                        //    .foregroundColor(.red)
                    }
                }
                Section(
                    footer: Text("Awakenings longer than 5 minutes should typically not exceed one, 4 or more indicate bad sleep.")
                ) {
                    HStack {
                        Text("Awakenings: ") + Text("\(vm.awakenings)").foregroundColor(.gray)
                        Spacer()
                        Image(systemName: "checkmark.circle")
                            .foregroundColor(.green)
                    }
                }
                Section(
                    footer: Text("Wake after sleep onset (WASO) is the total time spent awake (in minutes) after falling asleep. Between the threshold 21-50 minutes can indicate bad sleep.")
                ) {
                    HStack {
                        Text("Wake After Sleep Onset: ") + Text("\(Int(vm.timeAwake)) min").foregroundColor(.gray)
                        Spacer()
                        Image(systemName: "checkmark.circle")
                            .foregroundColor(.green)
                    }
                }
                Section(
                    footer: Text("Sleep latency is the time it takes for you to fall asleep. Less than 15 minutes is ideal, more than 45 minutes indicates bad sleep.")
                ) {
                    HStack {
                        Text("Sleep Latency: ") + Text("\(vm.sleepLatency) mins").foregroundColor(.gray)
                        Spacer()
                        if vm.sleepLatency < SleepQualityConsts.sleepGoodLatency {
                            Image(systemName: "checkmark.circle")
                                .foregroundColor(.green)
                        } else if vm.sleepLatency > SleepQualityConsts.sleepBadLatency {
                            Image(systemName: "x.circle")
                                .foregroundColor(.red)
                        } else {
                            Image(systemName: "minus.circle")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Back") {
                            dismiss()
                        }
                    }
                }
        }
    }
    
}

struct InsightsView_Previews: PreviewProvider {
    static var previews: some View {
        InsightsView()
            .environmentObject(ContentViewModel())
    }
}
