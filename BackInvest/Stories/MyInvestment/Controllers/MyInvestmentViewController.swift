//
// Created by Timofey on 9/17/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class MyInvestmentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let view = Bundle.main.loadNibNamed("DTableViewCell", owner: self)!.first! as! DTableViewCell
        view.set(
            firstView: Bundle.main.loadNibNamed("ETableViewCell", owner: self)!.first! as! UIView,
            secondView: Bundle.main.loadNibNamed("DescriptionTableViewCell", owner: self)!.first! as! UIView
        )

        self.view.addSubview(view)
        view.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }

        title = "Finish him"

    }

}
