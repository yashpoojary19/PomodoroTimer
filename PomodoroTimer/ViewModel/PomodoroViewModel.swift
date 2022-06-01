//
//  PomodoroViewModel.swift
//  PomodoroTimer
//
//  Created by Yash Poojary on 25/05/22.
//

import Foundation
import UserNotifications
import SwiftUI

class PomodoroViewModel: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
    
   
    @Published var currentState = TimerState.PomodoroTimer
    @Published var currentTimerState = PomodoroTimer.stop
    @Published var currentBreakState = PomodoroBreak.stop
    
    @Published var timerDuration: Double = 0.1*60
    @Published var breakTimeDuration: Double = 0.1*60
    
    @Published var currentTimerDuration: Double = 0.1*60
    @Published var currentBreakTimeDuration: Double = 0.1*60
    
    let timerDurationArray: [Double] = [0.1, 10, 25, 55, 90]
    let breakDurationArray: [Double] = [0.1, 5, 10 , 15, 20]

    @Published var timeRemaining: Double = 0.1*60
    @Published var progress: CGFloat = 1
    
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
//    var breakTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    func resetTimer() {
        self.timer.upstream.connect().cancel()
        currentTimerDuration = timerDuration
        currentState = .PomodoroTimer
        currentTimerState = PomodoroTimer.stop
        timeRemaining = currentTimerDuration
        progress = 1
    }

    func startTimer() {
        currentTimerDuration = timerDuration
        currentState = .PomodoroTimer
        currentTimerState = PomodoroTimer.running
        timeRemaining = currentTimerDuration
        self.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    }
    
    func updateTimer() {
        
        switch currentState {
        case .PomodoroTimer:
            withAnimation(Animation.easeIn(duration: 0.4)) {
                progress = timeRemaining / currentTimerDuration
            }
          
        case .PomodoroBreak:
            withAnimation(Animation.easeIn(duration: 0.4)) {
                progress = timeRemaining / currentTimerDuration
            }
          
        }
        
      

    }
    
    func stopTimer() {
        self.timer.upstream.connect().cancel()
        timeRemaining = breakTimeDuration
        currentTimerState = .stop
        currentState = .PomodoroBreak
        progress = 1
    }
    
    func startBreak() {
        currentBreakTimeDuration = breakTimeDuration
        currentState = .PomodoroBreak
        currentBreakState = .running
        timeRemaining = currentBreakTimeDuration
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    }
    
    func stopBreak() {
        self.timer.upstream.connect().cancel()
        currentBreakState = .stop
        currentState = .PomodoroTimer
        timeRemaining = timerDuration
        progress = 1
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
    
        
  
    func forTrailingZero(temp: Double) -> String {
        let tempVar = String(format: "%g", temp)
        return tempVar
    }
    
    override init() {
        super.init()
        self.requestNotification()
    }
    
    func requestNotification() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("All set!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        
        UNUserNotificationCenter.current().delegate = self
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.sound, .banner])
    }
    
    func addNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Pomodoro Timer"
        content.subtitle = "Your session has ended!"
        content.sound = UNNotificationSound.default

       
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(timeRemaining), repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request)
    }
}
