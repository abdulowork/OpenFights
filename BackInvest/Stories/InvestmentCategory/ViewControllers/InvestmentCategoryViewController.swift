//
// Created by Timofey on 9/17/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import SnapKit

class InvestmentCategoryViewController: UIViewController {

    private let disposeBag = DisposeBag()
    private let scrollView = UIScrollView()
    private let investmentActionView = InvestmentActionView()

    override func viewDidLoad() {
        super.viewDidLoad()

        automaticallyAdjustsScrollViewInsets = false
        investmentActionView.layer.shadowRadius = 1
        investmentActionView.layer.shadowOffset = .init(width: 0, height: -1)
        investmentActionView.layer.shadowOpacity = 0.17
        view.addSubview(investmentActionView)
        investmentActionView.snp.remakeConstraints{
            $0.bottom.equalTo(self.view)
            $0.leading.trailing.equalToSuperview()
        }
        investmentActionView.alpha = 0

        investmentActionView.wantsToProceedWithSelectedPercentage.debug().subscribe().disposed(by: disposeBag)
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints{
            $0.top.equalTo(topLayoutGuide.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(bottomLayoutGuide.snp.top)
        }

        let contentView = UIView()
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints{
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }

        let investmentView = Bundle.main.loadNibNamed("TableViewCell", owner: self)!.first! as! UIView
        contentView.addSubview(investmentView)
        investmentView.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview()
        }

        let investmentButton = StandardRoundEdgeButton(
            backgroundColor: UIColor.BackInvest.smlAquaBlue,
            title: "Инвестировать"
        )
        contentView.addSubview(investmentButton)
        investmentButton.snp.makeConstraints{
            $0.top.equalTo(investmentView.snp.bottom).offset(42)
            $0.leading.trailing.equalToSuperview().inset(55)
            $0.bottom.equalToSuperview().inset(32)
            $0.height.equalTo(47)
        }

        view.bringSubview(toFront: self.investmentActionView)

        investmentButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                UIView.animate(
                    withDuration: 0.3,
                    animations: { [unowned self] in
                        self.investmentActionView.alpha = 1
                    }
                )
            })
            .disposed(by: disposeBag)

        investmentActionView
            .wantsToProceedWithSelectedPercentage
            .debug()
            .subscribe(onNext: { [unowned self] _ in
                self.commandToShowController(from: {MyInvestmentsController(with: MyICOInvestments())}).execute()
            })
            .disposed(by: disposeBag)
    }

}
