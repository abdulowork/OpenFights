//
// Created by Артмеий Шлесберг on 16/09/2017.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class CategoryCell: UITableViewCell {

    var categoryView: InvestmentCategoryCellView = InvestmentCategoryCellView()

    init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(categoryView)
        categoryView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func configured(with category: InvestmentCategoryInCell) -> Self {
        categoryView.setup(with: category)
        return self
    }
}
