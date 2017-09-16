//
// Created by Артмеий Шлесберг on 16/09/2017.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxDataSources
import SnapKit

class SuggestedInvestmentsController: UIViewController {

    private enum SectionItem {
        case balance(BalanceInfo)
    }

    private let balance: Balance
    private let investmentCategories: InvestmentCategories
    init(with balance: Balance, investmentCategories: InvestmentCategories) {
        self.balance = balance
        self.investmentCategories = investmentCategories
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let disposeBag = DisposeBag()
    private let tableView = StandardTableView()
    override func viewDidLoad() {
        super.viewDidLoad()

        automaticallyAdjustsScrollViewInsets = false
        view.addSubview(tableView)
        tableView.snp.makeConstraints{
            $0.top.equalTo(topLayoutGuide.snp.bottom)
            $0.bottom.equalTo(bottomLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
        }

        let dataSource = RxTableViewSectionedReloadDataSource<StandardSectionModel<SectionItem>>()
        dataSource.configureCell = { ds, tv, ip, item in
            switch item {
            case let .balance(info):
                return tv.dequeueReusableCellOfType(BalanceCell.self, for: ip).configured(with: info)
            }
        }

        balance.fetchInformation()
            .map{ info in
                [
                    StandardSectionModel<SectionItem>(
                        items: [
                            .balance(info)
                        ]
                    )
                ]
            }
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
//        let view = BalanceView()
//        view.backgroundColor = .red
//        view.configure(with: balance)
//
//        self.view.addSubview(view)
//        view.snp.makeConstraints{
//            $0.top.equalTo(topLayoutGuide.snp.bottom)
//            $0.leading.trailing.equalToSuperview()
//        }

    }

}
