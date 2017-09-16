//
// Created by Timofey on 7/18/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import RxSwift

class FakeUserCredentials: UserCredentials, ObservableType {

    typealias E = UserCredentials
    func subscribe<O:ObserverType>(_ observer: O) -> Disposable where O.E == E {
        return Observable
            .just(self)
            .subscribe(observer)
    }

    let phone: Phone
    let code: String
    init(phone: Phone = FakePhone(), code: String = "0000") {
        self.phone = phone
        self.code = code
    }

}
