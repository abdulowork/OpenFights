//
// Created by Timofey on 6/5/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import UIKit

class VerticalStackView: UIStackView {
    
    override var axis: UILayoutConstraintAxis {
        get {
            return super.axis
        }
        set {
            super.axis = .vertical
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        axis = .vertical
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
