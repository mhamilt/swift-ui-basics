//
//  customView.swift
//  cocoaXibTest
//
//  Created by admin on 09/06/2018.
//  Copyright © 2018 admin. All rights reserved.
//

import Cocoa

class customView: NSView
{
    //==========================================================================
    override init(frame frameRect: NSRect)
    {
        super.init(frame: frameRect)
        setup()
    }
    
    required init?(coder: NSCoder)
    {
        super.init(coder: coder)
    }
    //==========================================================================
    func setup()
    {
        Swift.print("view setup:")
        //----------------------------------------------------------------------
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.red.cgColor
        let app = NSApplication.shared().delegate as! AppDelegate
        let containerFrame = app.window.contentView!.frame
        let center = CGPoint(x: containerFrame.midX, y: containerFrame.midY)
        Swift.print("View Center Window: " + "\(center)")
        
        //You have to set the positon and the anchor point so that the rotation is at center
        app.window.contentView?.addSubview(self)
        
        let offsetFrameOrigin = CGPoint(x: center.x - self.bounds.width/2,
                                        y: center.y - self.bounds.height/2)
        Swift.print(offsetFrameOrigin, center)
        
        self.setFrameOrigin(offsetFrameOrigin)
        self.layer?.position = center
        self.layer?.anchorPoint = CGPoint(x: 0.5,y: 0.5)
        
        //----------------------------------------------------------------------
        addGestureRecognizer(
            NSPanGestureRecognizer(
                target: self,
                action: #selector(handleDrag(gestureRecognizer:)
                )
            )
        )
        //----------------------------------------------------------------------
        addGestureRecognizer(
            NSRotationGestureRecognizer(
                target: self,
                action: #selector(handleRotation(gestureRecognizer:)
                )
            )
        )
    }
    //==========================================================================
    func handleDrag(gestureRecognizer: NSPanGestureRecognizer)
    {
        Swift.print("Drag")
    }
    
    func handleRotation(gestureRecognizer: NSRotationGestureRecognizer)
    {
        Swift.print("Rotate")
    }
    
    override func mouseDown(with event: NSEvent)
    {
        Swift.print("Click Down")
        spinClockwise(timeToRotate: 1)
    }
    
    override func mouseUp(with event: NSEvent)
    {
        Swift.print("Click Up")
    }
    
    override func scrollWheel(with event: NSEvent)
    {
           Swift.print("Scroll")
    }
    //==========================================================================
    override func draw(_ dirtyRect: NSRect)
    {
        super.draw(dirtyRect)
        Swift.print("view Draw:")
    }
    
    //==========================================================================
    ///The less is the timeToRotate, the more fast the animation is !
    func spinClockwise(timeToRotate: Double)
    {
        startRotate(CGFloat(-1 * M_PI * 2.0), timeToRotate: timeToRotate)
    }
    //==========================================================================
    ///The less is the timeToRotate, the more fast the animation is !
    func spinAntiClockwise(timeToRotate: Double)
    {
        startRotate(CGFloat(M_PI * 2.0), timeToRotate: timeToRotate)
    }
    //==========================================================================
    func startRotate(_ angle: CGFloat, timeToRotate: Double)
    {
        
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = angle
        rotateAnimation.duration = timeToRotate
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
    
}
