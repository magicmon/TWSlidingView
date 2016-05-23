//
//  ViewController.swift
//  TWSlidingView
//
//  Created by magicmon on 05/22/2016.
//  Copyright (c) 2016 magicmon. All rights reserved.
//

import UIKit
import TWSlidingView

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // zoomOut Type
        makeZoomOutTypeView()
        
        // Depth Type
        makeDepthTypeView()
    }
    
    func makeZoomOutTypeView() {
        let slidingView = TWSlidingView(frame: CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height / 2))
        slidingView.slidingType = .ZoomOut
        self.view.addSubview(slidingView)
        
        for _ in 0...5 {
            let sampleView = UIView(frame: slidingView.bounds)
            sampleView.backgroundColor = colorWithIndex()
            slidingView.addChildView(sampleView)
        }
    }
    
    func makeDepthTypeView() {
        let depthSlidingView = TWSlidingView(frame: CGRectMake(0, self.view.bounds.height / 2 + 5.0, self.view.bounds.width, self.view.bounds.height / 2 - 5.0))
        depthSlidingView.slidingType = .Depth
        self.view.addSubview(depthSlidingView)
        
        for _ in 0...5 {
            let sampleView = UIView(frame: depthSlidingView.bounds)
            sampleView.backgroundColor = colorWithIndex()
            depthSlidingView.addChildView(sampleView)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func colorWithIndex() -> UIColor? {
        
        var color: UIColor?
        
        let random = Int(arc4random_uniform(5))
        
        switch random {
        case 0:
            color = UIColor.blueColor()
            break
        case 1:
            color = UIColor.brownColor()
            break
        case 2:
            color = UIColor.yellowColor()
            break
        case 3:
            color = UIColor.greenColor()
            break
        case 4:
            color = UIColor.cyanColor()
            break
        default:
            break
        }
        
        return color
    }

}

