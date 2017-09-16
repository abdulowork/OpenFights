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
                        averageCashback: CashbackFrom(value: 0),
                        currentCashback: CashbackFrom(value: 0),
                        percentageOfDedicatedCashback: 0.4
                    ) }
                    return BalanceInfoFrom(
                        averageCashback: CashbackFrom(value: 2000),
                        currentCashback: CashbackFrom(value: 1500),
                        percentageOfDedicatedCashback: 0.4
                    )
                }
            }
    }

}

