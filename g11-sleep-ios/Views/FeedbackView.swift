//
//  FeedbackView.swift
//  g11-sleep-ios
//
//

import SwiftUI

struct FeedbackView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var calendarId: UUID = UUID()
    
    @EnvironmentObject var vm: FeedbackViewModel
    
    var body: some View {
        NavigationView {
            Form {
                DatePicker(
                    "Feedback for",
                    selection: $vm.currentSelectedDate,
                    in: ...Date(),
                    displayedComponents: [.date]
                )
                .datePickerStyle(.automatic)
                .padding(1)
                .id(calendarId)
                .onChange(of: vm.currentSelectedDate) { date in
                    calendarId = UUID()
                    vm.loadFeedback()
                }
                
                Section(header: Text("Sleep Quality")) {
                    HStack(alignment: .center) {
                        Button(action: {
                            vm.selectSleepQuality(feedbackLevel: .one)
                        }) {
                            Image(systemName: "1.square.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .foregroundColor(.red)
                        .opacity(vm.userFeedback.sleepQuality == nil || vm.userFeedback.sleepQuality == FeedbackLevel.one ? 1.0 : 0.1)
                        .animation(.easeInOut, value: vm.userFeedback.sleepQuality)
                        
                        Spacer()
                        Button(action: {
                            vm.selectSleepQuality(feedbackLevel: .two)
                        }) {
                            Image(systemName: "2.square.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .foregroundColor(.orange)
                        .opacity(vm.userFeedback.sleepQuality == nil || vm.userFeedback.sleepQuality == FeedbackLevel.two ? 1.0 : 0.1)
                        .animation(.easeInOut, value: vm.userFeedback.sleepQuality)
                        
                        Spacer()
                        Button(action: {
                            vm.selectSleepQuality(feedbackLevel: .three)
                        }) {
                            Image(systemName: "3.square.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .foregroundColor(.yellow)
                        .opacity(vm.userFeedback.sleepQuality == nil || vm.userFeedback.sleepQuality == FeedbackLevel.three ? 1.0 : 0.1)
                        .animation(.easeInOut, value: vm.userFeedback.sleepQuality)
                        
                        Spacer()
                        Button(action: {
                            vm.selectSleepQuality(feedbackLevel: .four)
                        }) {
                            Image(systemName: "4.square.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .foregroundColor(.cyan)
                        .opacity(vm.userFeedback.sleepQuality == nil || vm.userFeedback.sleepQuality == FeedbackLevel.four ? 1.0 : 0.1)
                        .animation(.easeInOut, value: vm.userFeedback.sleepQuality)
                        
                        Spacer()
                        Button(action: {
                            vm.selectSleepQuality(feedbackLevel: .five)
                        }) {
                            Image(systemName: "5.square.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .foregroundColor(.green)
                        .opacity(vm.userFeedback.sleepQuality == nil || vm.userFeedback.sleepQuality == FeedbackLevel.five ? 1.0 : 0.1)
                        .animation(.easeInOut, value: vm.userFeedback.sleepQuality)
                    }
                }
                Section(header: Text("Exercise Quality")) {
                    HStack(alignment: .center) {
                        Button(action: {
                            vm.selectExerciseQuality(feedbackLevel: .one)
                        }) {
                            Image(systemName: "1.square.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .foregroundColor(.red)
                        .opacity(vm.userFeedback.exerciseQuality == nil || vm.userFeedback.exerciseQuality == FeedbackLevel.one ? 1.0 : 0.1)
                        .animation(.easeInOut, value: vm.userFeedback.exerciseQuality)
                        
                        Spacer()
                        Button(action: {
                            vm.selectExerciseQuality(feedbackLevel: .two)
                        }) {
                            Image(systemName: "2.square.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .foregroundColor(.orange)
                        .opacity(vm.userFeedback.exerciseQuality == nil || vm.userFeedback.exerciseQuality == FeedbackLevel.two ? 1.0 : 0.1)
                        .animation(.easeInOut, value: vm.userFeedback.exerciseQuality)
                        
                        Spacer()
                        Button(action: {
                            vm.selectExerciseQuality(feedbackLevel: .three)
                        }) {
                            Image(systemName: "3.square.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .foregroundColor(.yellow)
                        .opacity(vm.userFeedback.exerciseQuality == nil || vm.userFeedback.exerciseQuality == FeedbackLevel.three ? 1.0 : 0.1)
                        .animation(.easeInOut, value: vm.userFeedback.exerciseQuality)
                        
                        Spacer()
                        Button(action: {
                            vm.selectExerciseQuality(feedbackLevel: .four)
                        }) {
                            Image(systemName: "4.square.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .foregroundColor(.cyan)
                        .opacity(vm.userFeedback.exerciseQuality == nil || vm.userFeedback.exerciseQuality == FeedbackLevel.four ? 1.0 : 0.1)
                        .animation(.easeInOut, value: vm.userFeedback.exerciseQuality)
                        
                        Spacer()
                        Button(action: {
                            vm.selectExerciseQuality(feedbackLevel: .five)
                        }) {
                            Image(systemName: "5.square.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .foregroundColor(.green)
                        .opacity(vm.userFeedback.exerciseQuality == nil || vm.userFeedback.exerciseQuality == FeedbackLevel.five ? 1.0 : 0.1)
                        .animation(.easeInOut, value: vm.userFeedback.exerciseQuality)
                    }
                }
                
                Section(header: Text("Optional input")) {
                    TextField("How did you feel?", text: $vm.textInput)
                        .frame(height: 275, alignment: .top)
                }
            }
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                    
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save") {
                            vm.saveFeedback()
                            dismiss()
                        }
                    }
                }
        }
    }
}

struct FeedbackView_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackView()
            .environmentObject(FeedbackViewModel(currentSelectedDate: Date()))
    }
}
