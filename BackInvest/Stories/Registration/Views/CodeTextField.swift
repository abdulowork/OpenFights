//
//  CodeTextField.swift
//  DiscountMarket
//
//  Created by Артмеий Шлесберг on 02/07/2017.
//  Copyright © 2017 Jufy. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class CodeTextField : HorizontalStackView {
    
    private let disposeBag = DisposeBag()
    
    private var textFields: [UITextField]
    
    var code: String {
        return self.textFields.reduce("") { $0 + ($1.text ?? "") }
    }
    
    lazy var codeEntered: Observable<Void> = Observable.create { observer in
        self.textFields.last!.rx.text.subscribe(onNext: { text in
            if let text = text, text.characters.count > 0 {
                observer.onNext()
            }
        }).disposed(by: self.disposeBag)
        return Disposables.create()
    }
    
    
    init(numberOfDigits: Int = 4) {
        textFields = (1...numberOfDigits).map{ _ in
            return UITextField()
                .withBottomBorder()
                .with(textAlignment: .center)
                .with(font: .lalaSaleFont(ofSize: 20))
                .with(keyboard: .numberPad)
        }
        
        super.init(frame: .zero)

        var iterator = textFields.dropFirst().makeIterator()
        addArrangedSubviews(textFields.map{ textField in
            textField.snp.makeConstraints {
                $0.width.equalTo(22)
            }
            
            textField.rx
                .controlEvent(UIControlEvents.editingDidBegin)
                .map{""}
                .bind(to: textField.rx.text)
                .disposed(by: disposeBag)
            
            textField.rx
                .controlEvent(UIControlEvents.editingChanged)
                .subscribe(onNext: { [weak textField] in
                    textField?.sendActions(for: UIControlEvents.editingDidEndOnExit)
                })
                .disposed(by: disposeBag)
            
            return SwitchableTextField(with: textField, next: iterator.next(), disposeBag: disposeBag).textField
        })
        alignment = .center
        distribution = .equalSpacing
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func becomeFirstResponder() -> Bool {
        return textFields.first?.becomeFirstResponder() ?? false
    }
}

class SwitchableTextField<TextField: UITextField> {
    
    let textField: TextField
    
    init(with textField: TextField, next: UIResponder?, disposeBag: DisposeBag) {
        self.textField = textField
        textField.rx.controlEvent(.editingDidEndOnExit).subscribe(onNext: { _ in
            if let next = next {
                next.becomeFirstResponder()
            } else {
                textField.endEditing(true)
            }
        })
        .disposed(by: disposeBag)
    }
}
