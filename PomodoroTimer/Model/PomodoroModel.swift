//
//  PomodoroModel.swift
//  PomodoroTimer
//
//  Created by Yash Poojary on 25/05/22.
//

import Foundation

enum TimerState {
    case PomodoroTimer
    case PomodoroBreak
}

enum PomodoroTimer {
    case running
    case stop
}

enum PomodoroBreak {
    case running
    case stop
}
