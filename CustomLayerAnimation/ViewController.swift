//
//  ViewController.swift
//  CustomLayerAnimation
//
//  Created by vale on 5/13/15.
//  Copyright (c) 2015 changweitu@gmail.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController, PieSliceLayerDelegate, ProgressLayerDelegate {

    @IBOutlet weak var bgView: UIView!
    
    var circle:PieSliceLayer!
    var progressLayer:ProgressLayer!
    var arcProgressLayer: ArcProgressLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bgView.layer.cornerRadius = bgView.frame.size.width/2
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startPieAnimation(sender: AnyObject) {
        
        if circle == nil {
            
            circle = PieSliceLayer()
            circle.delegate1 = self
            circle.startAngle = CGFloat(-M_PI_2)
            circle.endAngle = CGFloat(3*M_PI_2)
            circle.fillColor = UIColor(white: 0.8, alpha: 0.5)
            circle.strokeColor = UIColor(white: 0.8, alpha: 0.5)
            circle.frame = bgView.bounds
            bgView.layer.addSublayer(circle)
            
        }
        circle.startPieChart()
    }

    @IBAction func stopPieAnimation(sender: AnyObject) {
        
        if circle != nil {
            
            circle.stopPieChart()
        }
    }
    
    func pieSliceAnimationComplete() {
        
       
        circle.removeFromSuperlayer()
        circle.delegate1 = nil
        circle = nil
    }
    
    @IBAction func startArcToCircleAnimation(sender: AnyObject) {
        
        if progressLayer == nil {
            
            progressLayer = ProgressLayer()
            progressLayer.delegate1 = self
            progressLayer.lineWidth = 5
            progressLayer.strokeColor = UIColor.greenColor().CGColor
            progressLayer.fillColor = UIColor.clearColor().CGColor
            progressLayer.frame = self.bgView.bounds
            let center = CGPoint(x: progressLayer.bounds.size.width/2, y: progressLayer.bounds.size.width/2)
            let bezierPath = UIBezierPath()
            bezierPath.addArcWithCenter(center, radius: bgView.bounds.size.width/2-progressLayer.lineWidth/2, startAngle: CGFloat(-M_PI_2), endAngle: CGFloat(2*M_PI - M_PI_2), clockwise: true)
            progressLayer.path = bezierPath.CGPath
            
            bgView.layer.addSublayer(progressLayer)
            
            
            
        }
        
        progressLayer.startProgress()
    }
    
    @IBAction func stopArcToCircleAnimation(sender: AnyObject) {
        
        if progressLayer != nil {
            
            progressLayer.stopProgress()
        }
    }
    
    func progressLayerAnimationComplete() {
        
        progressLayer.removeFromSuperlayer()
        progressLayer.delegate1 = nil
        progressLayer = nil
        
    }
    
    @IBAction func startArcAnimation(sender: AnyObject) {
        
        if arcProgressLayer == nil {
            
            arcProgressLayer = ArcProgressLayer()
            arcProgressLayer.lineWidth = 5
            arcProgressLayer.strokeColor = UIColor.greenColor().CGColor
            arcProgressLayer.fillColor = UIColor.clearColor().CGColor
            arcProgressLayer.frame = self.bgView.bounds
            let center = CGPoint(x: arcProgressLayer.bounds.size.width/2, y: arcProgressLayer.bounds.size.width/2)
            let bezierPath = UIBezierPath()
            bezierPath.addArcWithCenter(center, radius: bgView.bounds.size.width/2-arcProgressLayer.lineWidth/2, startAngle: CGFloat(-M_PI_2), endAngle: CGFloat(-M_PI/4), clockwise: true)
            arcProgressLayer.path = bezierPath.CGPath
            
            arcProgressLayer.transform = CATransform3DMakeRotation(CGFloat(2*M_PI), CGFloat(0), CGFloat(0), CGFloat(1))
            bgView.layer.addSublayer(arcProgressLayer)
            
            
            
        }
        
        arcProgressLayer.startProgress()
    }
    
    @IBAction func stopArcAnimation(sender: AnyObject) {
        
        if arcProgressLayer != nil {
            
            arcProgressLayer.stopProgress()
        }
    }
}

