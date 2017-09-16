//
// Created by Timofey on 8/28/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import RxSwift

class Countdown {

    private let dateToCountTo: Date

    init(to dateToCountTo: Date) {
        self.dateToCountTo = dateToCountTo
    }

    func emittingEverySecond() -> Observable<Int> {
        return Observable<Void>
            .just() //This is to start execution immediately
            .concat(Observable<Int>.interval(TimeInterval(1), scheduler: MainScheduler.instance).map{ _ in () })
            .takeWhile{ [dateToCountTo = self.dateToCountTo] in dateToCountTo.isFuture }
            .map{ [dateToCountTo = self.dateToCountTo] in
                return Date().seconds(to: dateToCountTo)
            }
    }

}
