//
//  ViewController.swift
//  NSTrackingAreaTest
//
//  Created by hashimoto wataru on 2017/08/21.
//  Copyright © 2017年 wataruhash.info. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    let customCursor = NSCursor.iBeam
    
    var trackingArea: NSTrackingArea!
    
    var trackingRect: NSRect {
        let bounds = self.view.bounds
        let w = (bounds.width / 2.0)
        let h = (bounds.height / 2.0)
        
        return NSRect(x: (bounds.width - w) / 2.0,
                      y: (bounds.height - h) / 2.0,
                      width: w,
                      height: h)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.trackingArea = NSTrackingArea(rect: self.trackingRect,
                                           options: [.activeAlways, .mouseEnteredAndExited, .mouseMoved],
                                           owner: self,
                                           userInfo: nil)
        
        self.view.addTrackingArea(self.trackingArea)
    }
    
    override func loadView() {
        let view = NSView(frame: NSRect(x: 0.0, y: 0.0, width: 640, height: 480))
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.green.cgColor
        
        self.view = view
    }
    
    func switchTracking() {
        let add: Bool = (self.view.trackingAreas.count == 0)
        print("add?", add)
        print("tracking area? \(self.trackingArea)")
        
        if add {
            self.view.addTrackingArea(self.trackingArea)
        }
        else {
            self.view.removeTrackingArea(self.trackingArea)
        }
    }
    
    func pushCustomCursor() {
        self.customCursor.push()
    }
    
    func popCustomCursor() {
        self.customCursor.pop()
    }
    
    override func mouseMoved(with event: NSEvent) {
        //print("moved")
    }
    
    override func mouseEntered(with event: NSEvent) {
        print("entered")
        self.pushCustomCursor()
    }
    
    override func mouseExited(with event: NSEvent) {
        print("exited")
        self.popCustomCursor()
    }
    
    override func mouseUp(with event: NSEvent) {
        print("mouse up")
        self.switchTracking()
    }
}
