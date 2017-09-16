//
//  CardsFromAPITests.swift
//  BackInvest
//
//  Created by Timofey on 9/16/17.
//  Copyright © 2017 Jufy. All rights reserved.
//

import XCTest
import RxBlocking
@testable import BackInvest

class CardsFromAPITests: XCTestCase {
    
    func testCardsRetrievalFromAPI() {
        let cards = try! CardsFromAPI().fetch().toBlocking().single()!
        XCTAssert(cards.count > 0)
    }
    
}
