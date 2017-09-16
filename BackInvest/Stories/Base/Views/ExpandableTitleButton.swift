//
// Created by Timofey on 6/23/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import RxSwift

class ExpandableTitleButton: UIButton {

    lazy var tap: Observable<Void> = {
        return self.rx.tap.asObservable()
    }()

    init(title: String) {
        super.init(frame: .zero)
        let arrowImageView = UIImageView(image: #imageLiteral(resourceName: "angleArrowDown"))
        addSubview(arrowImageView)
        arrowImageView.snp.makeConstraints {
            $0.trailing.equalTo(self.titleLabel!.snp.leading).offset(-8)
            $0.centerY.equalToSuperview()
        }

        setTitleColor(UIColor.LaLaSale.mainFontColor, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 16)
        setTitle(title, for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
