//
// Created by Timofey on 9/16/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation

protocol BalanceInfo {

    var currentCashback: Double { get }

    var averageCashback: Double { get }

    var percentageOfDedicatedCashback: Double { get } //TODO: Develop an object for that

}
