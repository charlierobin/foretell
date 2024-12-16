//
//  AppDelegate.swift
//  ForeTellSwiftUIAppKitAppDelegate
//
//  Created by charlie on 14/12/2024.
//

import Cocoa
import SwiftUI

@main
class AppDelegate: NSObject, NSApplicationDelegate
{
    var window: NSWindow!

    var timer: Timer!
    
    var viewModel: ExternalModel!
    
    func applicationDidFinishLaunching(_ aNotification: Notification)
    {
        self.viewModel = ExternalModel()
        
        self.viewModel.app = self
        
        // Create the SwiftUI view that provides the window contents
        
        let contentView = ContentView(viewModel: viewModel)

        // Create the window and set the content view
        
        let frame = NSRect(x: 0, y: 0, width: 0, height: 0)
        
//        let style: NSWindow.StyleMask = [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView]
        let style: NSWindow.StyleMask = []
        
        self.window = NSWindow( contentRect: frame, styleMask: style, backing: .buffered, defer: false )
        
        self.window.contentView = NSHostingView(rootView: contentView)
        
//        self.window.makeKeyAndOrderFront(nil)
        self.window.orderOut(self)
        
        self.window.backgroundColor = NSColor(red: 1, green: 1, blue: 1, alpha: 0.2)
        self.window.level = NSWindow.Level(rawValue: Constants.desktopWindowLevel)
        
        self.timer = Timer.scheduledTimer(withTimeInterval: Constants.testingUpdateIntervalInSeconds, repeats: true) // or Constants.updateIntervalInSeconds
        {
            timer in
            
            self.viewModel.update()
        }
        
        self.timer.fire()
    }

    func applicationWillTerminate(_ aNotification: Notification)
    {
        // Insert code here to tear down your application
    }
    
    func update()
    {
        let mainScreen = NSScreen.main
            
        let mainScreenVisibleFrame = mainScreen!.visibleFrame
        
        let frame = NSRect(x: mainScreenVisibleFrame.minX + Constants.margin, y: mainScreenVisibleFrame.maxY - Constants.height - Constants.margin, width: Constants.width, height: Constants.height)
        
        self.window.setFrame(frame, display: true)
        
        self.window.orderBack(self)
    }
}

