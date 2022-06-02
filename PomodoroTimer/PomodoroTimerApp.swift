//
//  PomodoroTimerApp.swift
//  PomodoroTimer
//
//  Created by Yash Poojary on 25/05/22.
//

import SwiftUI

@main
struct PomodoroTimerApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var pomodoroViewModel = PomodoroViewModel()
    
    @Environment(\.scenePhase) var phase
    @State var lastActiveDateStamp = Date()
    var body: some Scene {
        WindowGroup {
            ContentView(pomodoroViewModel: pomodoroViewModel)
                .frame(width: 400, height: 300)
            
        }
//        .onChange(of: phase) { newValue in
//            if newValue == .background {
//                print("I am in background")
//                lastActiveDateStamp = Date()
//            }
//
//            if newValue == .active {
//                print("I am active")
//                let currentTimeStampDifference = Date().timeIntervalSince(lastActiveDateStamp)
//                if pomodoroViewModel.timeRemaining - Double(currentTimeStampDifference) <= 0 {
//
//                    // when the difference is negative
//
//                    switch pomodoroViewModel.currentState {
//                    case .PomodoroTimer:
//                        pomodoroViewModel.currentState = .PomodoroBreak
//                        pomodoroViewModel.timeRemaining = pomodoroViewModel.breakTimeDuration
//                    case .PomodoroBreak:
//                        pomodoroViewModel.currentState = .PomodoroTimer
//                        pomodoroViewModel.timeRemaining = pomodoroViewModel.timerDuration
//                    }
//
//                } else {
//                    pomodoroViewModel.timeRemaining -= Double(currentTimeStampDifference)
//                }
//            }
//        }
    }
}


class AppDelegate: NSObject, NSApplicationDelegate {

//    var popover: NSPopover!
    var statusBarItem: NSStatusItem!
//    var pomodoroViewModel: PomodoroViewModel!
    
    @MainActor func applicationDidFinishLaunching(_ aNotification: Notification) {
        
//        self.pomodoroViewModel = PomodoroViewModel()
        // Create the SwiftUI view that provides the window contents.
//        let contentView = ContentView(pomodoroViewModel: pomodoroViewModel)
      

        
        // Create the status item
        self.statusBarItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))
        
        if let button = self.statusBarItem.button {
            button.image = NSImage(systemSymbolName: "timer", accessibilityDescription: "timer icon")
            button.action = #selector(togglePopover(_:))
        }
    }
    
    @objc func togglePopover(_ sender: AnyObject?) {
        if let window = NSApplication.shared.windows.first {
            
            //
            
          
            
//            if window.i
       
            window.close()
           }
//        if let button = self.statusBarItem.button {
//            if self.popover.isShown {
//                self.popover.performClose(sender)
//            } else {
//                self.popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
//            }
//        }
    }
    
}

/*
 Notes:
 Break time updating to focus time when timer is stopped - Fixed
 Timer not counting down to 0 seconds - Fixed
 
 Pending
 1/06/2022
 Flip clock
 open and close window
 
 */
