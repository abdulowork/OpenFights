//
// Created by Timofey on 7/18/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import RxSwift

class FakeLogout: Logout, ObservableType {

    typealias E = Void
    func subscribe<O:ObserverType>(_ observer: O) -> Disposable where O.E == E {
        return commitSubject.asObservable()
            .do(
                onNext: { [unowned self] in self.completionSubject.on(.next())  }
            ).subscribe(observer)
    }

    private let commitSubject = PublishSubject<Void>()
    func commit() {
        commitSubject.on(.next())
    }

    private let completionSubject = PublishSubject<Void>()
    lazy var hasCompleted: Observable<Void> = self.completionSubject.asObservable()

}
