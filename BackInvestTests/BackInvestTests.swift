//
//  BackInvestTests.swift
//  BackInvestTests
//
//  Created by Timofey on 9/16/17.
//  Copyright © 2017 Jufy. All rights reserved.
//

import XCTest
@testable import BackInvest

class BackInvestTests: XCTestCase {
    
    let balanceFromAPI = BalanceFromAPI()
    func testExample() {
        let balance = try! balanceFromAPI.fetchInformation().toBlocking().single()
        print(balance?.currentCashback)
    }
    
}
