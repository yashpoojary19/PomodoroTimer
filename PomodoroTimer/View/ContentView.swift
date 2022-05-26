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
    @State var width: CGFloat = 0
    
    var body: some View {
        VStack {
            
           
            
            Text("\(pomodoroViewModel.currentState == .PomodoroTimer ? "Focus" : "Break")")
              
                .font(Font.custom("Roboto-Medium", size: 15))
                .foregroundColor(Color("timerStringColor"))
               
            ZStack {
                
                Circle()
                    .stroke(Color.black.opacity(0.2), style: StrokeStyle(lineWidth: 10, lineCap: .square, lineJoin: .round))
                    .frame(width: 180)
                
                Circle()
                    .trim(from: 0, to: pomodoroViewModel.progress)
                    .stroke(Color.black.opacity(0.5), style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                    .frame(width: 180, height: 180)
                    .rotationEffect(.init(degrees: -90))
                    .animation(.linear, value: 2)
                
                Text("\(pomodoroViewModel.timeString(time: pomodoroViewModel.timeRemaining))")
                    .foregroundColor(Color("timerStringColor"))
                    .font(Font.custom("RobotoMono-Bold", size: 40))
    //                .padding()
                 
               
            }
        
               
//            Text("\(pomodoroViewModel.currentState == .PomodoroTimer ? pomodoroViewModel.currentTimerState.timerText() :  pomodoroViewModel.currentBreakState.timerText())")
//                .font(Font.custom("Roboto-Medium", size: 15))
//                .foregroundColor(Color("timerStringColor"))
         
            
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
              
                Text(pomodoroViewModel.currentState == .PomodoroTimer ? pomodoroViewModel.currentTimerState.buttonText() :  pomodoroViewModel.currentBreakState.buttonText())
                    .foregroundColor(Color.white)
                    .frame(minWidth: 160)
                    .padding([.bottom, .vertical], 10)
                
                    

                   
                    
            }
            .background(pomodoroViewModel.currentState == .PomodoroTimer ? pomodoroViewModel.currentTimerState.elementColor() :  pomodoroViewModel.currentBreakState.elementColor())
            .clipShape(Capsule())
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
                pomodoroViewModel.updateTimer()
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
        let viewModel = PomodoroViewModel()
        ContentView(pomodoroViewModel: viewModel)
            .frame(width: 400, height: 300)
    }
}


//CHECK MARK
//Unicode: U+2713, UTF-8: E2 9C 93

struct AnimatableCustomFontModifier: ViewModifier, Animatable {
    var name: String
    var size: Double

    var animatableData: Double {
        get { size }
        set { size = newValue }
    }

    func body(content: Content) -> some View {
        content
            .font(.custom(name, size: size))
    }
}

extension View {
    func animatableFont(name: String, size: Double) -> some View {
        self.modifier(AnimatableCustomFontModifier(name: name, size: size))
    }
}