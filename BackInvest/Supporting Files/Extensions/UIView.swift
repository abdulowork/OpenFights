//
// Created by Артмеий Шлесберг on 16/06/2017.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func addSubviews(_ views: [UIView] ) {
        for view in views {
            addSubview(view)
        }
    }

    func takeScreenshot() -> UIImage {

        UIGraphicsBeginImageContextWithOptions(self.frame.size, false, UIScreen.main.scale)
        drawHierarchy(in: CGRect(origin: CGPoint.zero, size: self.frame.size), afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image!
    }

    func jiggle() {

        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 2
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 4, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 4, y: self.center.y))
        self.layer.add(animation, forKey: nil)
    }

    var maxY: CGFloat {
        return self.frame.maxY
    }

    var minY: CGFloat {
        return self.frame.minY
    }

    var maxX: CGFloat {
        return self.frame.maxX
    }

    var minX: CGFloat {
        return self.frame.minX
    }

    var midY: CGFloat {
        return self.frame.midY
    }

    var midX: CGFloat {
        return self.frame.midX
    }

    func makeDisabled() {

        self.alpha = 0.3
        self.isUserInteractionEnabled = false
    }

    func makeEnabled() {

        self.alpha = 1.0
        self.isUserInteractionEnabled = true
    }

    func setEnabled(enabled: Bool) {

        if enabled {
            makeEnabled()
        } else {
            makeDisabled()
        }
    }

    func with(contentMode: UIViewContentMode) -> Self {
        self.contentMode = contentMode
        return self
    }

    func with(clipsToBounds: Bool) -> Self {
        self.clipsToBounds = clipsToBounds
        return self
    }
    
    func with(roundedEdges radius: CGFloat) -> Self {
        self.layer.cornerRadius = radius
        return self.with(clipsToBounds: true)
    }
    
    func withBottomBorder() -> Self {
        
        self.layer.backgroundColor = UIColor.white.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.LaLaSale.separatorColor.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
        
        return self
    }

    func with(backgroundColor: UIColor) -> Self {
        self.backgroundColor = backgroundColor
        return self
    }

    func with(translatesAutoresizingMaskIntoConstraints: Bool) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints
        return self
    }

    func with(compressionResistancePriority: UILayoutPriority, for axis: UILayoutConstraintAxis) -> Self {
        self.setContentCompressionResistancePriority(compressionResistancePriority, for: axis)
        return self
    }

    func with(huggingPriority: UILayoutPriority, for axis: UILayoutConstraintAxis) -> Self {
        self.setContentHuggingPriority(huggingPriority, for: axis)
        return self
    }

}

