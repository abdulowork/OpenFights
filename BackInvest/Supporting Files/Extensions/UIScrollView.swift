//
// Created by Timofey on 8/3/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import UIKit

extension UIScrollView {

    var isScrolling: Bool {
        return self.layer.animation(forKey: "bounds") != nil
    }

}
