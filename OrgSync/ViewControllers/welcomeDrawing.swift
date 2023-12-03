//
//  welcomeDrawing.swift
//  OrgSync
//
//  Created by Hank Hayes on 11/2/23.
//

import UIKit

class welcomeDrawing: UIView {
    override func draw(_ rect: CGRect) {
        // Get the current graphics context
        if let context = UIGraphicsGetCurrentContext() {
            // Create a bezier path for drawing curves
            let path = UIBezierPath()
            
            // Move to the starting point
            path.move(to: CGPoint(x: 50, y: 100))
            
            // Add a quadratic curve
            path.addQuadCurve(to: CGPoint(x: 200, y: 100), controlPoint: CGPoint(x: 125, y: 50))
            
            // Set the line color and width for the curve
            UIColor.blue.setStroke()
            path.lineWidth = 2.0
            
            // Draw the curve
            path.stroke()
            
            // Create a path for the rectangle with one curved edge
            let rectPath = UIBezierPath()
            rectPath.move(to: CGPoint(x: 50, y: 100))
            rectPath.addLine(to: CGPoint(x: 200, y: 100))
            rectPath.addLine(to: CGPoint(x: 200, y: 200))
            rectPath.addQuadCurve(to: CGPoint(x: 50, y: 200), controlPoint: CGPoint(x: 125, y: 250))
            rectPath.close()
            
            // Set the fill color for the rectangle
            UIColor.yellow.setFill()
            rectPath.fill()
        }
    }
}
