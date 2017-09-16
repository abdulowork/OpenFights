//
// Created by Timofey on 7/18/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import KeychainAccess
import RxSwift

class CachingToken: Token, ObservableType {

    typealias E = Token
    func subscribe<O:ObserverType>(_ observer: O) -> Disposable where O.E == E {
        return origin.asObservable()
            .do(onNext: { [unowned self] token in
                self.value = token.value
                try self.keychain.set(token.value, key: "token")
            })
            .subscribe(observer)
    }

    var value: String = AnonymousToken().value

    private let origin: Token
    private let keychain: Keychain
    init(origin: Token, keychain: Keychain) {
        self.origin = origin
        self.keychain = keychain
    }

}