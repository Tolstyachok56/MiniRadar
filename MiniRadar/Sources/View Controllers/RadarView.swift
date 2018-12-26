//
//  RadarView.swift
//  MiniRadar
//
//  Created by Виктория Бадисова on 26/12/2018.
//  Copyright © 2018 Виктория Бадисова. All rights reserved.
//

import UIKit

class RadarView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }


    override func draw(_ rect: CGRect) {
        
        let frame = self.bounds
        if let context = UIGraphicsGetCurrentContext() {
            
            context.setLineWidth(CGFloat(0.5))
            
            let center = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
            let maxRadius = min(frame.size.width/2, frame.size.height/2)
            let minRadius = maxRadius / CGFloat(Constants.numberOfCircles)
            
            var radius = maxRadius
            
            for _ in 0...Constants.numberOfCircles - 1 {
                let circle = UIBezierPath(arcCenter: center,
                                             radius: radius,
                                             startAngle: 0,
                                             endAngle: 2 * .pi,
                                             clockwise: true)
                UIColor.black.setStroke()
                circle.stroke()
                radius -= minRadius
            }
        }
    }

}
