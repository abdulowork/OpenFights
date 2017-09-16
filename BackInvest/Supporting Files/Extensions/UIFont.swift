//
//  UIFont.swift
//  DiscountMarket
//
//  Created by Артмеий Шлесберг on 28/06/2017.
//  Copyright © 2017 Jufy. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    static func openFont(ofSize size: CGFloat = 14) -> UIFont {
        return UIFont(name: "ProximaNova-Regular", size: size)!
    }
    static func openFontMedium(ofSize size: CGFloat = 14) -> UIFont {
        return UIFont(name: "ProximaNova-Semibold", size: size)!
    }
}
