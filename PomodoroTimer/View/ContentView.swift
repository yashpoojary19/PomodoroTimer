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
                    .stroke(pomodoroViewModel.currentState == .PomodoroTimer ? pomodoroViewModel.currentTimerState.elementColor().opacity(0.31) :  pomodoroViewModel.currentBreakState.elementColor().opacity(0.31), style: StrokeStyle(lineWidth: 14, lineCap: .square, lineJoin: .round))
                    .frame(width: 180)
                
                Circle()
                    .trim(from: 0, to: pomodoroViewModel.progress)
                    .stroke(pomodoroViewModel.currentState == .PomodoroTimer ? pomodoroViewModel.currentTimerState.elementColor() :  pomodoroViewModel.currentBreakState.elementColor(), style: StrokeStyle(lineWidth: 14, lineCap: .round, lineJoin: .round))
                    .frame(width: 180, height: 180)
                    .rotationEffect(.init(degrees: -90))
                    .animation(.linear, value: 2)
                
                Circle()
                    .fill(Color.white)
                //                    .fill(Color("timerStopColor").opacity(0.8))
                //                    .fill(pomodoroViewModel.currentState == .PomodoroTimer ? pomodoroViewModel.currentTimerState.elementColor().opacity(0.1) :  pomodoroViewModel.currentBreakState.elementColor().opacity(0.1))
                    .frame(width: 8, height: 8)
                    .offset(x: 0, y: -90)
                    .rotationEffect(.init(degrees: pomodoroViewModel.progress * 360))
                
                
                
                VStack {
                    
                    Text("\(pomodoroViewModel.currentState == .PomodoroTimer ? "Focus" : "Break")")
                        .font(Font.custom("Roboto-Medium", size: 12))
                        .foregroundColor(Color("timerStringColor"))
                    
//
//
                    
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
                                .frame(maxWidth: 120)
                        }
                       
                        
                        
                       
                    }
                    
                  
                    
                    //                        .padding(.bottom)
                    
                    Text("\(pomodoroViewModel.currentState == .PomodoroTimer ? pomodoroViewModel.currentTimerState.timerText() :  pomodoroViewModel.currentBreakState.timerText())")
                        .font(Font.custom("Roboto-Medium", size: 12))
                        .foregroundColor(Color("timerSubTextColor"))
                        .offset(x: 0, y: 10)
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
       

        
        .onChange(of: pomodoroViewModel.timeRemaining) { time in
            
            switch pomodoroViewModel.currentState {
            case .PomodoroTimer:
                if time == 0 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                        pomodoroViewModel.startBreak()
                    }
                    
                }
                
            case .PomodoroBreak:
                if time == 0 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                        pomodoroViewModel.resetTimer()
                    }
                    
                }
                
            }
            
        }
//        .onReceive(pomodoroViewModel.timer) { time in
//            
//            
//            
//            if pomodoroViewModel.currentTimerState != .stop || pomodoroViewModel.currentBreakState != .stop  {
//                pomodoroViewModel.updateTimer()
//                if pomodoroViewModel.timeRemaining >= 0 {
//                    pomodoroViewModel.timeRemaining -= 1
//                    
//                }
//            }
//            
//        }
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
