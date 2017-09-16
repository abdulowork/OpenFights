//
// Created by Timofey on 7/18/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import KeychainAccess
import RxSwift

class TokenFromKeychain: Token, ObservableType {

    typealias E = Token
    func subscribe<O:ObserverType>(_ observer: O) -> Disposable where O.E == E {
        return Observable.just(keychain)
            .map{ [unowned self] keychain in
                self.value = try keychain.get("token").unwrapOrThrow()
                return self
            }
            .subscribe(observer)
    }

    var value: String = AnonymousToken().value
    private let keychain: Keychain
    init(keychain: Keychain) {
        self.keychain = keychain
    }

}
