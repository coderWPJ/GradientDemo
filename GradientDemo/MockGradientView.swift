//
//  MockGradientView.swift
//  GradientDemo
//
//  Created by wu on 2020/6/27.
//  Copyright © 2020 wu. All rights reserved.
//

import UIKit

class MockGradientView: UIView {

    open var colors: [UIColor]?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func draw(_ rect: CGRect) {
        guard let colors = colors, colors.count > 0 else {
            return
        }
        let context = UIGraphicsGetCurrentContext()
        guard context != nil else {
            return
        }
        context!.saveGState()
        context!.clip(to: rect)
        
        let numOfComponents = 4
        let colorSpace: CGColorSpace = CGColorSpaceCreateDeviceRGB()
        var components: [CGFloat] = []
        for row in 0..<colors.count {
            let comp = colors[row].cgColor.components
            for colum in 0..<numOfComponents {
                let value = comp?[colum] ?? 1
                components.append(value)
            }
        }
        let locations: [CGFloat] = [0, 1]
        let gradient = CGGradient.init(colorSpace: colorSpace, colorComponents: components, locations: locations, count: colors.count)!
        let start_point = CGPoint.zero
        let end_point = CGPoint.init(x: rect.maxX, y: rect.maxY)
        context!.drawLinearGradient(gradient, start: start_point, end: end_point, options: CGGradientDrawingOptions.drawsAfterEndLocation)
        context!.restoreGState()
    }
}
