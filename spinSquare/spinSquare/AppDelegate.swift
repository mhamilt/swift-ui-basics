//
//  AppDelegate.swift
//  spinSquare
//
//  Created by admin on 09/06/2018.
//  Copyright © 2018 admin. All rights reserved.
//
//==============================================================================
import Cocoa
//==============================================================================
@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate
{
    //==========================================================================
    @IBOutlet weak var window: NSWindow!
    
    //==========================================================================
    func applicationDidFinishLaunching(_ aNotification: Notification)
    {
        let containerView = window.contentView!
        let view = NSView(frame: NSRect(x: 0, y: 0, width: 150, height: 150))
        containerView.wantsLayer = true
        view.wantsLayer = true
        
        containerView.layer?.backgroundColor = NSColor.blue.cgColor
        view.layer?.backgroundColor = NSColor.red.cgColor
        
        
        let containerFrame = containerView.frame
        let center = CGPoint(x: containerFrame.midX, y: containerFrame.midY)
        containerView.addSubview(view)
        
        //You have to set the positon and the anchor point so that the rotation is at center
        view.layer?.position = center
        view.layer?.anchorPoint = CGPoint(x: 0.7,y: 0.5)
        
        view.spinClockwise(timeToRotate: 3)
    }
    //==========================================================================
    func applicationWillTerminate(_ aNotification: Notification)
    {

    }
}
//==============================================================================
extension NSView
{
    //==========================================================================
    func spinClockwise(timeToRotate: Double)
    {
        startRotate(angle: CGFloat(-1 * M_PI * 2.0), speed: timeToRotate)
    }
    
    //==========================================================================
    func spinAntiClockwise(timeToRotate: Double)
    {
        startRotate(angle: CGFloat(M_PI * 2.0), speed: timeToRotate)
    }
    //==========================================================================
    func startRotate(angle: CGFloat, speed: Double)
    {
        
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = angle
        rotateAnimation.duration = speed
        rotateAnimation.repeatCount = .infinity
        
        self.layer?.add(rotateAnimation, forKey: nil)
        
        Swift.print("Start rotating")
    }
    //==========================================================================
    func stopAnimations()
    {
        self.layer?.removeAllAnimations()
        Swift.print("Stop rotating")
    }
    //==========================================================================
}

