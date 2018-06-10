//
//  AppDelegate.swift
//  gestures
//
//  Created by admin on 09/06/2018.
//  Copyright © 2018 admin. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate
{

    @IBOutlet weak var window: NSWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification)
    {
        let view = customView(frame: NSRect(x: 0, y: 0, width: 50, height: 50))
        window.contentView!.wantsLayer = true
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.blue.cgColor
        window.contentView?.addSubview(view)
        
//        let containerFrame = window.contentView!.frame
//        let center = CGPoint(x: containerFrame.midX*0.2, y: containerFrame.midY)
//        let offsetFrameOrigin = CGPoint(x: center.x - view.bounds.width/2,
//                                        y: center.y - view.bounds.height/2)
//        view.setFrameOrigin(offsetFrameOrigin)
//        view.layer?.position = center
//        view.layer?.anchorPoint = CGPoint(x: 0.5,y: 0.5)
    }

    func applicationWillTerminate(_ aNotification: Notification)
    {
        // Insert code here to tear down your application
    }


}

