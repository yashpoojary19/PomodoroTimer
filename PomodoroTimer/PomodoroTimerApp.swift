//
//  PomodoroTimerApp.swift
//  PomodoroTimer
//
//  Created by Yash Poojary on 25/05/22.
//

import SwiftUI
import AppKit


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
    
    //    var popover: NSPopover!
    var statusBarItem: NSStatusItem!
    var pomodoroViewModel: PomodoroViewModel!
    var window: NSWindow!
    
    
    
    @MainActor func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        self.pomodoroViewModel = PomodoroViewModel()
        
        let contentView = ContentView(pomodoroViewModel: pomodoroViewModel)
        
        
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 400, height: 300),
            styleMask: [.titled, .closable, .fullScreen],
            backing: .buffered,
            defer: false)
        
        
        window.center()
        window.isReleasedWhenClosed = false
        
        window.title = "   Pomodoro Focus Timer App"
        
        window.toolbarStyle = .unified
        window.makeKeyAndOrderFront(nil)
        
        window.contentView = NSHostingView(rootView: contentView)
        
        window.titlebarAppearsTransparent = true
        window.maxSize = NSSize(width: 400, height: 300)
        
        window.toolbar = NSToolbar()
        
        
        
        let toolbarButtons = NSHostingView(rootView: ToolBarButton(pomodoroViewModel: pomodoroViewModel))
        toolbarButtons.frame.size = toolbarButtons.fittingSize
        
        
        let titlebarAccessory = NSTitlebarAccessoryViewController()
        
        titlebarAccessory.view = toolbarButtons
        titlebarAccessory.layoutAttribute = .trailing
        
        window.addTitlebarAccessoryViewController(titlebarAccessory)
        
        
        window.contentViewController?.view.window?.makeKey()
        
        
        self.statusBarItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))
        
        if let button = self.statusBarItem.button {
            button.title = pomodoroViewModel.timeString(time: pomodoroViewModel.timeRemaining)
//            print(pomodoroViewModel.timeString(time: pomodoroViewModel.timeRemaining))
          
            
            
            
            
//            button.layer?.backgroundColor = .clear
//
//            button.layer?.cornerRadius = 8.0
//            button.layer?.borderWidth = 1.0
    
            //            button.image = NSImage(systemSymbolName: "timer", accessibilityDescription: "timer icon")
            button.action = #selector(toggleWindow(_:))
        }
        
        
    }
    
    
    
    
    
    
    @objc func toggleWindow(_ sender: AnyObject?) {
        
        if self.window.isVisible {
            window.orderOut(self)
            
        } else {
            window.level = .floating
            
            window.orderFront(self)
            
        }
        
        
        
    }
    
}

/*
 Notes:
 Break time updating to focus time when timer is stopped - Fixed
 Timer not counting down to 0 seconds - Fixed
 
 Pending
 1/06/2022
 Flip clock
 Transition from active to background - done
 Only closable - done
 show navigation bar - done
 
 6/06/2022
 Centre title
 Connect flip clock
 RE
 
 
 
 */
