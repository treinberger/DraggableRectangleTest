//
//  CornerSelectionOverlay.swift
//  DraggableRectangleTest
//
//  Created by Kranken on 21.09.16.
//  Copyright © 2016 Kranken. All rights reserved.
//

import Foundation
import UIKit

class CornerView: UIView {

    // MARK: Outlets
    @IBOutlet weak var draggerPointTopLeft:CornerTouchView!
    @IBOutlet weak var draggerPointTopRight:CornerTouchView!
    @IBOutlet weak var draggerPointBottomLeft:CornerTouchView!
    @IBOutlet weak var draggerPointBottomRight:CornerTouchView!
    
    // MARK: Variables
    var polygonFillColor:UIColor = UIColor.black
    var polygonLineColor:UIColor = UIColor.black
    var polygonLineWidth:Float = 4
    var imageCornerPath:UIBezierPath? = UIBezierPath()
    
    private var fillLayer = CAShapeLayer()

    // MARK: Initialization
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fillLayer.frame = self.bounds
    }
    
    // MARK: Methods
    
    override func draw(_ rect: CGRect) {
 
        let maskPath = UIBezierPath()
        maskPath.move(to: CGPoint(x:rect.minX, y:rect.minY))
        maskPath.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        maskPath.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        maskPath.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        maskPath.close()
        
        
        imageCornerPath = UIBezierPath()
        imageCornerPath?.move(to: draggerPointTopLeft.center)
        imageCornerPath?.addLine(to: draggerPointTopRight.center)
        imageCornerPath?.addLine(to: draggerPointBottomRight.center)
        imageCornerPath?.addLine(to: draggerPointBottomLeft.center)
        imageCornerPath?.close()
        
        maskPath.append(imageCornerPath!)
        fillLayer.path = maskPath.cgPath
        fillLayer.fillRule = kCAFillRuleEvenOdd
        fillLayer.fillColor = polygonFillColor.cgColor
    
        imageCornerPath?.lineWidth = CGFloat(polygonLineWidth)
        polygonLineColor.setStroke()
        imageCornerPath?.stroke()

        self.layer.addSublayer(fillLayer)
        self.bringSubview(toFront: draggerPointTopLeft)
        self.bringSubview(toFront: draggerPointTopRight)
        self.bringSubview(toFront: draggerPointBottomRight)
        self.bringSubview(toFront: draggerPointBottomLeft)
    }
}

class CornerTouchView: UIView {
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let location = touch?.location(in: self.superview)
        self.center = location!
        
        //self.setNeedsDisplay()
        self.superview?.setNeedsDisplay()
    }
}
