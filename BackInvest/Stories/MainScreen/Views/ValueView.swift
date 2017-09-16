//
// Created by Артмеий Шлесберг on 16/09/2017.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class ValueView: UIView {
    var iconView: UIImageView
    var valueLabel: StandardLabel

    init(value: String, icon: UIImage) {
        self.iconView = UIImageView(image: icon)
        valueLabel = StandardLabel(font: .openFont(ofSize: 15), textColor: .black, text: value)
                .aligned(by: .left)

        super.init(frame: .zero)
        self.addSubviews([iconView, valueLabel])
        iconView.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.width.height.equalTo(21)
        }
        iconView.contentMode = .scaleAspectFit
        valueLabel.snp.makeConstraints {
            $0.leading.equalTo(iconView.snp.trailing).offset(11)
            $0.center.equalToSuperview()
        }

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
