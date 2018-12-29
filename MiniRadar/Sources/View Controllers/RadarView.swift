//
//  RadarView.swift
//  MiniRadar
//
//  Created by Виктория Бадисова on 26/12/2018.
//  Copyright © 2018 Виктория Бадисова. All rights reserved.
//

import UIKit

class RadarView: UIView {
    
    private lazy var maxRadius: CGFloat = {
        return min(self.bounds.size.width/2, self.bounds.size.height/2)
    }()
    
    private lazy var minRadius: CGFloat = {
        return maxRadius / CGFloat(Constants.numberOfCircles)
    }()
    
    private lazy var radarCenter: CGPoint = {
        return CGPoint(x: self.bounds.midX, y: self.bounds.midY)
    }()
    
    private lazy var airplainWidth: CGFloat = {
        let maxWidth = minRadius - Constants.airplaneIndent * 2
        return CGFloat.random(in: (maxWidth * 2/3)...maxWidth)
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }


    override func draw(_ rect: CGRect) {
        var radius = maxRadius
        
        for _ in 0...Constants.numberOfCircles - 1 {
            let circle = UIBezierPath(arcCenter: self.radarCenter,
                                         radius: radius,
                                         startAngle: 0,
                                         endAngle: 2 * .pi,
                                         clockwise: true)
            circle.lineWidth = 0.5
            UIColor.black.setStroke()
            circle.stroke()
            radius -= minRadius
        }
    }
    
    private func setupView() {
        self.backgroundColor = UIColor.clear
        guard Constants.numberOfAirplanes > 0 else { return }
        for _ in 0..<Constants.numberOfAirplanes {
            let imageView = UIImageView(image: UIImage(named: "airplane"))
            imageView.contentMode = .scaleAspectFit
            let randomRadarPoint = RandomRadarPointForAirplane(radarCenter: self.radarCenter, radarRadius: maxRadius, numberOfCircles: Constants.numberOfCircles, airplaneWidth: airplainWidth, airplaneIndent: Constants.airplaneIndent)
            imageView.frame = CGRect(x: randomRadarPoint.x - airplainWidth / 2,
                                     y: randomRadarPoint.y - airplainWidth / 2,
                                     width: airplainWidth,
                                     height: airplainWidth)
            self.addSubview(imageView)
        }
    }
    
}
