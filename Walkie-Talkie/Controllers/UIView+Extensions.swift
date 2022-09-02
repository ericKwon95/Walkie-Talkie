//
//  UIView+Extensions.swift
//  Walkie-Talkie
//
//  Created by SEUNGYONG KWON on 2022/09/02.
//

import UIKit

public enum BorderSide {
    case top, bottom, left, right
}

extension UIView { // textField 흔들기
    func shake() {
        UIView.animate(withDuration: 0.6, animations: {
            self.addBorder(side: .bottom, color: .red, width: 1.0)
            self.addBorder(side: .top, color: .red, width: 1.0)
            self.addBorder(side: .left, color: .red, width: 1.0)
            self.addBorder(side: .right, color: .red, width: 1.0)
        }, completion:{
            _ in
            for sub in self.subviews{
                if sub.backgroundColor == UIColor.red{
                    sub.removeFromSuperview()
                }
            }
        })
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-10.0, 10.0, -10.0, 10.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}

extension UIView {
    public func addBorder(side: BorderSide, color: UIColor, width: CGFloat) {
        let border = UIView()
        border.translatesAutoresizingMaskIntoConstraints = false
        border.backgroundColor = color
        self.addSubview(border)
        
        let topConstraint = topAnchor.constraint(equalTo: border.topAnchor)
        let rightConstraint = trailingAnchor.constraint(equalTo: border.trailingAnchor)
        let bottomConstraint = bottomAnchor.constraint(equalTo: border.bottomAnchor)
        let leftConstraint = leadingAnchor.constraint(equalTo: border.leadingAnchor)
        let heightConstraint = border.heightAnchor.constraint(equalToConstant: width)
        let widthConstraint = border.widthAnchor.constraint(equalToConstant: width)
        
        switch side {
        case .top:
            NSLayoutConstraint.activate([leftConstraint, topConstraint, rightConstraint, heightConstraint])
        case .right:
            NSLayoutConstraint.activate([topConstraint, rightConstraint, bottomConstraint, widthConstraint])
        case .bottom:
            NSLayoutConstraint.activate([rightConstraint, bottomConstraint, leftConstraint, heightConstraint])
        case .left:
            NSLayoutConstraint.activate([bottomConstraint, leftConstraint, topConstraint, widthConstraint])
        
        }
    }
}
