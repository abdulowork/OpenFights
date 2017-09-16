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
                    //FIXME: This is bad
                    let cashbackRate = 0.015
                    guard elements.count > 0 else { return BalanceInfoFrom(
                        averageCashback: 0,
                        currentCashback: 0,
                        percentageOfDedicatedCashback: 0.4
                    ) }
                    return BalanceInfoFrom(
                        averageCashback: elements.reduce(0.0) { token, info in token + Double(info.averageTransactionsEquityPerDay() * 30) * cashbackRate },
                        currentCashback: elements.reduce(0.0) { $0.0 + Double($0.1.totalTransactionsEquityLastMonth()) * cashbackRate},
                        percentageOfDedicatedCashback: 0.4
                    )
                }
            }
    }

}

