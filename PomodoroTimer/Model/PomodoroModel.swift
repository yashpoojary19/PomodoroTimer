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
    
    // Timer View UI Elements
    
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
    
    func indicatorColor() -> Color {
        switch self {
        case .running:
            return Color("timerStopColorLight")
        case .stop:
            return Color("timerPrimaryColorLight")
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
    
    func backTimerText() -> String {
        switch self {
        case .running:
            return "Ready?"
        case .stop:
            return "Relax!"
        }
    }
    
}

enum PomodoroBreak {
    case running
    case stop
    
    // Timer View UI Elements
    
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
    
    
    
    
    func indicatorColor() -> Color {
        switch self {
        case .running:
            return Color("breakColorLight")
        case .stop:
            return Color("breakColorLight")
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
    
    func backTimerText() -> String {
        
        switch self {
            
        case .running:
            return "Running..."
        case .stop:
            return "Relax!"
        }
    }
}
