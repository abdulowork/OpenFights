//
//  AppDelegate.swift
//  BackInvest
//
//  Created by Timofey on 9/16/17.
//  Copyright © 2017 Jufy. All rights reserved.
//

import UIKit
import RxSwift
import KeychainAccess

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private let disposeBag = DisposeBag()
    private let logoutSubject = PublishSubject<Void>()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = {
            let temp = MyInvestmentViewController()
            temp.view.backgroundColor = .white
            return temp
        }()
        self.window?.makeKeyAndVisible()
        return true

        logoutSubject.subscribe(onNext: { [unowned self] in
            self.window?.transition(
                to: StandardNavigationController(
                    rootViewController: AuthorizationRequestViewController(
                        leadingTo: { [unowned self] authority in

                            authority.logout
                                .asObservable()
                                .retry()
                                .bind(to: self.logoutSubject)
                                .disposed(by: self.disposeBag)

                            return StandardNavigationController(
                                rootViewController: SuggestedInvestmentsController(
                                    with: BalanceFromAPI(),
                                    investmentCategories: FakeInvestmentCategories()
                                )
                            )
                        }
                    )
                )
            )
        }).disposed(by: disposeBag)



//        let rootController = UITabBarController(with: <#T##[UIViewController]##[UIKit.UIViewController]#>)

        //FIXME: Refactor completely. This chain of events should be an object and there should be a Policy guiding it
        AuthorityFromToken(
            TokenFromKeychain(
                keychain: Keychain()
            ),
            keychain: Keychain(),
            userDefaults: UserDefaults.standard
        ).asObservable().do(onNext: { _ in
                throw UnknownError()
            })
            .subscribe(
                onError: { [unowned self] _ in
                    self.window?.rootViewController = StandardNavigationController(
                        rootViewController: AuthorizationRequestViewController(
                            leadingTo: { authority in

                                authority.logout
                                    .asObservable()
                                    .retry()
                                    .bind(to: self.logoutSubject)
                                    .disposed(by: self.disposeBag)

                                return UITabBarController(controllers:[
                                    StandardNavigationController(
                                        rootViewController: SuggestedInvestmentsController(
                                            with: BalanceFromAPI(),
                                            investmentCategories: FakeInvestmentCategories()
                                        )
                                    ).with(tabBarItem: UITabBarItem(title: "Главное", image: #imageLiteral(resourceName: "003Home"), tag: 0)),
                                    StandardNavigationController(
                                        rootViewController:
                                        MyInvestmentsController(with: MyICOInvestments())
                                        ).with(tabBarItem: UITabBarItem(title: "Мой портфель", image: #imageLiteral(resourceName: "001Briefcase"), tag: 2))
                                    ])
                            }
                        )
                    )
                }
            )
            .disposed(by: disposeBag)

        return true
    }

}

