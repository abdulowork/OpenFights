//
//  StandardRoundEdgeButton.swift
//  DiscountMarket
//
//  Created by Timofey on 5/29/17.
//  Copyright © 2017 Jufy. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift

class StandardRoundEdgeButton: UIButton {
    
    private let disposeBag = DisposeBag()
    
    private let waitingIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
    private let buttonState: ButtonState
    init(backgroundColor: UIColor = .clear, title: String = "", state: ButtonState = NeverExecutingButtonState()) {
        
        let tapSubject = PublishSubject<Void>()
        self.buttonState = StandardButtonState(
            waitOn: state is NeverExecutingButtonState ? Observable.never() : tapSubject.asObservable(),
            combinedWith: state
        )
        
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        
        rx.tap.bind(to: tapSubject).disposed(by: disposeBag)
        
        rx.controlEvent(.touchDown).subscribe(onNext: { [unowned self] in
            self.backgroundColor = self.backgroundColor?.withAlphaComponent(0.5) ?? nil
        }).disposed(by: disposeBag)
        
        rx.controlEvent([.touchCancel, .touchUpOutside, .touchUpInside]).subscribe(onNext: { [unowned self] in
            self.backgroundColor = self.backgroundColor?.withAlphaComponent(1) ?? nil
        }).disposed(by: disposeBag)
        
        titleLabel?.numberOfLines = 0
        setTitle(title, for: .normal)
        layer.cornerRadius = 4
        layer.masksToBounds = true

        //FIXME: This should be a contentInset
        snp.makeConstraints { make in
            make.height.equalTo(38).priority(999)
        }
        
        addSubview(waitingIndicator)
        waitingIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        waitingIndicator.isHidden = true
        waitingIndicator.hidesWhenStopped = true
        
        buttonState.startWaiting
            .subscribe(onNext: { [unowned self] in
                self.setWaiting(true)
            })
            .disposed(by: disposeBag)
        
        buttonState.continueOperating
            .subscribe(onNext: { [unowned self] in
                self.setWaiting(false)
            })
            .disposed(by: disposeBag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setWaiting(_ waiting: Bool) {
        self.layoutIfNeeded()
        isEnabled = !waiting
        setTitleColor(titleColor(for: .normal)?.withAlphaComponent(waiting ? 0 : 1), for: .normal)
        if waiting {
            waitingIndicator.startAnimating()
        }
        else {
            waitingIndicator.stopAnimating()
        }
    }

}

protocol ButtonState {

    var startWaiting: Observable<Void> { get }

    var continueOperating: Observable<Void> { get }

}

class StandardButtonState: ButtonState {

    let startWaiting: Observable<Void>
    let continueOperating: Observable<Void>

    init<Waiting, Continuation, AnyWaitingObservable: ObservableType, AnyContinuationObservable: ObservableType>(waitOn: AnyWaitingObservable, continueOperatingOn: AnyContinuationObservable) where AnyWaitingObservable.E == Waiting, AnyContinuationObservable.E == Continuation {
        startWaiting = waitOn.map{ _ in () }
        continueOperating = continueOperatingOn.map{ _ in () }
    }

    init<Waiting, Continuation, AnyWaitingObservable: ObservableType, AnyContinuationObservable: ObservableType>(
        waitOn: AnyWaitingObservable,
        continueOperatingOn: AnyContinuationObservable,
        combinedWith state: ButtonState = NeverExecutingButtonState()) where AnyWaitingObservable.E == Waiting, AnyContinuationObservable.E == Continuation {
        startWaiting = Observable.merge([state.startWaiting, waitOn.map{ _ in () }])
        continueOperating = Observable.merge([state.continueOperating, continueOperatingOn.map{ _ in () }])
    }
    
    init<Waiting, AnyWaitingObservable: ObservableType>(
        waitOn: AnyWaitingObservable,
        combinedWith state: ButtonState = NeverExecutingButtonState()) where AnyWaitingObservable.E == Waiting {
        startWaiting = Observable.merge([state.startWaiting, waitOn.map{ _ in () }])
        continueOperating = state.continueOperating
    }

    init<Continuation, AnyContinuationObservable: ObservableType>(
        continueOperatingOn: AnyContinuationObservable,
        combinedWith state: ButtonState = NeverExecutingButtonState()) where AnyContinuationObservable.E == Continuation {
        startWaiting = state.startWaiting
        continueOperating = Observable.merge([state.continueOperating, continueOperatingOn.map{ _ in () }])
    }

}

class NeverExecutingButtonState: ButtonState {

    let startWaiting: Observable<Void> = .never()
    let continueOperating: Observable<Void> = .never()

}
