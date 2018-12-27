//
//  RandomRadarPoint.swift
//  MiniRadar
//
//  Created by Виктория Бадисова on 27/12/2018.
//  Copyright © 2018 Виктория Бадисова. All rights reserved.
//

import UIKit

class RandomRadarPoint {
    
    var x: CGFloat = 0
    var y: CGFloat = 0
    
    private var radarRadius: CGFloat
    private var numberOfCircles: Int
    private var airplaneWidth: CGFloat
    
    private lazy var minRadius: CGFloat = {
       return radarRadius / CGFloat(numberOfCircles)
    }()
    
    init(radarCenter: CGPoint, radarRadius: CGFloat, numberOfCircles: Int, airplaneWidth: CGFloat) {
        self.radarRadius = radarRadius
        self.numberOfCircles = numberOfCircles
        self.airplaneWidth = airplaneWidth
        let randomPoint = getPointOnCircle(center: radarCenter, radius: getRandomRadius(), angle: getRandomAngle())
        self.x = randomPoint.x
        self.y = randomPoint.y
    }
    
    private func getPointOnCircle(center: CGPoint, radius: CGFloat, angle: CGFloat) -> CGPoint{
        let x = self.getXOnCircle(centerX: center.x, radius: radius, angle: angle)
        let y = self.getYOnCircle(centerY: center.y, radius: radius, angle: angle)
        return CGPoint(x: x, y: y)
    }
    
    private func getXOnCircle(centerX: CGFloat, radius: CGFloat, angle: CGFloat) -> CGFloat {
        return radius * cos(angle) + centerX
    }
    
    private func getYOnCircle(centerY: CGFloat, radius: CGFloat, angle: CGFloat) -> CGFloat {
        return radius * sin(angle) + centerY
    }
    
    private func getRandomAngle() -> CGFloat {
        return 2 * CGFloat.pi * CGFloat.random(in: 0...1000) / CGFloat(1000)
    }
    
    private func getRandomRadius() -> CGFloat {
        var randomRadius = CGFloat.random(in: 0...radarRadius)
        while !radiusIsAllright(radius: randomRadius) {
            randomRadius = CGFloat.random(in: 0...radarRadius)
        }
        return randomRadius
    }
    
    private func radiusIsAllright(radius: CGFloat) -> Bool {
        let remainder = radius.truncatingRemainder(dividingBy: minRadius)
        guard remainder != 0 else { return false }
            
        let lessCircleRadius = (radius / minRadius).rounded(.towardZero) * minRadius
        let greaterCircleRadius = (radius / minRadius).rounded(.awayFromZero) * minRadius
        
        if (lessCircleRadius <= radius - airplaneWidth/2 - Constants.airplaneIndent) &&
            (greaterCircleRadius >= radius + airplaneWidth/2 + Constants.airplaneIndent) {
            return true
        } else {
            return false
        }
    }
    
}
