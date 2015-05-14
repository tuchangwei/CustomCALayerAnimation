//
//  ProgressLayer.swift
//  ProgressDeml
//
//  Created by vale on 5/13/15.
//  Copyright (c) 2015 changweitu@gmail.com. All rights reserved.
//

import UIKit

protocol ProgressLayerDelegate {
    
    func progressLayerAnimationComplete()
    
}

class ProgressLayer: CAShapeLayer {
   
    var timer:NSTimer!
    var delegate1: ProgressLayerDelegate?
    var progress = 0.0 {
        
        didSet {
            
            if progress > 0 {
                
                let animation = CABasicAnimation(keyPath: "strokeEnd")
                animation.fromValue = self.progress == 0 ? 0 : nil;
                animation.toValue = self.progress > 1 ? 1:self.progress
                animation.duration = 1
                animation.delegate = self
                self.strokeEnd = CGFloat(progress)
                self.addAnimation(animation, forKey: "animation")
                
                
            } else {
                
                self.strokeEnd = CGFloat(0.0)
                self.removeAnimationForKey("animation")
                
            }
        }
    }
    func startProgress() {
        
        if self.timer == nil {
            
            self.timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "animate", userInfo: nil, repeats: true)
            self.timer.fire()
        }

    }
    
    func animate() {
        
        if self.progress > 1.1 {
            
            self.timer.invalidate()
            self.timer = nil
            return
        }
        self.progress += 0.01;
    }
    
    func stopProgress()  {
        
        if self.timer != nil {
            
            
            self.timer.invalidate()
            self.timer = nil
        }
        
    }
    
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        
        if self.progress > 1.1 {
            
            self.delegate1?.progressLayerAnimationComplete()
        }
    }
}
