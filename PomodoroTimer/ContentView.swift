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
            Text("\(pomodoroViewModel.timeString(time: pomodoroViewModel.timeRemaining))")
                .font(.largeTitle)
                .padding()
            
            Button(action: {
                switch pomodoroViewModel.currentTimerState {
                case .stop:
                    pomodoroViewModel.currentTimerState = .start
                case .start:
                    pomodoroViewModel.currentTimerState = .stop
                case .running:
                    break
                }
            }) {
                Text(pomodoroViewModel.currentTimerState == .stop ? "Start Timer" : "Stop Timer")
            }
                
        }
        .onReceive(pomodoroViewModel.timer) { time in
            if pomodoroViewModel.currentTimerState == .start {
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
