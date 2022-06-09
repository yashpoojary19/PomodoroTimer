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
    var body: some Scene {
        WindowGroup {

            ZStack { EmptyView() }

        }
      
    }
}


class AppDelegate: NSObject, NSApplicationDelegate, NSPopoverDelegate, NSWindowDelegate {
    

    var statusBarItem: NSStatusItem!
    var pomodoroViewModel: PomodoroViewModel!
    var window: NSWindow!
   

    @MainActor func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        self.pomodoroViewModel = PomodoroViewModel()
        
        let contentView = ContentView(pomodoroViewModel: pomodoroViewModel).onAppear {
            self.window.styleMask.remove(.resizable)
        }
        
     
     
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 400, height: 350),
            styleMask: [.titled, .closable, .fullSizeContentView],
            backing: .buffered,
            defer: false)
 
        // Window UI
        
        window.title = "Pomodoro Focus Timer App"
        
        window.center()
        window.isReleasedWhenClosed = false
        
        window.standardWindowButton(.zoomButton)?.isEnabled = false
        window.isMovableByWindowBackground = true
        
        
        window.makeKeyAndOrderFront(true)
        window.backgroundColor = NSColor.clear
    
        window.level = .floating
        window.toolbarStyle = .automatic
        
       
        window.contentView = NSHostingView(rootView: contentView)

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
      
            
           
            
          
//            button.imagePosition = .imageOverlaps
//
//            button.image = NSImage(named: "Bezel")
            
            button.image = NSImage(systemSymbolName: "timer", accessibilityDescription: "Timer")
            button.action = #selector(toggleWindow(_:))
        }
        
        
    }
    

    
    func window(_ window: NSWindow, willResizeForVersionBrowserWithMaxPreferredSize maxPreferredFrameSize: NSSize, maxAllowedSize maxAllowedFrameSize: NSSize) -> NSSize {
        NSSize(width: 400, height: 350)
        
    }

    
    @objc func toggleWindow(_ sender: AnyObject?) {
        
        if self.window.isVisible {
            window.orderOut(self)
            
        } else {

            window.makeKeyAndOrderFront(self)
            
        }

    }

}
