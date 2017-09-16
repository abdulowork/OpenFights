//
// Created by Timofey on 9/16/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation

class CardFrom: Card {

    let identification: Identification
    let transactions: Transactions

    init(identification: Identification, transactions: Transactions) {
        self.identification = identification
        self.transactions = transactions
    }

}