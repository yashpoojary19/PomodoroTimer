//
//  PomodoroViewModel.swift
//  PomodoroTimer
//
//  Created by Yash Poojary on 25/05/22.
//

import Foundation


class PomodoroViewModel: ObservableObject {
    
    @Published var currentTimerState = PomodoroTimer.stop
    @Published var currentBreakState = PomodoroBreak.stop
    
//    let currentTimeBlock = 25*60
//    let currentBreakTime = 5*60
    
    @Published var timeRemaining: Double = 25*60
    
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
   
    
    func startTimer() {
        currentTimerState = PomodoroTimer.start
   
        self.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
      
        
    }
    
    func updateTimer() {
        
    }
    
    func stopTimer() {
        self.timer.upstream.connect().cancel()
    }
    
    
    func startBreak() {
        
    }
    
    func stopBreak() {
        
    }
    
  
    
    func timeString(time: TimeInterval) -> String {
            let hour = Int(time) / 3600
            let minute = Int(time) / 60 % 60
            let second = Int(time) % 60

            // return formated string
        if hour == 0  {
            return String(format: "%02i:%02i", minute, second)
        } else {
            return String(format: "%02i:%02i:%02i", hour, minute, second)
        }
            
        }
    
}
