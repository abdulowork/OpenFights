//
// Created by Timofey on 7/3/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import RxSwift

class AnonymousToken: Token, ObservableType {

    typealias E = Token
    func subscribe<O:ObserverType>(_ observer: O) -> Disposable where O.E == E {
        return Observable
            .just(self)
            .subscribe(observer)
    }

    let value: String = ""

}