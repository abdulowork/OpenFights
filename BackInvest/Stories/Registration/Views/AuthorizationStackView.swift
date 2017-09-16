//
//  AuthorizationStackView.swift
//  DiscountMarket
//
//  Created by Артмеий Шлесберг on 30/06/2017.
//  Copyright © 2017 Jufy. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import ActiveLabel

class AuthorizationRequestStackView: VerticalStackView {

    private let phoneNumberView = PhoneNumberView()
    private let messageLabel: StandardLabel = StandardLabel(
        font: .openFont(ofSize: 12),
        textColor: UIColor.BackInvest.mainFontColor,
        text: NSLocalizedString("Enter your phone number. We will send you an authorization code.", comment: "")
        )
        .aligned(by: .center)

    private var proceedButton: StandardRoundEdgeButton
    
    private var isFullNumber : Bool {
        return phoneNumberView.isFull
    }

    private let disposeBag = DisposeBag()

    private let errorSubject = PublishSubject<Swift.Error>()
    lazy var wantsToDisplayError: Observable<Swift.Error> = self.errorSubject.asObservable()

    private let phoneSubject = PublishSubject<Phone>()
    lazy var providesPhone: Observable<Phone> = self.phoneSubject.asObservable()

    init(with proceedButtonState: ButtonState) {
        
        proceedButton = StandardRoundEdgeButton(
            backgroundColor: UIColor.BackInvest.smlAquaBlue,
            title: NSLocalizedString("Next", comment: "Proceed button when entering phone number"),
            state: StandardButtonState(
                continueOperatingOn: errorSubject,
                combinedWith: proceedButtonState
            )
        )

        super.init(frame: .zero)
        addArrangedSubviews([phoneNumberView, messageLabel, proceedButton])
        alignment = .center
        distribution = .equalSpacing
        spacing = 30
        
        messageLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(32)
            $0.trailing.equalToSuperview().inset(32)
        }
        
        phoneNumberView.snp.makeConstraints {
            $0.height.equalTo(25)
            $0.leading.equalToSuperview().offset(40)
            $0.trailing.equalToSuperview().inset(40)
        }
        
        proceedButton.snp.makeConstraints {
            $0.height.equalTo(39)
            $0.width.equalTo(276)
        }
        
        _ = phoneNumberView.becomeFirstResponder()

        proceedButton.rx.tap
            .map{ [unowned self] in
                guard self.isFullNumber else {
                    throw ErrorFrom(
                        NSLocalizedString(
                            "IncorrectPhoneNumberError",
                            comment: "Error indicates that phone number is not entered correctly"
                        )
                    )
                }
                //FIXME: PhoneFrom should throw on incorrect phone number
                return PhoneFrom(number: self.phoneNumberView.text)
            }
            .do(
                onError: { [unowned self] err in
                    self.errorSubject.on(.next(err))
                }
            )
            .retry()
            .bind(to: phoneSubject)
            .disposed(by: disposeBag)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

