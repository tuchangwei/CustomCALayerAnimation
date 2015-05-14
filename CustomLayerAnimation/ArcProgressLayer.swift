//
//  ArcProgressLayer.swift
//  CustomLayerAnimation
//
//  Created by vale on 5/13/15.
//  Copyright (c) 2015 changweitu@gmail.com. All rights reserved.
//

import UIKit

class ArcProgressLayer: CAShapeLayer {
   
    var timer:NSTimer!
    
    func startProgress() {
        
        if self.timer == nil {
            
            self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "animate", userInfo: nil, repeats: true)
            self.timer.fire()
        }
        
    }
    
    func animate() {
        
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0
        animation.byValue = 2*M_PI
        
        animation.duration = 1
        self.addAnimation(animation, forKey: "animation")
    }
    
    func stopProgress()  {
        
        if self.timer != nil {
            
            self.timer.invalidate()
            self.timer = nil
        }
        
    }
}
