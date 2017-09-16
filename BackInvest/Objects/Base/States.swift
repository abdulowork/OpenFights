//
//  States.swift
//  DiscountMarket
//
//  Created by Артмеий Шлесберг on 26/07/2017.
//  Copyright © 2017 Jufy. All rights reserved.
//

import Foundation
import RxSwift


protocol ErrorState {

    var wantsToShowAlert: Observable<UIAlertController> { get } //TODO: Develop and use a more generic object Alert with AlertController

}

protocol EmptyState {

    var wantsToShowView: Observable<UIView> { get }

}

final class StandardErrorState: ErrorState {

    private let alertSubject = PublishSubject<UIAlertController>()
    lazy var wantsToShowAlert: Observable<UIAlertController> = self.alertSubject.asObservable()

    private let disposeBag = DisposeBag()
    init(errors: Observable<Error>) {

        errors
            .map{ error in
                let alertController = UIAlertController(
                    title: NSLocalizedString(
                        "ErrorAlertTitle",
                        comment: "Title for error alert, i.e. Error"
                    ),
                    message: error.localizedDescription,
                    preferredStyle: .alert
                )

                let dismissAction = UIAlertAction(
                    title: NSLocalizedString(
                        "DismissErrorAlertActionTitle",
                        comment: "Title for dismissing an alert"
                    ),
                    style: .default,
                    handler: { _ in alertController.dismiss(animated: true) }
                )

                alertController.addAction(dismissAction)

                return alertController
            }
            .bind(to: alertSubject)
            .disposed(by: disposeBag)

    }

}

final class StandardCollectionEmptyState<T>: EmptyState {

    private let emptyViewSubject = PublishSubject<UIView>()
    lazy var wantsToShowView: Observable<UIView> = self.emptyViewSubject.asObservable()

    private let disposeBag = DisposeBag()
    init(observable: Observable<[T]>, text: String) {

        let label = StandardLabel(
            font: .systemFont(ofSize: 14),
            text: text
        ).aligned(by: .center)

        observable
            .catchError{ _ in Observable.never() }
            .filter{ array in
                if array.isEmpty { } else {
                    label.removeFromSuperview()
                }
                return array.isEmpty
            }
            .map{ _ in label }
            .bind(to: emptyViewSubject)
            .disposed(by: disposeBag)

    }

}
