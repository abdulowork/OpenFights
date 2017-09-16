//
// Created by Timofey on 7/5/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import RxSwift

class Refreshable<T>: ObservableType {

    typealias E = T
    func subscribe<O:ObserverType>(_ observer: O) -> Disposable where O.E == E {
        return refreshMeans
            .flatMapLatest{ [unowned self] in
                return self.origin.asObservable()
            }
            .subscribe(observer)
    }

    private let disposeBag = DisposeBag()
    private let origin: Observable<T>
    init(origin: Observable<T>, updatedOn: Observable<Void> = .never()) {
        self.origin = origin
        updatedOn.bind(to: refreshMeans).disposed(by: disposeBag)
    }
    
    //TODO: Make a RefreshableDiscounts decorator
    private let refreshMeans = BehaviorSubject<Void>(value: ())

    func refresh() {
        refreshMeans.on(.next())
    }

}
