//
//  AuthorizationCodeStackView.swift
//  DiscountMarket
//
//  Created by Артмеий Шлесберг on 01/07/2017.
//  Copyright © 2017 Jufy. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class AuthorizationCodeStackView: VerticalStackView {
    
    private var messageLabel = StandardLabel(
        font: .openFont(ofSize: 12),
        text: NSLocalizedString(
            "Код был отправлен на номер",
            comment: "Message that the code was sent to the phone"
        )
    )

    private var phoneLabel: StandardLabel

    private var codeField: CodeTextField = CodeTextField()

    private var validLabel = PushLabel(
        additionalTitle: "\(NSLocalizedString("Код будет доступен:", comment: "")) ")
        .configured(
            with: Countdown(
                to: Date().addingTimeInterval(360)
            ).emittingEverySecond().map{
                NSAttributedString(
                    string: SecondsToMinutesAndSecondsString(seconds: $0, delimiter: ":").toString(),
                    attributes: [
                        NSFontAttributeName : UIFont.openFont(ofSize: 12)
                    ]
                )
            }
        )
        .with(font: .openFont(ofSize: 12))
        .with(textColor: UIColor.BackInvest.mainFontColor)
        .aligned(by: .center)

    private var acceptButton: StandardRoundEdgeButton

    private let disposeBag = DisposeBag()

    typealias Code = String
    private let codeSubject = PublishSubject<Code>()
    lazy var providesCode: Observable<Code> = self.codeSubject.asObservable()

    init(with phone: Phone, acceptButtonState: ButtonState) {
        self.phoneLabel = StandardLabel(
            font: .openFont(ofSize: 17),
            text: phone.number)
            .aligned(by: .center)
            .withBottomBorder()

        self.acceptButton = StandardRoundEdgeButton(
            backgroundColor: UIColor.BackInvest.smlAquaBlue,
            title: NSLocalizedString("Далее", comment: "Next when entering authorization code") ,
            state: acceptButtonState
        )

        super.init(frame: .zero)
        
        addArrangedSubviews([messageLabel, phoneLabel, codeField, validLabel, acceptButton])
        
        alignment = .center
        distribution = .equalSpacing
        spacing = 25
        
        acceptButton.snp.makeConstraints {
            $0.height.equalTo(39)
            $0.width.equalTo(276)
        }
        
        phoneLabel.snp.makeConstraints {
            $0.width.equalTo(276)
        }
        
        codeField.snp.makeConstraints {
            $0.height.equalTo(25)
            $0.width.equalTo(128)
        }
        
        validLabel.snp.makeConstraints {
            $0.height.equalTo(14)
            $0.width.equalToSuperview()
        }
        
        _ = codeField.becomeFirstResponder()

        acceptButton.rx.tap
            .map{ [unowned self ] in self.codeField.code }
            .bind(to: codeSubject)
            .disposed(by: disposeBag)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

