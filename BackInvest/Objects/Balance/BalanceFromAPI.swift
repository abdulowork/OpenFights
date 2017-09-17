//
// Created by Timofey on 9/16/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import RxSwift
import Moya

class BalanceFromAPI: Balance {

    func fetchInformation() -> Observable<BalanceInfo> {
        return CardsFromAPI()
            .fetch()
            .retryWhen{ errors in
                return errors.delay(3, scheduler: MainScheduler.instance).take(3)
            }
            .single()
            .flatMap{ cards -> Observable<BalanceInfo> in
                return Observable.combineLatest(
                    cards.map{
                        $0.transactions
                            .fetch()
                            .retryWhen{ errors in
                               return errors.delay(3, scheduler: MainScheduler.instance).take(3)
                            }
                            .single()
                    }
                ) { elements in
                    let cashbackRate = 0.40
                    guard elements.count > 0 else { return BalanceInfoFrom(
                        averageCashback: CashbackFrom(value: 0),
                        currentCashback: CashbackFrom(value: 0),
                        percentageOfDedicatedCashback: 0.4
                    ) }
                    //FIXME: Fix this procedural shit
                    return BalanceInfoFrom(
                        averageCashback: CashbackFrom(value: -elements.reduce(0) { $0.0 + (Double($0.1.averageSpentPerDay()) * cashbackRate) * 30 }) ,
                        currentCashback: CashbackFrom(value: -elements.reduce(0) { $0.0 + Double($0.1.totalSpentLastMonth()) * cashbackRate }),
                        percentageOfDedicatedCashback: 20
                    )
                }
            }
    }

}

