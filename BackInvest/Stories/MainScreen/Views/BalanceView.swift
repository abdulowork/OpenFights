//
// Created by Артмеий Шлесберг on 16/09/2017.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import SnapKit

class BalanceCell: UITableViewCell {

    private let currentCBLabel = StandardLabel(
        font: .openFontMedium(ofSize: 25),
        textColor: .black
    )
    private let averageCBLabel = StandardLabel(
        font: .openFont(ofSize: 17),
        textColor: .black
    )
    private let percentageLabel = StandardLabel(
        font: .openFont(ofSize: 17),
        textColor: .black
    )
    private let popularCategories = StandardLabel(
        font: .openFont(ofSize: 20),
        textColor: .black
    ).with(text: "Популярные категории")

    private var disposeBag = DisposeBag()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubviews([currentCBLabel, averageCBLabel, percentageLabel, popularCategories])

        currentCBLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        averageCBLabel.snp.makeConstraints {
            $0.top.equalTo(currentCBLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        percentageLabel.snp.makeConstraints {
            $0.top.equalTo(averageCBLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        popularCategories.snp.makeConstraints {
            $0.top.equalTo(percentageLabel.snp.bottom).offset(68)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }

        separatorInset = .init(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configured(with info: BalanceInfo) -> BalanceCell {
        self.currentCBLabel.text = info.currentCashback.asString()
        self.averageCBLabel.text = "\(info.averageCashback.asString()) средний кэшбэк"
        self.percentageLabel.text = "\(info.percentageOfDedicatedCashback) % будет инвестировано в следующем месяце"
        return self
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
        currentCBLabel.text = nil
        averageCBLabel.text = nil
        percentageLabel.text = nil
    }

}
