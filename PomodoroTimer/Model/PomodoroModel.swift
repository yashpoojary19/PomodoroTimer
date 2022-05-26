//
//  PomodoroModel.swift
//  PomodoroTimer
//
//  Created by Yash Poojary on 25/05/22.
//

import Foundation
import SwiftUI

enum TimerState {
    case PomodoroTimer
    case PomodoroBreak
    
  
}

enum PomodoroTimer {
    case running
    case stop
    
    func buttonText() -> String {
        switch self {
        case .running:
            return "Stop"
        case .stop:
            return "Start session"
        }
    }
    
    func elementColor() -> Color {
        switch self {
        case .running:
            return Color("timerStopColor")
        case .stop:
            return Color("timerPrimaryColor")
        }
    }
    
    func timerText() -> String {
        switch self {
        case .running:
            return "Running..."
        case .stop:
            return "Ready?"
        }
    }
}

enum PomodoroBreak {
    case running
    case stop
    
    func buttonText() -> String {
        switch self {
        case .running:
            return "Skip this break"
        case .stop:
            return "Start the break"
        }
    }
    
    func elementColor() -> Color {
        switch self {
        case .running:
            return Color("breakColor")
        case .stop:
            return Color("breakColor")
        }
    }
    
    func timerText() -> String {
        switch self {
        case .running:
            return "Relax!"
        case .stop:
            return "Relax!"
        }
    }
}
