//
//  PomodoroTimerApp.swift
//  PomodoroTimer
//
//  Created by Yash Poojary on 25/05/22.
//

import SwiftUI

@main
struct PomodoroTimerApp: App {
    @StateObject var pomodoroViewModel = PomodoroViewModel()
    
    @Environment(\.scenePhase) var phase
    @State var lastActiveDateStamp = Date()
    var body: some Scene {
        WindowGroup {
            ContentView(pomodoroViewModel: pomodoroViewModel)
                .frame(width: 300, height: 200)
            
        }
        .onChange(of: phase) { newValue in
            if newValue == .background {
                lastActiveDateStamp = Date()
            }
            
            if newValue == .active {
                let currentTimeStampDifference = Date().timeIntervalSince(lastActiveDateStamp)
                if pomodoroViewModel.timeRemaining - Double(currentTimeStampDifference) <= 0 {
                    pomodoroViewModel.timeRemaining = pomodoroViewModel.timerDuration
                } else {
                    pomodoroViewModel.timeRemaining -= Double(currentTimeStampDifference)
                }
            }
        }
    }
}
