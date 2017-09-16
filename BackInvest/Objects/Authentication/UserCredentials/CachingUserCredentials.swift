//
// Created by Timofey on 7/18/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import KeychainAccess
import RxSwift

class CachingUserCredentials: UserCredentials, ObservableType {

    typealias E = UserCredentials
    func subscribe<O:ObserverType>(_ observer: O) -> Disposable where O.E == E {
        return origin.asObservable()
            .do(onNext: { [unowned self] credentials in
                self.phone = credentials.phone
                self.code = credentials.code
                try self.keychain.set(credentials.phone.number, key: "phone")
                try self.keychain.set(credentials.code, key: "code")
            })
            .subscribe(observer)
    }

    private(set) var phone: Phone = PhoneFrom(number: "")
    private(set) var code: String = ""

    private let origin: UserCredentials
    private let keychain: Keychain
    init(origin: UserCredentials, keychain: Keychain) {
        self.origin = origin
        self.keychain = keychain
    }

}
