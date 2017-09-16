//
// Created by Артмеий Шлесберг on 16/09/2017.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import RxSwift

class InvestmentCategoryCellView: UIView {

    var imageView: UIImageView = UIImageView()
    var stackView: VerticalStackView = VerticalStackView()
    private var disposeBag = DisposeBag()

    init() {
        super.init(frame: .zero)
        addSubviews([imageView, stackView])
        imageView.snp.makeConstraints {
            $0.leading.top.equalToSuperview().offset(20)
            $0.width.height.equalTo(120)
            $0.bottom.equalToSuperview().inset(20)
        }
        stackView.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.top.bottom.equalTo(imageView)
        }
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        imageView.layer.cornerRadius = 4
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(with category: InvestmentCategoryInCell ) {
        stackView.addArrangedSubviews([
            StandardLabel(font: .openFontMedium(ofSize: 17), textColor: .black, text: category.title),
            category.fatalityDifficulty.information,
            category.punchCount.information])
        category.image.image
        .bindTo(imageView.rx.image)
        .disposed(by: disposeBag)
    }

    func prepareForReuse() {
        disposeBag = DisposeBag()

        stackView.arrangedSubviews.forEach {
            stackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
    }

}

