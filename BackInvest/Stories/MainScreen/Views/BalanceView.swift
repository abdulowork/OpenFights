//
// Created by Артмеий Шлесберг on 16/09/2017.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import SnapKit

class BalanceView: UIView {


    init(with balance: Balance) {
        super.init(frame: .zero)

        let currentCBLabel = StandardLabel(font: .openFontMedium(ofSize: 25), textColor: .black)
        let averageCBLabel = StandardLabel(font: .openFont(ofSize: 17), textColor: .black)
        let percentageLabel = StandardLabel(font: .openFont(ofSize: 17), textColor: .black)
            .with(numberOfLines: 0)

        balance.fetchInformation()
        .subscribe(onNext: { info in
            currentCBLabel.text = info.currentCashback.asString()
            averageCBLabel.text = "\(info.averageCashback.asString()) средний кэшбэк"
            percentageLabel.text = "\(info.percentageOfDedicatedCashback) % будет инвестировано в следующем месяце"
        })

        addSubviews([currentCBLabel, averageCBLabel, percentageLabel])

        currentCBLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(30)
        }
        averageCBLabel.snp.makeConstraints {
            $0.top.equalTo(currentCBLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(20)
        }

        averageCBLabel.snp.makeConstraints {
            $0.top.equalTo(averageCBLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(40)
        }

    }
}