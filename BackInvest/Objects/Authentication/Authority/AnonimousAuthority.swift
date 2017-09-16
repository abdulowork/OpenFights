//
// Created by Timofey on 6/30/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import RxSwift
import Moya

class AnonymousAuthority: Authority, ObservableType {

    typealias E = Authority
    func subscribe<O:ObserverType>(_ observer: O) -> Disposable where O.E == E {
        return Observable
            .just(self)
            .subscribe(observer)
    }

    let logout: Logout = FakeLogout()

    var authenticationPlugin: PluginType = AccessTokenPlugin(token: AnonymousToken().value)

}
