//
//  ContentView.swift
//  PomodoroTimer
//
//  Created by Yash Poojary on 25/05/22.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var pomodoroViewModel: PomodoroViewModel
    @State private var showTimerAlert = false
    @State private var showBreakTimerAlert = false
    
    
    var body: some View {
        VStack {
            
        
            
            Text("\(pomodoroViewModel.currentState == .PomodoroTimer ? "Focus" : "Break")")
                .font(Font.custom("Roboto-Medium", size: 20))
                .foregroundColor(Color("timerStringColor"))
               
               
               
            
            Text("\(pomodoroViewModel.timeString(time: pomodoroViewModel.timeRemaining))")
                .foregroundColor(Color("timerStringColor"))
                .font(Font.custom("RobotoMono-Bold", size: 50))
                .padding()
             
            
            Button(action: {
                switch pomodoroViewModel.currentState {
                case .PomodoroTimer:
                    switch pomodoroViewModel.currentTimerState {
                    case .stop:
                        pomodoroViewModel.startTimer()
                    case .running:
                        showTimerAlert = true

                        
                    }
                    
                case .PomodoroBreak:
                    switch pomodoroViewModel.currentBreakState {
                    case .stop:
                        pomodoroViewModel.startBreak()
                    case .running:
                        showBreakTimerAlert = true
                        
                    }
                    
                }
                
                
            }) {
              
                Text(pomodoroViewModel.currentTimerState == .running || pomodoroViewModel.currentBreakState == .running ? "Stop Timer" : "Start Timer")
                    .padding(10)
                    .padding(.horizontal, 10)
                    .background(Color.green)
                    .clipShape(Capsule())
                    .foregroundColor(Color.white)
                   
                    
            }
            .buttonStyle(.borderless)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("backgroundColor"))
        .alert("Finsih earlier", isPresented: $showTimerAlert, actions: {
            // 1
            Button(action: {
                pomodoroViewModel.stopTimer()
            }) {
                Text("Yes")
                   
            }
              Button("Cancel", role: .cancel, action: {})

             
            }, message: {
              Text("Are you sure you want to finish the round earlier?")
            })
        .alert("Skipping the break", isPresented: $showBreakTimerAlert, actions: {
            // 1
            Button(action: {
                pomodoroViewModel.stopBreak()
            }) {
                Text("Yes")
                   
            }
              Button("Cancel", role: .cancel, action: {})

             
            }, message: {
              Text("Are you sure you want to skip your break earlier?")
            })
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
        .onChange(of: pomodoroViewModel.timeRemaining) { time in
            
            switch pomodoroViewModel.currentState {
            case .PomodoroTimer:
                if time == 0 {
                    pomodoroViewModel.startBreak()
                }
                
            case .PomodoroBreak:
                if time == 0 {
                    pomodoroViewModel.startTimer()
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

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}


//CHECK MARK
//Unicode: U+2713, UTF-8: E2 9C 93
