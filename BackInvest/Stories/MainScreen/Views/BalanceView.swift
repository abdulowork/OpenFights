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
        textColor: .white
    )
    private let averageCBLabel = StandardLabel(
        font: .openFont(ofSize: 17),
        textColor: .white
    )
    private let percentageLabel = StandardLabel(
        font: .openFont(ofSize: 17),
        textColor: .white
    )
    private let popularCategories = StandardLabel(
        font: .openFontMedium(ofSize: 20)
    ).with(text: "Популярные категории")

    private let backImage = UIImageView(image: #imageLiteral(resourceName: "headerBackground"))
        .with(contentMode: .scaleAspectFill)

    
    private var disposeBag = DisposeBag()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {

        super.init(style: style, reuseIdentifier: reuseIdentifier)
        

        let whiteBack = UIView().with(backgroundColor: .white)
                .with(clipsToBounds: true)
                .with(roundedEdges: 15)

        contentView.addSubviews([backImage, whiteBack, currentCBLabel, averageCBLabel, percentageLabel, popularCategories])

        backImage.snp.makeConstraints {
            $0.edges.equalToSuperview().priority(500)
        }

        whiteBack.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview()
            $0.bottom.equalToSuperview().offset(15)
            $0.height.equalTo(50)
        }

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
        selectionStyle = .none
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

    func configured(with portfolio: MyInvestments) -> BalanceCell {
        self.currentCBLabel.text = "50% Cash-Back вложено в «Кофейни»"
        self.averageCBLabel.text = "30% Сash-Back вложено в «Кальянные»"
        self.percentageLabel.text = "Ожидаемый суммарный доход 471, 05 ₽/мес. "
        self.popularCategories.text = "Инвестировано мной"
        return self
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
        currentCBLabel.text = nil
        averageCBLabel.text = nil
        percentageLabel.text = nil
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        guard let window = self.window else {
            return
        }
        backImage.snp.makeConstraints {
            $0.top.lessThanOrEqualTo(window.snp.top)
        }
        
    }

}
