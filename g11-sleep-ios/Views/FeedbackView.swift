//
//  FeedbackView.swift
//  g11-sleep-ios
//
//

import SwiftUI

struct FeedbackView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var date = Date()
    @State private var textInput: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                DatePicker(
                    "Feedback for",
                    selection: $date,
                    in: ...Date(),
                    displayedComponents: [.date]
                )
                .datePickerStyle(.automatic)
                .padding(1)
                
                Section(header: Text("Sleep Quality")) {
                    HStack(alignment: .center) {
                        Button(action: {
                            
                        }) {
                            Image(systemName: "1.square.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .foregroundColor(.red)
                        //.opacity(0.1)
                        
                        Spacer()
                        Button(action: {
                            
                        }) {
                            Image(systemName: "2.square.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .foregroundColor(.orange)
                        Spacer()
                        Button(action: {
                            
                        }) {
                            Image(systemName: "3.square.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .foregroundColor(.yellow)
                        Spacer()
                        Button(action: {
                            
                        }) {
                            Image(systemName: "4.square.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .foregroundColor(.cyan)
                        Spacer()
                        Button(action: {
                            
                        }) {
                            Image(systemName: "5.square.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .foregroundColor(.green)
                    }
                }
                Section(header: Text("Exercise Quality")) {
                    HStack(alignment: .center) {
                        Button(action: {
                            
                        }) {
                            Image(systemName: "1.square.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .foregroundColor(.red)
                        Spacer()
                        Button(action: {
                            
                        }) {
                            Image(systemName: "2.square.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .foregroundColor(.orange)
                        Spacer()
                        Button(action: {
                            
                        }) {
                            Image(systemName: "3.square.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .foregroundColor(.yellow)
                        Spacer()
                        Button(action: {
                            
                        }) {
                            Image(systemName: "4.square.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .foregroundColor(.cyan)
                        Spacer()
                        Button(action: {
                            
                        }) {
                            Image(systemName: "5.square.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .foregroundColor(.green)
                    }
                }
                
                Section(header: Text("Optional input")) {
                    TextField("How did you feel?", text: $textInput)
                        .frame(height: 275, alignment: .top)
                }
            }
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
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
    }
}
