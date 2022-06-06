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
            
            ZStack { EmptyView() }
//                        ContentView(pomodoroViewModel: pomodoroViewModel)
//                            .frame(width: 400, height: 300)
            
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


class AppDelegate: NSObject, NSApplicationDelegate, NSPopoverDelegate {
    
    var popover: NSPopover!
    var statusBarItem: NSStatusItem!
    var pomodoroViewModel: PomodoroViewModel!
    var window: NSWindow!
    
    
    @MainActor func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        self.pomodoroViewModel = PomodoroViewModel()
        //         Create the SwiftUI view that provides the window contents.
        let contentView = ContentView(pomodoroViewModel: pomodoroViewModel)
        
        
        //        window = NSWindow(
        //            contentRect: NSRect(x: 0, y: 0, width: 400, height: 300),
        //            styleMask: [.titled, .closable, .fullScreen],
        //            backing: .buffered,
        //            defer: false)
        //
        //        window.center()
        //        window.isReleasedWhenClosed = false
        //        window.title = "Pomodoro Focus Timer"
        //        window.makeKeyAndOrderFront(nil)
        //        window.toolbarStyle = .automatic
        //        window.contentView = NSHostingView(rootView: contentView)
        //
        //
        //
        //        window.contentViewController?.view.window?.makeKey()
        
        // Create the status item
        self.statusBarItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))
        
        if let button = self.statusBarItem.button {
            button.image = NSImage(systemSymbolName: "timer", accessibilityDescription: "timer icon")
            button.action = #selector(togglePopover(_:))
        }
        
        
        self.popover = NSPopover()
        self.popover.contentSize = NSSize(width: 300, height: 300)
        self.popover.behavior = .transient
        self.popover.delegate = self
        self.popover.contentViewController = NSHostingController(rootView: contentView)
        let detach = NSSelectorFromString("detach")
        if popover.responds(to: detach) {
            popover.perform(detach)
        }
        
    }
    
    @objc func togglePopover(_ sender: AnyObject?) {
        
        
        
        
        
        if let button = statusBarItem.button {
            if popover.isShown {
                self.popover.performClose(sender)
            } else {
                
//                popover.show(relativeTo: .init(origin: CGPoint(x: 500, y: 500), size: button.bounds.size), of: button, preferredEdge: .maxY)
                popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            }
        }
        
    }
    
    func popoverShouldDetach(_ popover: NSPopover) -> Bool {
        return true
    }
    
    
  
    
    
    
    //    @objc func togglePopover(_ sender: AnyObject?) {
    //
    //        if self.window.isVisible {
    //
    //
    //
    //            window.miniaturize(sender)
    //
    //        } else {
    //
    //
    ////            window.miniaturize(self)
    //        }
    //
    //
    //
    ////        if let appWindow = NSApplication.shared.windows.first {
    //
    //
    //
    //
    //
    //
    //            //            if window.i
    //
    //            //            window.close()
    ////        }
    ////                if let button = self.statusBarItem.button {
    ////                    if self.popover.isShown {
    ////                        self.popover.performClose(sender)
    ////                    } else {
    ////                        self.popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
    ////                    }
    ////                }
    //    }
    
}

/*
 Notes:
 Break time updating to focus time when timer is stopped - Fixed
 Timer not counting down to 0 seconds - Fixed
 
 Pending
 1/06/2022
 Flip clock
 Transition from active to background
 Only closable
 show navigation bar
 
 */
