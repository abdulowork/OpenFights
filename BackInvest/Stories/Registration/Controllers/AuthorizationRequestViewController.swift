//
//  AuthorizationViewController.swift
//  DiscountMarket
//
//  Created by Артмеий Шлесберг on 30/06/2017.
//  Copyright © 2017 Jufy. All rights reserved.
//

import Foundation
import RxSwift
import UIKit

class AuthorizationRequestViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    private var requestAuthStackView: AuthorizationRequestStackView

    private let leadingTo: (Authority) -> (UIViewController)
    init(leadingTo: @escaping (Authority) -> (UIViewController)) {
        self.leadingTo = leadingTo

        let authCompleted = PublishSubject<Void>()
        requestAuthStackView = AuthorizationRequestStackView(
            with: StandardButtonState(
                continueOperatingOn: authCompleted
            )
        )
        
        super.init(nibName: nil, bundle: nil)

        view.addSubview(requestAuthStackView)
        requestAuthStackView.snp.makeConstraints {
            $0.top.equalTo(topLayoutGuide.snp.bottom).offset(80)
            $0.trailing.leading.equalToSuperview()
        }
        view.backgroundColor = .white
        
        title = NSLocalizedString("RegistrationTitlePhone", comment: "Title for screen when entering phone number")//

        let errorSubject = PublishSubject<Swift.Error>()
        requestAuthStackView.wantsToDisplayError
            .bind(to: errorSubject)
            .disposed(by: disposeBag)

        //Remove authCompleted. Move this to a Recoverable with shareReplay
        requestAuthStackView
            .providesPhone
            .flatMapLatest{ phone -> Observable<Phone> in
                return FakeCodeRequest().asObservable().map{ phone }
            }
            .do(
                onNext: { _ in
                    authCompleted.on(.next())
                },
                onError: { err in
                    authCompleted.on(.next())
                    errorSubject.on(.next(err))
                }
            )
            .retry()
            .subscribe(onNext: { [unowned self] phone in
                self.commandToShowController(
                    from: {
                        AuthorizationCodeViewController(
                            with: phone,
                            leadingTo: self.leadingTo
                        )
                    }
                ).execute()
            })
            .disposed(by: disposeBag)

        errorSubject
            .subscribe(onNext: { [unowned self] error in
                self.showMessage(error.localizedDescription, withTitle: NSLocalizedString("Authorization Request Error", comment: ""))
            })
            .disposed(by: disposeBag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
