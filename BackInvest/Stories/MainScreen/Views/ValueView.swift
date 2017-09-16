//
// Created by Артмеий Шлесберг on 16/09/2017.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import UIKit

class ValueView: UIView {
    var icon: UIImageView
    var valueLabel: StandardLabel

    init(value: String, icon: UIImage) {
        self.icon = UIImageView(image: icon)
        valueLabel = StandardLabel(font: .openFont(ofSize: 15), textColor: .black, text: value)
                .aligned(by: .left)

        super.init(frame: .zero)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}