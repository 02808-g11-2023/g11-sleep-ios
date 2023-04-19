//
//  ContentView.swift
//  g11-sleep-ios
//
//

import SwiftUI

struct ContentView: View {
    @State private var showFeedbackSheet = false
    
    @EnvironmentObject var vm: ContentViewModel
    
    var body: some View {
        TabView {
            NavigationView {
                Text("Steps today: \(vm.userStepCount)")
                    .navigationTitle("Hi Alexander!")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                showFeedbackSheet.toggle()
                            } label: {
                                Image(systemName: "plus")
                            }
                            .sheet(isPresented: $showFeedbackSheet) {
                                FeedbackSheet()
                            }
                        }
                    }
            }
            .tabItem {
                Image(systemName: "heart.fill")
                Text("Insights")
            }
            NavigationView {
                Text("Content here")
                    .navigationTitle("Settings")
            }
            .tabItem {
                Image(systemName: "person.fill")
                Text("Profile")
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
