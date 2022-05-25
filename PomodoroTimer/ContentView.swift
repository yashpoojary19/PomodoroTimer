//
//  ContentView.swift
//  PomodoroTimer
//
//  Created by Yash Poojary on 25/05/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var pomodoroViewModel = PomodoroViewModel()
    
    var body: some View {
        VStack {
            
            Text("Current State: \(pomodoroViewModel.currentState == .PomodoroTimer ? "Flow" : "Break")")
            
            Text("\(pomodoroViewModel.timeString(time: pomodoroViewModel.timeRemaining))")
                .font(.largeTitle)
                .padding()
            
            Button(action: {
                switch pomodoroViewModel.currentState {
                case .PomodoroTimer:
                    switch pomodoroViewModel.currentTimerState {
                    case .stop:
                        pomodoroViewModel.startTimer()
                    case .running:
                        pomodoroViewModel.stopTimer()
                    }
                    
                case .PomodoroBreak:
                    switch pomodoroViewModel.currentBreakState {
                    case .stop:
                        pomodoroViewModel.startBreak()
                    case .running:
                        pomodoroViewModel.stopBreak()
                    }
                    
                }
                
                
            }) {
              
                Text(pomodoroViewModel.currentTimerState == .running || pomodoroViewModel.currentBreakState == .running ? "Stop Timer" : "Start Timer")
            }
            
        }
        .onReceive(pomodoroViewModel.timer) { time in
            if pomodoroViewModel.currentTimerState != .stop || pomodoroViewModel.currentBreakState != .stop  {
                if pomodoroViewModel.timeRemaining > 0 {
                    pomodoroViewModel.timeRemaining -= 1
                }
            }
            
        }
        .onAppear {
            pomodoroViewModel.currentTimerState = .stop
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
