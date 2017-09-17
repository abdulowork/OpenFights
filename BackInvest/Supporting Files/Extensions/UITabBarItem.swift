//
// Created by Артмеий Шлесберг on 17/09/2017.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import UIKit

extension UITabBarItem {
    func disabled()-> Self {
        self.isEnabled = false
        return self
    }
}