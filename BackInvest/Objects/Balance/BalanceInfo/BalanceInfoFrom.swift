//
// Created by Timofey on 9/16/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation

class BalanceInfoFrom: BalanceInfo {

    let averageCashback: Cashback
    let currentCashback: Cashback
    let percentageOfDedicatedCashback: Double

    init(averageCashback: Cashback, currentCashback: Cashback, percentageOfDedicatedCashback: Double) {
        self.averageCashback = averageCashback
        self.currentCashback = currentCashback
        self.percentageOfDedicatedCashback = percentageOfDedicatedCashback
    }

}
