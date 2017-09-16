//
// Created by Timofey on 7/20/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import RxSwift

class UserCredentialsFrom: UserCredentials, ObservableType {

    typealias E = UserCredentials
    func subscribe<O:ObserverType>(_ observer: O) -> Disposable where O.E == E {
        return Observable
            .just(self)
            .subscribe(observer)
    }

    let phone: Phone
    let code: String
    init(phone: Phone, code: String) {
        self.phone = phone
        self.code = code
    }

}
