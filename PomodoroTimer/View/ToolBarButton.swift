//
//  ToolBarButton.swift
//  PomodoroTimer
//
//  Created by Yash Poojary on 07/06/22.
//

import SwiftUI

struct ToolBarButton: View {
    @ObservedObject var pomodoroViewModel: PomodoroViewModel
    
    
    var body: some View {
        
        
        if #available(macOS 12.0, *) {
            
            
            
            Menu {
                Menu {
                    ForEach(pomodoroViewModel.timerDurationArray, id: \.self) { timerDuration in
                        Button(action: {
                            pomodoroViewModel.timerDuration = timerDuration * 60
                            if pomodoroViewModel.currentTimerState != .running && pomodoroViewModel.currentBreakState != .running && pomodoroViewModel.currentState == .PomodoroTimer {
                                pomodoroViewModel.timeRemaining = timerDuration * 60
                            }
                        }) {
                            Text("\(pomodoroViewModel.timerDuration == timerDuration * 60 ? "✓" : "   ") \(pomodoroViewModel.forTrailingZero(temp: timerDuration)) min")
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                            
                        }
                    }
                    
                } label: {
                    Text("Focus Duration")
                }
                
                Menu {
                    
                    ForEach(pomodoroViewModel.breakDurationArray, id: \.self) { breakDuration in
                        
                        Button(action: {
                            pomodoroViewModel.breakTimeDuration = breakDuration * 60
                            if pomodoroViewModel.currentTimerState != .running && pomodoroViewModel.currentBreakState != .running && pomodoroViewModel.currentState == .PomodoroBreak {
                                pomodoroViewModel.timeRemaining = breakDuration * 60
                            }
                        }) {
                            Text("\(pomodoroViewModel.breakTimeDuration == breakDuration * 60 ? "✓" : "   ") \(pomodoroViewModel.forTrailingZero(temp: breakDuration)) min")
                            
                        }
                        
                    }
                    
                } label: {
                    Text("Break Duration")
                }
                
                Button(action: {
              
                    
                    NSApplication.shared.terminate(nil)
                }) {
                    Text("Quit Timer")
                }
                
            }
            
            
            label : {
                Text("Settings")
                
            }
            .padding(.trailing)
            .menuIndicator(.hidden)
            
        } else {
            Menu {
                Menu {
                    ForEach(pomodoroViewModel.timerDurationArray, id: \.self) { timerDuration in
                        Button(action: {
                            pomodoroViewModel.timerDuration = timerDuration * 60
                            if pomodoroViewModel.currentTimerState != .running && pomodoroViewModel.currentBreakState != .running && pomodoroViewModel.currentState == .PomodoroTimer {
                                pomodoroViewModel.timeRemaining = timerDuration * 60
                            }
                        }) {
                            Text("\(pomodoroViewModel.timerDuration == timerDuration * 60 ? "✓" : "   ") \(pomodoroViewModel.forTrailingZero(temp: timerDuration)) min")
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                            
                        }
                    }
                    
                } label: {
                    Text("Focus Duration")
                }
                
                Menu {
                    
                    ForEach(pomodoroViewModel.breakDurationArray, id: \.self) { breakDuration in
                        
                        Button(action: {
                            pomodoroViewModel.breakTimeDuration = breakDuration * 60
                            if pomodoroViewModel.currentTimerState != .running && pomodoroViewModel.currentBreakState != .running && pomodoroViewModel.currentState == .PomodoroBreak {
                                pomodoroViewModel.timeRemaining = breakDuration * 60
                            }
                        }) {
                            Text("\(pomodoroViewModel.breakTimeDuration == breakDuration * 60 ? "✓" : "   ") \(pomodoroViewModel.forTrailingZero(temp: breakDuration)) min")
                            
                        }
                        
                    }
                    
                } label: {
                    Text("Break Duration")
                }
                
                Button(action: {
                    if let window = NSApplication.shared.windows.first {
                        window.performClose(self)
                    }
                }) {
                    Text("Quit Timer")
                }
                
            }
            
            
            label : {
                Text("Settings")
            }
            
        }
        
        
    }
}
