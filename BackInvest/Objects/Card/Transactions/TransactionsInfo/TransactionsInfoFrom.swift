//
// Created by Timofey on 9/16/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation

class TransactionsInfoFrom: TransactionsInfo {

    private let transactions: [Transaction]
    init(transactions: [Transaction]) {
        self.transactions = transactions
    }

    func transactions(in timeFrame: Range<Date>) -> [Transaction] {
        return transactions.filter{ timeFrame.contains($0.date) }
    }

    func allTransactions() -> [Transaction] {
        return transactions
    }
    
    func totalTransactionsEquity() -> Int {
        return transactions.reduce(0) { $0.0 + $0.1.value }
    }

    func averageTransactionsEquityPerDay() -> Int {
        let sortedByDateTransactions = transactions.sorted(
            by: {
                $0.0.date.compare($0.1.date) == ComparisonResult.orderedAscending
            }
        )
        let firstTransactionDate = sortedByDateTransactions.first?.date ?? Date()
        guard firstTransactionDate.days(to: Date()) > 0 else { return 0 } //FIMXE: Bad
        return totalTransactionsEquity() / ((firstTransactionDate).days(to: Date()))
    }

    private func spendings(in timeFrame: Range<Date>) -> [Transaction] {
        return transactions(in: timeFrame).filter{ $0.value < 0 }
    }

    func totalTransactionsEquityLastMonth() -> Int {
        return transactions(
            in: Range<Date>(
                uncheckedBounds: (
                    lower: Date(timeIntervalSinceNow: -60*60*24*30*3),
                    upper: Date()
                )
            )
        ).reduce(0) { $0.0 + $0.1.value }
    }

    func totalSpentLastMonth() -> Int {
        return spendings(
            in: Range<Date>(
                uncheckedBounds: (
                    lower: Date(timeIntervalSinceNow: -60*60*24*30*3),
                    upper: Date()
                )
            )
        ).reduce(0) { $0.0 + $0.1.value }
    }

    func averageSpentPerDay() -> Int {
        let sortedByDateTransactions = transactions.filter{ $0.value < 0 }.sorted(
            by: {
                $0.0.date.compare($0.1.date) == ComparisonResult.orderedAscending
            }
        )
        let firstTransactionDate = sortedByDateTransactions.first?.date ?? Date()
        guard firstTransactionDate.days(to: Date()) > 0 else { return 0 } //FIMXE: Bad
        return sortedByDateTransactions.reduce(0) { $0.0 + $0.1.value } / firstTransactionDate.days(to: Date())
    }
}
