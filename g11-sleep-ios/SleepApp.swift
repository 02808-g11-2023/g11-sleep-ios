//
//  SleepApp.swift
//  g11-sleep-ios
//
//

import SwiftUI

@main
struct SleepApp: App {
    private var vm = ContentViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(vm)
        }
    }
}
