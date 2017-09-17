//
//  AuthorizationCodeViewController.swift
//  DiscountMarket
//
//  Created by Артмеий Шлесберг on 01/07/2017.
//  Copyright © 2017 Jufy. All rights reserved.
//

import Foundation
import UIKit
import KeychainAccess
import RxSwift

class AuthorizationCodeViewController: UIViewController {

    private let disposeBag = DisposeBag()

    private let codeStackView: AuthorizationCodeStackView

    private let leadingTo: (Authority) -> (UIViewController)
    private let phone: Phone
    init(with phone: Phone, leadingTo: @escaping (Authority) -> (UIViewController)) {
        self.leadingTo = leadingTo
        self.phone = phone
        let completionSubject = PublishSubject<Void>()
        self.codeStackView = AuthorizationCodeStackView(
            with: self.phone,
            acceptButtonState: StandardButtonState(
                continueOperatingOn: completionSubject
            )
        )
        super.init(nibName: nil, bundle: nil)
        view.addSubview(codeStackView)

        codeStackView.snp.makeConstraints {
            $0.top.equalTo(topLayoutGuide.snp.bottom).offset(20)
            $0.trailing.leading.equalToSuperview()
        }
        view.backgroundColor = .white

        title = NSLocalizedString(
            "Авторизация",
            comment: "Title for screen when entering phone number"
        )

        codeStackView.providesCode
            .flatMapLatest { code -> Observable<Authority> in
                return AuthorityFromToken(
                    CachingToken(
                        origin: AnonymousToken(),
                        keychain: Keychain()
                    ),
                    keychain: Keychain(), //FIXME: These should be passed as a dependency to AuthorizationCodeViewController
                    userDefaults: UserDefaults.standard
                ).asObservable()
            }
            .do(
                onError: { [unowned self] err in
                    completionSubject.on(.next())
                    self.showMessage(
                        err.localizedDescription,
                        withTitle: NSLocalizedString(
                            "ErrorPopupTitle",
                            comment: "Title for error popup"
                        )
                    )
                }
            )
            .retry()
            .subscribe(onNext: { [unowned self] authority in
                completionSubject.on(.next())
                //TODO: We need to develop a factory for passing selectedMall and mallsToPickFrom for CategoriesViewController and DiscountsInAMallController
                //TODO: Make a Key object, inject it into FromUserDefaults classes. At least we need a Selected: String object
                let rootVC = self.leadingTo(authority)
                let snapShot = UIScreen.main.snapshotView(afterScreenUpdates: false)
                rootVC.view.addSubview(snapShot)
                UIApplication.shared.keyWindow?.rootViewController = rootVC
                UIView.animate(
                    withDuration: 0.4,
                    delay: 0,
                    options: .transitionCrossDissolve,
                    animations: { snapShot.alpha = 0},
                    completion: { _ in
                        snapShot.removeFromSuperview()
                    }
                )

            })
            .disposed(by: disposeBag)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
