//
// Created by Timofey on 7/18/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import RxSwift

class DependentFakeLogout: Logout, ObservableType {

    typealias E = Void
    func subscribe<O:ObserverType>(_ observer: O) -> Disposable where O.E == E {
        return origin.asObservable()
            .subscribe(observer)
    }

    private let origin: Logout
    init(origin: Logout) {
        self.origin = origin
    }

    private let commitSubject = PublishSubject<Void>()
    func commit() {
        origin.commit()
    }

}
