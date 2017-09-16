//
// Created by Timofey on 9/16/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation

class BalanceInfoFrom: BalanceInfo {

    let averageCashback: Double
    let currentCashback: Double
    let percentageOfDedicatedCashback: Double

    init(averageCashback: Double, currentCashback: Double, percentageOfDedicatedCashback: Double) {
        self.averageCashback = averageCashback
        self.currentCashback = currentCashback
        self.percentageOfDedicatedCashback = percentageOfDedicatedCashback
    }

}
