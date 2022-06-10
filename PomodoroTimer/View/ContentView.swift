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
            
            ZStack {
                
                Image("timerBG")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 165, height: 165)
                
                Circle()
                    .stroke(pomodoroViewModel.currentState == .PomodoroTimer ? pomodoroViewModel.currentTimerState.indicatorColor() :  pomodoroViewModel.currentBreakState.indicatorColor(), style: StrokeStyle(lineWidth: 14, lineCap: .square, lineJoin: .round))
                    .frame(width: 180)
                
                Circle()
                    .trim(from: 0, to: pomodoroViewModel.progress)
                    .stroke(pomodoroViewModel.currentState == .PomodoroTimer ? pomodoroViewModel.currentTimerState.elementColor() :  pomodoroViewModel.currentBreakState.elementColor(), style: StrokeStyle(lineWidth: 14, lineCap: .round, lineJoin: .round))
                    .frame(width: 180, height: 180)
                    .rotationEffect(.init(degrees: -90))
                    .animation(.linear, value: 2)
                
                Circle()
                    .fill(pomodoroViewModel.currentState == .PomodoroTimer ? pomodoroViewModel.currentTimerState.indicatorColor() :  pomodoroViewModel.currentBreakState.indicatorColor())
                    .frame(width: 8, height: 8)
                    .offset(x: 0, y: -90)
                    .rotationEffect(.init(degrees: pomodoroViewModel.progress * 360))
                
                
                
                VStack(spacing: 0) {
                    
                    // Timer Label
                    
                    ZStack {
                        Text("\(pomodoroViewModel.currentState == .PomodoroTimer ? "Break" : "Focus")")
                            .opacity(pomodoroViewModel.animateBackLabelText ? 0 : 1)
                            .scaleEffect(pomodoroViewModel.animateBackLabelText ? 0 : 1)
                            .onChange(of: pomodoroViewModel.currentState) { _ in
                                pomodoroViewModel.animatebackLabelText()
                                print("This is the current state", pomodoroViewModel.currentState)

                            }

                        Text("\(pomodoroViewModel.currentState == .PomodoroTimer ? "Focus" : "Break")")
                            .scaleEffect(pomodoroViewModel.animateFrontLabelText ? 1 : 0.2)
                            .opacity(pomodoroViewModel.animateFrontLabelText ? 1 : 0.2)
                            .onChange(of: pomodoroViewModel.currentState) { _ in

                                pomodoroViewModel.animatefrontLabelText()


                            }
                            
                    }
                    .font(Font.custom("Roboto-Medium", size: 12))
                    .foregroundColor(Color("timerStringColor"))
                    .offset(x: 0, y: 2)
                    
               


                    
                    ZStack {
                        
                        if pomodoroViewModel.currentBreakState == .stop && pomodoroViewModel.currentTimerState == .stop {
                            
                            
                            Text("\(pomodoroViewModel.timeString(time: pomodoroViewModel.timeRemaining))")
                                .foregroundColor(Color("timerStringColor"))
                                .font(Font.custom("RobotoMono-Bold", size: 35))
                                .lineLimit(1)
                                .minimumScaleFactor(0.5)
                                .frame(maxWidth: 120)
                            
                        } else {
                            ClockView(viewModel: pomodoroViewModel)
                            
                        }
                        
                    }
                    
                   
                    // Timer Caption
                    
                    ZStack {
                        
                        
                        
                        // Animating previous state text on state change
                        
                        Text("\(pomodoroViewModel.currentState == .PomodoroTimer ? pomodoroViewModel.currentTimerState.backTimerText() :  pomodoroViewModel.currentBreakState.backTimerText())")
                            .opacity(pomodoroViewModel.animateBackText ? 0 : 1)
                            .scaleEffect(pomodoroViewModel.animateBackText ? 0 : 1)
                            .onChange(of: pomodoroViewModel.currentTimerState) { _ in
                                
                                pomodoroViewModel.animatebackText()
                                
                            }
                            .onChange(of: pomodoroViewModel.currentState) { _ in
                                pomodoroViewModel.animatebackText()
                                
                            }
                        
                        // Animating current state text on state change
                        
                        Text("\(pomodoroViewModel.currentState == .PomodoroTimer ? pomodoroViewModel.currentTimerState.timerText() :  pomodoroViewModel.currentBreakState.timerText())")
                            .scaleEffect(pomodoroViewModel.animateFrontText ? 1 : 0.2)
                            .opacity(pomodoroViewModel.animateFrontText ? 1 : 0.2)
                            .onChange(of: pomodoroViewModel.currentTimerState) { _ in
                                
                                pomodoroViewModel.animatefrontText()
                            }
                            .onChange(of: pomodoroViewModel.currentState) { _ in
                                
                                pomodoroViewModel.animatefrontText()
                                
                                
                            }
                        
                        
                    }
                    .font(Font.custom("Roboto-Medium", size: 12))
                    .foregroundColor(Color("timerSubTextColor"))
                    .offset(x: 0, y: 5)
                    
                    
                    
                    
                    
                }
                .alert(isPresented: $showTimerAlert) {
                    Alert(
                        title: Text("Finish earlier"),
                        message: Text("Are you sure you want to finish the round earlier?"),
                        primaryButton: .default(Text("Yes"), action: {
                            pomodoroViewModel.stopTimer()
                        }),
                        secondaryButton: .cancel(Text("Cancel"), action: {
                            
                        })
                    )
                }
                
                
            }
            
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
            .alert(isPresented: $showBreakTimerAlert) {
                Alert(
                    title: Text("Skipping the break"),
                    message: Text("Are you sure you want to skip your break earlier?"),
                    primaryButton: .default(Text("Yes"), action: {
                        pomodoroViewModel.stopBreak()
                    }),
                    secondaryButton: .cancel(Text("Cancel"), action: {
                        //
                    })
                )
            }
            .background(pomodoroViewModel.currentState == .PomodoroTimer ? pomodoroViewModel.currentTimerState.elementColor() :  pomodoroViewModel.currentBreakState.elementColor())
            .clipShape(Capsule())
            .buttonStyle(.borderless)
            .padding(.bottom)
            
            
        }
     
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("backgroundColor"))
        
        .onAppear {
            pomodoroViewModel.currentTimerState = .stop
            pomodoroViewModel.currentState = .PomodoroTimer
        }
        
        
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        let viewModel = PomodoroViewModel()
        ContentView(pomodoroViewModel: viewModel)
            .frame(width: 400, height: 350)
    }
}



