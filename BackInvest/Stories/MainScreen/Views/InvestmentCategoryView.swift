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
        imageView.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview().offset(20)
            $0.width.height.equalTo(120)
        }
        stackView.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.top.bottom.equalTo(imageView)
        }

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
        
        stackView.subviews.forEach { $0.removeFromSuperview() }
    }

}

class ProgressBarView: UIView {

    var completion: Double = 0 {
        didSet {
            completionView.snp.remakeConstraints {
                $0.width.equalToSuperview().multipliedBy(completion)
            }
        }
    }
    private var completionView: UIView = UIView()

    init(completion: Double = 0) {
        super.init(frame: .zero)
        addSubview(completionView)
        completionView.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.width.equalToSuperview()
        }
        self.completion = completion

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = self.frame.height/2.0
        completionView.layer.cornerRadius = self.frame.height/2.0
    }
}
