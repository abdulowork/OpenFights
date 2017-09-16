//
//  DiscountMarket
//
//  Created by Timofey on 6/1/17.
//  Copyright © 2017 Jufy. All rights reserved.
//

import UIKit
import SnapKit

final class StandardCellContainer: UIView {
    
    init(leftView: UIView, rightView: UIView) {
        super.init(frame: .zero)
        addSubview(leftView)
        addSubview(rightView)

        leftView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(36)
            $0.top.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().offset(-14)
            $0.trailing.greaterThanOrEqualTo(rightView.snp.leading).offset(-16)
        }
        
        rightView.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-5)
            $0.centerY.equalToSuperview()
        }
        rightView.setContentHuggingPriority(251, for: .horizontal)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
