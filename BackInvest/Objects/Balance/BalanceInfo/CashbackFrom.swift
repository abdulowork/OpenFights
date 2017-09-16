//
// Created by Timofey on 9/16/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation

class CashbackFrom: Cashback {
    private(set) var value: Double = 0

    init(value: Double) {
        self.value = value
    }

}