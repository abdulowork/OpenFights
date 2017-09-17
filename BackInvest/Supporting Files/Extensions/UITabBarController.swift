//
// Created by Артмеий Шлесберг on 16/09/2017.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import UIKit

extension UITabBarController {
    convenience init(controllers: [UIViewController]) {
        self.init(nibName: nil, bundle: nil)
        setViewControllers(controllers, animated: false)
    }
}
