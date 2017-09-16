//
// Created by Timofey on 6/21/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import RxSwift

//FIXME: Item can't be type constrained. Have to use force cast. Should be a part of collection protocol.
class FilterableByTitleCollection<Item>: ObservableType {

    fileprivate let origin: Observable<Array<Item>>
    fileprivate let filteringStrategy: Observable<TitlableModelFilteringStrategy>

    init<Origin: ObservableType>(
        origin: Origin,
        filteringStrategy: Observable<TitlableModelFilteringStrategy>) where Origin.E == Array<Item> {
        self.origin = origin.asObservable()
        self.filteringStrategy = filteringStrategy
    }
    
    typealias E = Array<Item>
    func subscribe<O:ObserverType>(_ observer: O) -> Disposable where O.E == Array<Item> {
        return Observable.combineLatest(
            origin,
            filteringStrategy
            )
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
            .map{ origin, strategy in
                origin.filter{ strategy.shouldInclude(item: $0 as! Titlable) }
            }
            .observeOn(MainScheduler.instance)
            .subscribe(observer)
    }

}
