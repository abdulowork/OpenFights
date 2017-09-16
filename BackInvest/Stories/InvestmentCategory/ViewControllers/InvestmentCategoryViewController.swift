//
// Created by Timofey on 9/17/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class InvestmentCategoryViewController: UIViewController {

    private let scrollView = UIScrollView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }

        let investmentView = Bundle.main.loadNibNamed("TableViewCell", owner: self)!.first! as! UIView
        scrollView.addSubview(investmentView)
        investmentView.snp.makeConstraints{
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
    }

}
