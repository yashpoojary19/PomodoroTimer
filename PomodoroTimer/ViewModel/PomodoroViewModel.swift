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
    
    // Bool used to determine if current time has an hour component
    @Published var showOnlyMinutesAndSeconds = true
    
    

    @Published var currentState = TimerState.PomodoroTimer
    @Published var currentTimerState = PomodoroTimer.stop
    @Published var currentBreakState = PomodoroBreak.stop
    
    @Published var timerDuration: Double = 1*60
    @Published var breakTimeDuration: Double = 1*60
    
    @Published var currentTimerDuration: Double = 1*60
    @Published var currentBreakTimeDuration: Double = 1*60
    
    let timerDurationArray: [Double] = [1, 10, 25, 55, 90, 120]
    let breakDurationArray: [Double] = [1, 5, 10 , 15, 20, 30]
    
    
// For testing
//    let timerDurationArray: [Double] = [0.1, 1, 10, 25, 55, 90]
//    let breakDurationArray: [Double] = [0.1, 1, 5, 10 , 15, 20]

    
    // Indicates the remaining time when the timer is not running
    @Published var timeRemaining: Double = 1*60
    

    // Progress indicator for timer screen
    @Published var progress: CGFloat = 1
    
    
    //Animates the Timer Label
    @Published var animateBackLabelText = true
    @Published var animateFrontLabelText = true
    
    // Animates the Timer Caption
    @Published var animateBackText = true
    @Published var animateFrontText = true

   
    // Converting time values to string
    
    private(set) lazy var flipViewModels = { (0...5).map {
        _ in FlipViewModel() }}()
    
    
    var timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in })
    

    // Timer Controls
    
    private func initializeTimer() {
        
        var date = Date(timeIntervalSince1970: 1)
        timer =        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] (Timer) in
            let currentCalendar = Calendar.current
            date  = currentCalendar.date(byAdding: .second, value: -1, to: date)!
            
            let formatter = DateFormatter()
            formatter.timeZone = TimeZone(abbreviation: "UTC")
            
            
            formatter.dateFormat = "HHmmss"
            let new = formatter.string(from: date)
            self.setTimeInViewModels(time: new)
            if new == "000000" {
                self.timer.invalidate()
            }
        }

        
    }
    
    
    private func setupTimer(fromTime: Double) {
        timer.invalidate()
        var date = Date(timeIntervalSince1970: fromTime)
        
        
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] (Timer) in
            let currentCalendar = Calendar.current
            date  = currentCalendar.date(byAdding: .second, value: -1, to: date)!
            
            timeRemaining = date.timeIntervalSince1970
            print(timeRemaining)
 
            
            updateTimer()
            let formatter = DateFormatter()
            formatter.timeZone = TimeZone(abbreviation: "UTC")
            
            
            formatter.dateFormat = "HHmmss"

            
            let currentTime = formatter.string(from: date)
            
            // Checking if the current time has an hour component
            
            if currentTime.hasPrefix("00") {
                self.showOnlyMinutesAndSeconds = true
            } else {
                self.showOnlyMinutesAndSeconds = false
            }
            
            print(currentTime)
            self.setTimeInViewModels(time: currentTime)
        
            
            
            if currentTime == "000000" {
                self.timer.invalidate()
                switch currentState {
                case .PomodoroTimer:
                    addNotification()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                        self.startBreak()
                    }
                case .PomodoroBreak:
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                        self.resetTimer()
                    }
                    
                }
                
            }
        }
        
        RunLoop.main.add(timer, forMode: .common)

    }
   private func resetTimer() {
       
       
        currentTimerDuration = timerDuration
        currentState = .PomodoroTimer
        currentTimerState = .stop
        timeRemaining = currentTimerDuration
        progress = 1
        currentBreakState = .stop
    }
    
    
    
    private func updateTimer() {
        
        switch currentState {
        case .PomodoroTimer:
            withAnimation(Animation.easeIn(duration: 0.4)) {
                progress = (timeRemaining) / currentTimerDuration
            }
        case .PomodoroBreak:
            withAnimation(Animation.easeIn(duration: 0.4)) {
                progress = (timeRemaining) / currentBreakTimeDuration
            }

        }

    }
    
    
    
     func stopTimer() {

        self.timer.invalidate()
        timeRemaining = breakTimeDuration
        currentTimerState = .stop
        currentState = .PomodoroBreak
        progress = 1
        
    }
    
     func startTimer() {
        setupTimer(fromTime: timerDuration)
        
        // Delay added for flip animation
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
            self.currentTimerDuration = self.timerDuration
            self.currentState = .PomodoroTimer
            self.currentTimerState = PomodoroTimer.running
            self.timeRemaining = self.currentTimerDuration
        }
        
        
    }
    
     func startBreak() {
        
        setupTimer(fromTime: breakTimeDuration)
        
        // Delay added for flip animation
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
            self.progress = 1
            self.currentBreakTimeDuration =  self.breakTimeDuration
            self.currentState = .PomodoroBreak
            self.currentBreakState = .running
            self.timeRemaining =  self.currentBreakTimeDuration
        }
        
    }
    
     func stopBreak() {
        self.timer.invalidate()
        currentBreakState = .stop
        currentState = .PomodoroTimer
        currentTimerState = .stop
        timeRemaining = timerDuration
        progress = 1
    }
    
    
    override init() {
        super.init()
        self.initializeTimer()
        self.requestNotification()
    }
    
    //Text Formatting
    
    private func setTimeInViewModels(time: String) {
        zip(time, flipViewModels).forEach { number, viewModel in
            viewModel.text = "\(number)"
        }
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

    
    // Animation Controls
    
    
    // Timer Caption Text
    func animatefrontText() {
        animateFrontText = false

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation(.linear(duration: 0.2)) {
                self.animateFrontText = true
            }

        }
    }
    
    func animatebackText() {
        animateBackText = false

        DispatchQueue.main.asyncAfter(deadline: .now()) {
            withAnimation(.linear(duration: 0.2)) {
                self.animateBackText = true
            }

        }
    }
    
    
    // Timer Label Text
    func animatefrontLabelText() {
        animateFrontLabelText = false

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation(.linear(duration: 0.2)) {
                self.animateFrontLabelText = true
            }

        }
    }
    
    
    func animatebackLabelText() {
        animateBackLabelText = false

        DispatchQueue.main.asyncAfter(deadline: .now()) {
            withAnimation(.linear(duration: 0.2)) {
                self.animateBackLabelText = true
            }

        }
    }
    
    
    
    // Notification Settings
    
    private func requestNotification() {
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
    
    private func addNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Pomodoro Focus Timer"
        content.subtitle = "Your session has ended!"
        content.sound = UNNotificationSound.default
        
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(1), repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
}

