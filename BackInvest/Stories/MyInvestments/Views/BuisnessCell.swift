//
// Created by Артмеий Шлесберг on 17/09/2017.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import RxSwift

class BusinessCell: UITableViewCell {

    var photo: UIImageView = UIImageView(image: #imageLiteral(resourceName: "rectangle"))
    var stackView: VerticalStackView = VerticalStackView()
    private var disposeBag = DisposeBag()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews([photo, stackView])
        photo.snp.makeConstraints {
            $0.leading.top.equalToSuperview().offset(20)
            $0.width.height.equalTo(120)
            $0.bottom.equalToSuperview().inset(20)
        }
        stackView.snp.makeConstraints {
            $0.leading.equalTo(photo.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.top.bottom.equalTo(photo)
        }
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        photo.layer.cornerRadius = 4
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configured(with business: Business ) -> Self {
        stackView.addArrangedSubviews([
            StandardLabel(font: .openFontMedium(ofSize: 17), textColor: .black, text: business.title),
            TitledProgressView(completion: 0.30, title: "Кредит погашен"),
            StandardLabel(font: .openFont(ofSize: 15), textColor: UIColor.BackInvest.darkGrey, text: "Мои средства: 3 200 ₽")
        ])
        return self
    }

    override func prepareForReuse() {
        disposeBag = DisposeBag()

        stackView.arrangedSubviews.forEach {
            stackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
    }
}
