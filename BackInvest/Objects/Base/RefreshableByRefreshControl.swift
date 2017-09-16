//
// Created by Timofey on 7/29/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import RxSwift

//Create a RefreshableAndRecoverableByRefreshControl from Refreshable and Recoverable
class RefreshableByRefreshControl<T>: ObservableType {

    typealias E = T
    func subscribe<O:ObserverType>(_ observer: O) -> Disposable where O.E == E {
        return Observable.merge(
                [
                    refreshControl.rx.controlEvent(.valueChanged).asObservable(),
                    otherRefreshMethod.do(onNext: { [unowned self] in self.refreshControl.beginRefreshing() })
                ]
            )
            .startWith(()) //Begin execution immidiately
            .flatMapLatest{ [unowned self] in
                return self.origin
            }
            .do(
                onNext: { [unowned self] _ in
                    self.refreshControl.endRefreshing()
                },
                onError: { [unowned self] _ in
                    self.refreshControl.endRefreshing()
                }
            )
            .subscribe(observer)
    }

    private let otherRefreshMethod: Observable<Void>
    private let refreshControl: UIRefreshControl
    private let origin: Observable<T>
    init<ObservableOrigin: ObservableType>(origin: ObservableOrigin, updatedOn refreshControl: UIRefreshControl, and otherRefreshMethod: Observable<Void> = .never()) where ObservableOrigin.E == T {
        self.origin = origin.asObservable()
        self.refreshControl = refreshControl
        self.otherRefreshMethod = otherRefreshMethod
    }

}
