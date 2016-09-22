//
//  CornerSelectionOverlay.swift
//  DraggableRectangleTest
//
//  Created by Kranken on 21.09.16.
//  Copyright © 2016 Kranken. All rights reserved.
//

import Foundation
import UIKit

class CornerSelectionOverlayView: UIView, UIGestureRecognizerDelegate {
    
    
    var draggerPointTopLeft = UIView()
    var draggerPointTopRight = UIView()
    var draggerPointBottomRight = UIView()
    var draggerPointBottomLeft = UIView()
    
    var rectCornerTopLeft = CGPoint(x: 50, y: 100)
    var rectCornerTopRight = CGPoint(x: 300, y: 100)
    var rectCornerBottomRight = CGPoint(x: 300, y: 450)
    var rectCornerBottomLeft = CGPoint(x: 50, y: 400)
    
    var myBezier:UIBezierPath? = UIBezierPath()
    
    var fillColor = UIColor.darkGray
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        draggerPointTopLeft = UIView(frame: CGRect(x: 28, y: 78, width: 44, height: 44))
        draggerPointTopLeft.backgroundColor = UIColor.clear
        self.addSubview(draggerPointTopLeft)
        
        let uiPanGestureRecognizer = UIPanGestureRecognizer(target:self, action: #selector(handlePan))
        draggerPointTopLeft.addGestureRecognizer(uiPanGestureRecognizer)
        
        self.alpha = 0.85
        
    }
    
    
    override func draw(_ rect: CGRect) {

        let context:CGContext = UIGraphicsGetCurrentContext()!
        
        fillColor.setFill()
        UIRectFill(rect)
        //myBezier = nil
        myBezier = UIBezierPath()
        myBezier?.move(to: rectCornerTopLeft)
        myBezier?.addLine(to: rectCornerTopRight)
        myBezier?.addLine(to: rectCornerBottomRight)
        myBezier?.addLine(to: rectCornerBottomLeft)
        myBezier?.close()
        
        myBezier?.lineWidth = 4
        UIColor.red.setStroke()
        //fillColor.setFill()
        myBezier?.stroke()
        context.setBlendMode(CGBlendMode.destinationOut)
    
        myBezier?.fill()
        
        context.setBlendMode(CGBlendMode.normal)
        
    }
    
    func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        let translation = gestureRecognizer.translation(in: self)

        gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x + translation.x, y: gestureRecognizer.view!.center.y + translation.y)
        
        rectCornerTopLeft.x = gestureRecognizer.view!.center.x + translation.x
        rectCornerTopLeft.y = gestureRecognizer.view!.center.y + translation.y
        
        gestureRecognizer.setTranslation(CGPoint(x:0,y:0), in: self)
        
        self.setNeedsDisplay()
    }
}
