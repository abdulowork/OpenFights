//
// Created by Timofey on 7/3/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import KeychainAccess

class AuthorityFromToken: Authority, ObservableType {

    typealias E = Authority
    func subscribe<O:ObserverType>(_ observer: O) -> Disposable where O.E == E {
        return token.asObservable()
            .do(onNext: { [unowned self] token in
                self.token = token
             })
            .map{ _ in self }
            .subscribe(observer)
    }

    let logout: Logout

    private var token: Token
    fileprivate struct AuthorityWithFakeLogout: Authority { //This is a hack to prevent recersive dependency. I am not sure how to fix it. Probably something is wrong with fundamental design of authority.
        
        let logout: Logout = FakeLogout()
        
        let authenticationPlugin: PluginType
        
        init(token: Token) {
            self.authenticationPlugin = AccessTokenPlugin(token: token.value)
        }
        
        func asObservable() -> Observable<Authority> {
            return .just(self)
        }
        
    }
    init(_ token: Token, keychain: Keychain, userDefaults: UserDefaults) {
        self.token = token
        self.logout = LogoutFromApplication(
            origin: FakeLogout(),
            keychain: keychain,
            userDefaults: userDefaults
        )
    }

    var authenticationPlugin: Moya.PluginType {
        return AccessTokenPlugin(token: token.value)
    }

}
