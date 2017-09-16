//
//  UIBarButtonItem.swift
//  DiscountMarket
//
//  Created by Артмеий Шлесберг on 03/07/2017.
//  Copyright © 2017 Jufy. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    
    var frame: CGRect {
        return (value(forKey: "view") as! UIView).frame
    }
}
