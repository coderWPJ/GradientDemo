//
//  ViewController.swift
//  GradientDemo
//
//  Created by wu on 2020/6/27.
//  Copyright © 2020 wu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let color_start = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
    let color_end = UIColor(red: 0, green: 0, blue: 1, alpha: 1)
    
    var gradientBgView: UIView = UIView()
    var mockView: MockGradientView = MockGradientView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        let viewWidth = 300.0
        let viewHeight = 50.0
        
        mockView.bounds = CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight)
        mockView.center = CGPoint.init(x: view.frame.width/2, y: 300)
        mockView.colors = [color_start, color_end]
        view.addSubview(mockView)
        
        let gradientBgLeft = mockView.frame.minX
        let gradientBgTop = mockView.frame.maxY+50.0
        gradientBgView.frame = CGRect(x: gradientBgLeft, y: gradientBgTop, width: mockView.frame.width, height: mockView.frame.height)
        view.addSubview(gradientBgView)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight)
        gradientLayer.startPoint = CGPoint.zero
        gradientLayer.endPoint = CGPoint.init(x: 1.0, y: 1.0)
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.colors = [color_start.cgColor, color_end.cgColor]
        gradientBgView.layer.insertSublayer(gradientLayer, at: 0)
        
        
        let showSwitch = UISwitch()
        showSwitch.frame = CGRect.init(x: view.bounds.width-50, y: 60, width: 50, height: 44)
        showSwitch.addTarget(self, action: #selector(switchOnChanged(_:)), for: .valueChanged)
        view.addSubview(showSwitch)
    }
    
    @objc func switchOnChanged(_ showSwitch: UISwitch) -> Void {
        changeLinesShowStatus(showSwitch.isOn)
    }
    
    func removeLines(_ view: UIView) -> Void {
        guard view.layer.sublayers != nil else {
            return
        }
        guard view.layer.sublayers!.count>0 else {
            return
        }
        for layer in view.layer.sublayers! {
            if layer.bounds.width < 1 || layer.bounds.height < 1 {
                layer.removeFromSuperlayer()
            }
        }
    }
    
    func changeLinesShowStatus(_ show: Bool) -> Void {
        if show {
            addLins(to: mockView, interval: 20.0)
            addLins(to: gradientBgView, interval: 20.0)
        } else {
            self.view.subviews.forEach { (view) in
                if view.tag == 999 {
                    view.removeFromSuperview()
                }
            }
            removeLines(mockView)
            removeLines(gradientBgView)
        }
    }
    
    func addLins(to gradientView: UIView, interval: CGFloat) -> Void {
        let labelHeight: CGFloat = 14
        let lineTh: CGFloat = 0.4
        
        let xLines: NSInteger = NSInteger(gradientView.bounds.width/interval)
        let yLines: NSInteger = NSInteger(gradientView.bounds.height/interval)
        
        let lineColor: UIColor = .red
        
        for colum in 0..<xLines {
            let xValue: CGFloat = CGFloat(colum) * interval
            let lineLayer = CALayer()
            lineLayer.backgroundColor = lineColor.cgColor
            lineLayer.frame = CGRect.init(x: xValue, y: 0, width: lineTh, height: gradientView.frame.height)
            gradientView.layer.addSublayer(lineLayer)
            if colum > 0 {
                let xLab: UILabel = UILabel()
                xLab.text = "\(colum)"
                xLab.font = UIFont.systemFont(ofSize: 10)
                xLab.frame = CGRect.init(x: gradientView.frame.minX+xValue-interval/2, y: gradientView.frame.minY-19, width: interval, height: labelHeight)
                xLab.tag = 999
                xLab.textColor = .black
                self.view.addSubview(xLab)
            }
        }
        
        for row in 0..<yLines {
            let yValue: CGFloat = CGFloat(row) * interval
            let lineLayer = CALayer()
            lineLayer.backgroundColor = lineColor.cgColor
            lineLayer.frame = CGRect.init(x: 0, y: yValue, width: gradientView.frame.width, height: lineTh)
            gradientView.layer.addSublayer(lineLayer)
            
            if row > 0 {
                let xLab: UILabel = UILabel()
                xLab.text = "\(row)"
                xLab.font = UIFont.systemFont(ofSize: 10)
                xLab.frame = CGRect.init(x: gradientView.frame.minX-interval-5, y: gradientView.frame.minY+yValue-7, width: interval, height: labelHeight)
                xLab.tag = 999
                xLab.textColor = .black
                self.view.addSubview(xLab)
            }
        }
    }
}

