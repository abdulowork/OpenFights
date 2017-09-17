//
// Created by Артмеий Шлесберг on 17/09/2017.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxDataSources

class MyInvestmentsController: UIViewController {

    private enum SectionItem {
        case portfolio
        case investment(Business)
    }

    private let investments: MyInvestments
    init(with investments: MyInvestments) {
        self.investments = investments
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
        dataSource.configureCell = { [unowned self] ds, tv, ip, item in
            switch item {
            case .portfolio:
                return tv.dequeueReusableCellOfType(BalanceCell.self, for: ip).configured(with: self.investments)
            case let .investment(business):
                return tv.dequeueReusableCellOfType(BusinessCell.self, for: ip).configured(with: business)
            }
        }

        investments.fetch()
                .map{ businesses in
                    [
                        StandardSectionModel<SectionItem>(
                                items: [SectionItem.portfolio] + businesses.map{ SectionItem.investment($0.business) }
                        )
                    ]
                }
                .bind(to: tableView.rx.items(dataSource: dataSource))
                .disposed(by: disposeBag)


        tableView.rx.modelSelected(SectionItem.self)
                .subscribe(onNext: { [unowned self] item in
                    switch item {
                    case .investment:
                        self.commandToShowController(
                                from: { InvestmentCategoryViewController(nibName: nil, bundle: nil) }
                        ).execute()
                    default:
                        return
                    }
                })
                .disposed(by: disposeBag)

        title = "Мой портфель"
    }

}
