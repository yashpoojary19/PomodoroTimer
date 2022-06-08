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
    @ObservedObject var pomodoroViewModel = PomodoroViewModel()
    
    @Environment(\.scenePhase) var phase
    @State var lastActiveDateStamp = Date()
    var body: some Scene {
        WindowGroup {
            
            ZStack { EmptyView() }
           
            
        }
      
    }
}


class AppDelegate: NSObject, NSApplicationDelegate, NSPopoverDelegate, NSWindowDelegate {
    
    //    var popover: NSPopover!
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
        
      
        window.center()
        window.isReleasedWhenClosed = false
//        window.hasShadow = true
        window.title = "Pomodoro Focus Timer App"
        
        window.styleMask.remove(.resizable)
        window.styleMask.remove(NSWindow.StyleMask.resizable)
        
   
    
        
 
        
        
//        window.toolbarStyle = .unified
        window.makeKeyAndOrderFront(true)
        window.standardWindowButton(.zoomButton)?.isEnabled = false
        window.isOpaque = false
        window.isMovableByWindowBackground = true
        window.backgroundColor = NSColor.clear
        window.titlebarAppearsTransparent = false
       
        window.level = .floating
        window.toolbarStyle = .automatic
        
//        window?.styleMask.remove(NSWindow.StyleMask.resizable)
       
        window.contentView = NSHostingView(rootView: contentView)
       
       
//        window.contentView?.wantsLayer = true
     
        
        
        
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
      
        
            
            
//            button.layer?.cornerRadius = 25
//
//            button.layer?.borderWidth = 0.8
//            button.layer?.backgroundColor = .black
//            button.isBordered = true
//            button.layer?.masksToBounds = true
//
//            button.layer?.borderColor = .white
            
            
            
//            button.layer?.backgroundColor = .clear
//
//            button.layer?.cornerRadius = 8.0
//            button.layer?.borderWidth = 1.0
          
            button.imagePosition = .imageOverlaps
 
            button.image = NSImage(named: "Bezel")
//            button.image = NSImage(systemSymbolName: "rectangle", accessibilityDescription: "timer icon")
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
//            window.level = .floating
            
            window.makeKeyAndOrderFront(self)
            
        }
        
        
        
    }
    
    
}

/*

 
 7/06
 Button with indicator and border
 Resz
 Not Firing on NSM
 Animation
 Default Value
 */
