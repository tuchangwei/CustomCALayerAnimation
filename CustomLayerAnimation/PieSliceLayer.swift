

import UIKit

protocol PieSliceLayerDelegate {
    
    func pieSliceAnimationComplete ()
}
class PieSliceLayer: CALayer {
    
    @NSManaged var  startAngle:CGFloat
    @NSManaged var endAngle:CGFloat
    var fillColor:UIColor!
    var strokeWidth:CGFloat!
    var strokeColor:UIColor!
    
    var timer:NSTimer!
    var progress: Float = 0.0
    
    var delegate1: PieSliceLayerDelegate?
    
    override init!() {
        
        
        self.fillColor = UIColor.grayColor()
        self.strokeColor = UIColor.blackColor()
        self.strokeWidth = 1.0
        super.init()
        self.startAngle = 0.0
        self.endAngle = 0.0
        self.setNeedsDisplay()
        
    }

    override init!(layer: AnyObject!) {
        
       super.init(layer: layer)
        self.startAngle = 0.0
        self.endAngle = 0.0
        
        if layer.isKindOfClass(PieSliceLayer.classForCoder()) {
            
            let layer1 = layer as! PieSliceLayer
            self.startAngle = layer1.startAngle
            self.endAngle = layer1.endAngle
            self.fillColor = layer1.fillColor
            self.strokeColor = layer1.strokeColor
            self.strokeWidth = layer1.strokeWidth
            
        }
        
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func actionForKey(event: String!) -> CAAction! {
        
        if event == "startAngle" || event == "endAngle" {
            
            var anim = CABasicAnimation(keyPath: event)
            
            if self.presentationLayer() != nil {
                
                anim.fromValue = self.presentationLayer().valueForKey(event)
                anim.delegate = self
            }
            
            anim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            return anim
        }
        
        return super.actionForKey(event)
    }
    
    override class func needsDisplayForKey(key: String!) -> Bool {
        
        if key == "startAngle" || key == "endAngle" {
            
            return true
        }
        return super.needsDisplayForKey(key)
    }
    
    
    override func drawInContext(ctx: CGContext!) {
        
        // Create the path
        let center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        let radius = min(center.x, center.y);
        
        CGContextBeginPath(ctx);
        CGContextMoveToPoint(ctx, center.x, center.y);
        
        let tmpStartAngle = Float(self.startAngle)
        
        let tmpRadius = Float(radius)
        
        let p1x  = Float(center.x) + tmpRadius * cosf(tmpStartAngle)
        let p1y  = Float(center.y) + tmpRadius * sinf(tmpStartAngle)
        let p1 = CGPoint(x: CGFloat(p1x), y: CGFloat(p1y));
        CGContextAddLineToPoint(ctx, p1.x, p1.y);
        
      
        CGContextAddArc(ctx, center.x, center.y, radius, self.startAngle, self.endAngle, Int32(0));
        
        //	CGContextAddLineToPoint(ctx, center.x, center.y);
        
        CGContextClosePath(ctx);
        
        // Color it
        CGContextSetFillColorWithColor(ctx, self.fillColor.CGColor);
        CGContextSetStrokeColorWithColor(ctx, self.strokeColor.CGColor);
        CGContextSetLineWidth(ctx, self.strokeWidth);
        
        CGContextDrawPath(ctx, kCGPathFillStroke);

        
    }
    
    
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        
        if self.startAngle > CGFloat(M_PI_2*3) {
            
            self.delegate1?.pieSliceAnimationComplete()
        }
    }
    func startPieChart() {
        
        if self.timer == nil {
            
            self.timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "animate", userInfo: nil, repeats: true)
            self.timer.fire()
        }
        
    }
    
    func animate() {
    
        
        self.startAngle =  CGFloat(2*M_PI*Double(self.progress) - M_PI_2)

        if self.progress > 1 {
            
            self.timer.invalidate()
            return
        }
        self.progress += 0.01;
    }
    
    func stopPieChart() {
        
        if self.timer != nil {
            
            self.timer.invalidate()
            self.timer = nil
        }
        
    }
    

    
    
    
    
}
