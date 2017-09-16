//
// Created by Timofey on 7/18/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import RxSwift
import KeychainAccess

//Does not track mutating keychains
class UserCredentialsFromKeychain: UserCredentials, ObservableType {

    typealias E = UserCredentials
    func subscribe<O:ObserverType>(_ observer: O) -> Disposable where O.E == E {
        return Observable
            .just(keychain)
            .map{ [unowned self] keychain in
                do {
                    self.phone = try PhoneFrom(number: keychain.get("phone").unwrapOrThrow())
                    self.code = try keychain.get("code").unwrapOrThrow()
                } catch _ {
                    throw NSError(domain: "Failed", code: 1)
                }
                
                return self
            }
            .subscribe(observer)
    }

    var phone: Phone = PhoneFrom(number: "")
    var code: String = ""
    private let keychain: Keychain
    init(keychain: Keychain) {
        self.keychain = keychain
    }

}
