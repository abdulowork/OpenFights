//
//  TransactionsTests.swift
//  BackInvest
//
//  Created by Timofey on 9/17/17.
//  Copyright © 2017 Jufy. All rights reserved.
//

import XCTest
import RxBlocking
@testable import BackInvest

class TransactionsTests: XCTestCase {
    
    func testExample() {
        //FIXME: This test barely tests anything. Create a TransactionsFrom, initialize it with transactions and use it to test business logic.

        let transactions = try! TransactionsFromAPI(
            card: CardFrom(
                identification: StandardIdentification(id: 42),
                transactions: EmptyTransactions()
            )
        ).fetch().toBlocking().single()!

        XCTAssert(
            transactions.transactions(
                in: Range(
                    uncheckedBounds: (
                        lower: Date.distantPast,
                        upper: Date()
                    )
                )
            ).count > 1
        )
    }

}
