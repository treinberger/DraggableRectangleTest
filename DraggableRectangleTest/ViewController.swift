//
//  ViewController.swift
//  DraggableRectangleTest
//
//  Created by Kranken on 21.09.16.
//  Copyright © 2016 Kranken. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cornerView: CornerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cornerView.polygonFillColor = UIColor.black
        cornerView.polygonLineWidth = 4
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

