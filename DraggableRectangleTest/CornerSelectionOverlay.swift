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
    
    private var fillLayer = CAShapeLayer()
    
    var draggerPointTopLeft = UIView()
    var draggerPointTopRight = UIView()
    var draggerPointBottomRight = UIView()
    var draggerPointBottomLeft = UIView()
    
    var rectCornerTopLeft = CGPoint(x: 50, y: 100)
    var rectCornerTopRight = CGPoint(x: 300, y: 100)
    var rectCornerBottomRight = CGPoint(x: 300, y: 450)
    var rectCornerBottomLeft = CGPoint(x: 50, y: 400)
    
    var imageCornerPath:UIBezierPath? = UIBezierPath()
    
    var fillColor = UIColor(red: 0.9, green: 0.5, blue: 0.5, alpha: 0.5)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fillLayer.frame = self.bounds
        
        draggerPointTopLeft = UIView(frame: CGRect(x: 28, y: 78, width: 44, height: 44))
        draggerPointTopLeft.backgroundColor = UIColor.clear
        draggerPointTopLeft.addSubview(UIImageView(image: UIImage(named: "bobbel")))
        
        //draggerPointTopLeft = UIImageView(image: UIImage(named: "bobbel"))
        //draggerPointTopLeft.frame = CGRect(x: 28, y: 78, width: 44, height: 44)
        self.addSubview(draggerPointTopLeft)
        
        let uiPanGestureRecognizer = UIPanGestureRecognizer(target:self, action: #selector(handlePan))
        draggerPointTopLeft.addGestureRecognizer(uiPanGestureRecognizer)

    }
    
    
    override func draw(_ rect: CGRect) {
 
        let maskPath = UIBezierPath()
        maskPath.move(to: CGPoint(x:rect.minX, y:rect.minY))
        maskPath.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        maskPath.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        maskPath.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        maskPath.close()
        
        
        imageCornerPath = UIBezierPath()
        imageCornerPath?.move(to: rectCornerTopLeft)
        imageCornerPath?.addLine(to: rectCornerTopRight)
        imageCornerPath?.addLine(to: rectCornerBottomRight)
        imageCornerPath?.addLine(to: rectCornerBottomLeft)
        imageCornerPath?.close()
        
        maskPath.append(imageCornerPath!)
        fillLayer.path = maskPath.cgPath
        fillLayer.fillRule = kCAFillRuleEvenOdd
        fillLayer.fillColor = self.fillColor.cgColor
    
        imageCornerPath?.lineWidth = 4
        UIColor.red.setStroke()
        imageCornerPath?.stroke()

        self.layer.addSublayer(fillLayer)
        self.bringSubview(toFront: draggerPointTopLeft)
        
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
