//
// Created by Артмеий Шлесберг on 16/09/2017.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class CategoryCell: UITableViewCell {

    var categoryView: InvestmentCategoryCellView = InvestmentCategoryCellView()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(categoryView)
        categoryView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configured(with category: InvestmentCategoryInCell) -> Self {
        categoryView.setup(with: category)
        return self
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        categoryView.prepareForReuse()
    }
}
