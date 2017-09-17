//
// Created by Timofey on 9/17/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import SnapKit

class InvestmentActionView: UIView {

    private let disposeBag = DisposeBag()

    private let cancelButton = UIButton(type: .system)
        .with(title: "Отменить", for: .normal)
        .with(font: .openFont(ofSize: 16))
    private let titleLabel = UILabel()
        .with(text: "Инвестировать")
        .with(font: .openFont(ofSize: 17))
    private let proceedButton = UIButton(type: .system)
        .with(title: "Готово", for: .normal)
        .with(font: .openFontMedium(ofSize: 16))
    private let firstSeparator = UIView()
        .with(backgroundColor: UIColor.BackInvest.separatorColor)

    private let percentageOfCashbackSelected = UILabel()
        .with(text: nil)
        .with(font: .openFont(ofSize: 45))
    private let secondSeparator = UIView()
        .with(backgroundColor: UIColor.BackInvest.separatorColor)
    private let projectedIncomeLabel = UILabel()
        .with(font: .openFont(ofSize: 15))
    private let cashbackSelectionSlider = UISlider()

    lazy var wantsToProceedWithSelectedPercentage: Observable<Double> = self.proceedButton.rx
        .tap
        .withLatestFrom(self.cashbackSelectionSlider.rx.value) { _, percentage in percentage }
        .map{ Double($0) }


    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        let pseudoNavigationBar = UIView()
        addSubview(pseudoNavigationBar)
        pseudoNavigationBar.snp.makeConstraints{
            $0.height.equalTo(57)
            $0.top.leading.trailing.equalToSuperview()
        }

        pseudoNavigationBar.addSubviews([cancelButton, titleLabel, proceedButton, firstSeparator])
        cancelButton.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(20)
            $0.centerY.equalTo(titleLabel)
        }

        titleLabel.snp.makeConstraints{
            $0.center.equalToSuperview()
        }

        proceedButton.snp.makeConstraints{
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalTo(titleLabel)
        }

        firstSeparator.snp.makeConstraints{
            $0.height.equalTo(1)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }

        addSubviews([percentageOfCashbackSelected, secondSeparator, projectedIncomeLabel, cashbackSelectionSlider])
        percentageOfCashbackSelected.snp.makeConstraints{
            $0.top.equalTo(pseudoNavigationBar.snp.bottom).offset(25)
            $0.centerX.equalToSuperview()
        }

        secondSeparator.snp.makeConstraints{
            $0.top.equalTo(percentageOfCashbackSelected.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview().inset(110)
            $0.height.equalTo(1)
        }

        projectedIncomeLabel.snp.makeConstraints{
            $0.top.equalTo(secondSeparator.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
        }

        cashbackSelectionSlider.minimumValue = 0
        cashbackSelectionSlider.maximumValue = 1
        cashbackSelectionSlider.isContinuous = true

        cashbackSelectionSlider.snp.makeConstraints{
            $0.top.equalTo(projectedIncomeLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(30)
        }
        cashbackSelectionSlider.rx.value.map{ "\(Int($0 * 100))%" }
            .bind(to: percentageOfCashbackSelected.rx.text)
            .disposed(by: disposeBag)
        cashbackSelectionSlider.rx.value.map{ "≈ \(Int($0 * 342)) ₽ дохода в следующем месяце" }
            .bind(to: projectedIncomeLabel.rx.text)
            .disposed(by: disposeBag)

        cancelButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                UIView.animate(
                    withDuration: 0.3,
                    animations: { [unowned self] in
                        self.alpha = 0
                    }
                )
            })
            .disposed(by: disposeBag)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
