//
// Created by Timofey on 7/18/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import KeychainAccess
import RxSwift

class LogoutFromApplication: Logout, ObservableType {

    typealias E = Void
    func subscribe<O:ObserverType>(_ observer: O) -> Disposable where O.E == E {
        return commitSubject
            .do(onNext: { [unowned self] in
                try self.keychain.removeAll()
                
            })
            .subscribe(observer)
    }

    private let commitSubject = PublishSubject<Void>()
    func commit() {
        commitSubject.on(.next())
    }

    private let keychain: Keychain
    private let userDefaults: UserDefaults
    init(keychain: Keychain, userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
        self.keychain = keychain
    }

}
