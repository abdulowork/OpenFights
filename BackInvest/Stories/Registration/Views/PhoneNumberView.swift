//
//  PhoneNumberView.swift
//  DiscountMarket
//
//  Created by Артмеий Шлесберг on 01/07/2017.
//  Copyright © 2017 Jufy. All rights reserved.
//

import Foundation
import UIKit
import SHSPhoneComponent

class PhoneNumberView: UIView {

    private var codeField: UITextField = UITextField()
        .withBottomBorder()
        .with(
            placeholder: NSLocalizedString(
                "PhoneCodePlaceholder",
                comment: "Placeholder text for country code when entering phone number"
            )
        )
        .with(textAlignment: .center)
        .with(font: .lalaSaleFont(ofSize: 17))
    private var numberField = SHSPhoneTextField()
        .withBottomBorder()
        .with(
            placeholder: NSLocalizedString(
                "PhoneNumberPlaceholder",
                comment: "Placeholder text for internal number when entering phone number"
            )
        )
        .with(textAlignment: .center)
        .with(font: .lalaSaleFont(ofSize: 17))
    
    var isFull : Bool {
        //FIXME: This might not account for country specific phone numbers
        return numberField.phoneNumber().characters.count == 10
    }

    var text: String {
        return "\(codeField.text ?? "") \(numberField.text ?? "")"
    }
    
    init() {
        super.init(frame: .zero)
        addSubviews([codeField, numberField])
        
        codeField.snp.makeConstraints {
            $0.leading.centerY.equalToSuperview()
            $0.width.equalTo(36)
        }
        
        
        codeField.text = "+7"
        codeField.isEnabled = false
        numberField.snp.makeConstraints {
            $0.trailing.centerY.equalToSuperview()
            $0.leading.equalTo(codeField.snp.trailing).offset(20)
        }
        numberField.formatter.setDefaultOutputPattern("(###) ### ##-##")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func becomeFirstResponder() -> Bool {
        return numberField.becomeFirstResponder()
    }
}
