//
// Created by Артмеий Шлесберг on 17/09/2017.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import RxSwift

class InfoButton: UIButton {

    var disposeBag = DisposeBag()

    var infoView: InfoView
    init(info: String, closeOn: Observable<Void>) {
        infoView = InfoView(info: info)
        super.init(frame: .zero)
        setImage(#imageLiteral(resourceName: "web"), for: .normal)
        infoView.alpha = -1
        addSubview(infoView)
        infoView.snp.makeConstraints {
            $0.top.equalTo(self.snp.bottom)
            $0.trailing.equalTo(self.snp.leading)
            $0.width.equalTo(210)
        }
        rx.tap.subscribe(onNext: {
            UIView.animate(withDuration: 0.3) { [unowned self] in
                self.infoView.alpha *= -1
            }
        }).disposed(by: disposeBag)

        closeOn.subscribe(onNext: { [unowned self] in
            UIView.animate(withDuration: 0.3) {
                self.infoView.alpha = -1
            }
        }).disposed(by: disposeBag)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    class InfoView: UIView {
        init(info: String){
            super.init(frame: .zero)
            let cornerView = UIView()
            let infoLabel = StandardLabel(font: .openFont(ofSize: 13), textColor: .white, text: info)
            .with(numberOfLines: 0)
            backgroundColor = UIColor.BackInvest.mainTintColor
            cornerView.backgroundColor = UIColor.BackInvest.mainTintColor
            addSubviews([cornerView, infoLabel])
            cornerView.snp.makeConstraints {
                $0.height.width.equalTo(12)
                $0.top.trailing.equalToSuperview()
            }
            infoLabel.snp.makeConstraints {
                $0.top.leading.equalToSuperview().offset(8)
                $0.bottom.trailing.equalToSuperview().inset(8)
            }
            layer.cornerRadius = 12
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}
