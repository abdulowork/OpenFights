//
// Created by Timofey on 6/2/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

//FIXME: This is not actually a countdown label. It's a label with two attributes that is push oriented. For easy time frame injection design such a push object that can be initialized with two dates and injected into this label. TODO: Rename this label and get rid of incorrect interface. Passing Observable<String> as a generalization might be a bad idea.
final class PushLabel: StandardLabel {

    private var disposeBag = DisposeBag()

    private let additionalTitle: String

    var content: Observable<NSAttributedString> = Observable.never() {
        didSet {
            disposeBag = DisposeBag()
            content
                .map{ [unowned self] content in
                    let attributedString = NSMutableAttributedString(
                        string: self.additionalTitle,
                        attributes: [ NSFontAttributeName: self.font])
                    attributedString.append(content)
                    return attributedString
                }
                .bind(to: (rx.attributedText))
                .disposed(by: disposeBag)
        }
    }

    //TODO: Subclass for additional title
    init(additionalTitle: String = "") {
        self.additionalTitle = additionalTitle
        super.init(font: UIFont.systemFont(ofSize: 25), textColor: .black)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    func prepareForReuse() {
        disposeBag = DisposeBag()
    }
    
    func configured(with content: Observable<NSAttributedString>) -> PushLabel {
        self.content = content
        self.font = font
        return self
    }

}
