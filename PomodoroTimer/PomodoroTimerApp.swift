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
//        .onChange(of: phase) { newValue in
//            if newValue == .background {
//                print("I am in background")
//                lastActiveDateStamp = Date()
//            }
//
//            if newValue == .active {
//                print("I am active")
//                let currentTimeStampDifference = Date().timeIntervalSince(lastActiveDateStamp)
//                if pomodoroViewModel.timeRemaining - Double(currentTimeStampDifference) <= 0 {
//
//                    // when the difference is negative
//
//                    switch pomodoroViewModel.currentState {
//                    case .PomodoroTimer:
//                        pomodoroViewModel.currentState = .PomodoroBreak
//                        pomodoroViewModel.timeRemaining = pomodoroViewModel.breakTimeDuration
//                    case .PomodoroBreak:
//                        pomodoroViewModel.currentState = .PomodoroTimer
//                        pomodoroViewModel.timeRemaining = pomodoroViewModel.timerDuration
//                    }
//
//                } else {
//                    pomodoroViewModel.timeRemaining -= Double(currentTimeStampDifference)
//                }
//            }
//        }
    }
}
