//
// Created by Timofey on 6/14/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import UIKit
import SnapKit

class HeaderCell: UITableViewCell {

    private let cellTitleLabel = StandardLabel(font: .lalaSaleFont(ofSize: 17))
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        separatorInset = .init(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)

        contentView.addSubview(cellTitleLabel)
        cellTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(25)
            $0.trailing.equalToSuperview().inset(15)
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(title: String) {
        cellTitleLabel.text = title
    }

    open override func prepareForReuse() {
        super.prepareForReuse()
        cellTitleLabel.text = nil
    }
}
