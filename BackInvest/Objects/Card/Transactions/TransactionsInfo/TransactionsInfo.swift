//
// Created by Timofey on 9/16/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation

protocol TransactionsInfo {

    func transactions(in timeFrame: Range<Date>) -> [Transaction]

    func allTransactions() -> [Transaction]

    //TODO: Develop an object Expenses

    func totalTransactionsEquity() -> Int

    func totalTransactionsEquityLastMonth() -> Int

    func averageTransactionsEquityPerDay() -> Int

    func totalSpentLastMonth() -> Int

    func averageSpentPerDay() -> Int

}
