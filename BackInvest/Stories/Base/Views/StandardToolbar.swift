//
// Created by Jufy on 18/08/2017.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import RxSwift

class StandardToolbar: UIToolbar {

    private let disposeBag = DisposeBag()
    init(for control: UIControl) {

        let doneButton = UIBarButtonItem(
            title: NSLocalizedString("Accept", comment: "input tool bar"),
            style: .done,
            target: nil,
            action: nil
        )
        doneButton.tintColor = UIColor.black
        doneButton.rx.tap
            .subscribe(onNext: { [unowned control] in
                control.sendActions(for: .editingDidEndOnExit)
            })
            .disposed(by: disposeBag)

        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        let cancelButton = UIBarButtonItem(
            title:  NSLocalizedString("Cancel", comment: "input tool bar"),
            style: .plain,
            target: nil,
            action: nil
        )
        cancelButton.tintColor = UIColor.black
        cancelButton.rx.tap
            .subscribe(onNext: { [unowned control] in
                control.endEditing(true)
            })
            .disposed(by: disposeBag)

        super.init(frame: .zero)
        
        barStyle = UIBarStyle.default
        isTranslucent = true
        tintColor = UIColor.white
        setItems([cancelButton, spaceButton, doneButton], animated: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
}
