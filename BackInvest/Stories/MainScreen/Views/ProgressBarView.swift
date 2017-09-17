//
// Created by Артмеий Шлесберг on 16/09/2017.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import UIKit

class ProgressBarView: UIView {

    var completion: Double = 0 {
        didSet {
            completionView.snp.remakeConstraints {
                $0.width.equalToSuperview().multipliedBy(completion)
            }
        }
    }
    private var completionView: UIView = UIView()

    init(completion: Double = 0) {
        super.init(frame: .zero)
        addSubview(completionView)
        completionView.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(completion)
        }
        self.completion = completion

        completionView.backgroundColor = UIColor.BackInvest.mainTintColor
        backgroundColor = UIColor.BackInvest.paleGrey
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = self.frame.height/2.0
        completionView.layer.cornerRadius = self.frame.height/2.0
    }
}
