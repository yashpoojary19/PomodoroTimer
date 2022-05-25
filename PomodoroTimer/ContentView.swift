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
        .toolbar {
            ToolbarItemGroup(placement: .navigation) {
              Menu {
                  ForEach(pomodoroViewModel.timerDurationArray, id: \.self) { timerDuration in
                           Button(action: {
                               pomodoroViewModel.timerDuration = timerDuration * 60
                               if pomodoroViewModel.currentTimerState != .running && pomodoroViewModel.currentBreakState != .running {
                                   pomodoroViewModel.timeRemaining = timerDuration * 60
                               }
                           }) {
                               Text("\(pomodoroViewModel.timerDuration == timerDuration * 60 ? "✓" : "   ") \(pomodoroViewModel.forTrailingZero(temp: timerDuration)) min")
                                   .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                        
                        }
                    }
                    
                } label: {
                    Text("Flow Duration")
                }
                
                Menu {
                  
                        ForEach(pomodoroViewModel.breakDurationArray, id: \.self) { breakDuration in
                    
                                 Button(action: {
                                     pomodoroViewModel.breakTimeDuration = breakDuration * 60
                                     if pomodoroViewModel.currentTimerState != .running && pomodoroViewModel.currentBreakState != .running {
                                         pomodoroViewModel.timeRemaining = breakDuration * 60
                                     }
                                 }) {
                                     Text("\(pomodoroViewModel.breakTimeDuration == breakDuration * 60 ? "✓" : "   ") \(pomodoroViewModel.forTrailingZero(temp: breakDuration)) min")
                                    
                              }
                     
                    }
                
                  } label: {
                      Text("Break Duration")
                  }
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


//CHECK MARK
//Unicode: U+2713, UTF-8: E2 9C 93
