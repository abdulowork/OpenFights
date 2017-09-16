//
// Created by Timofey on 9/16/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import ObjectMapper

class JSONTransaction: Transaction, ImmutableMappable {

    let date: Date
    let value: Int

    required init(map: Map) throws {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "dd.MM.yyyy"
        date = formatter.date(from: try map.value("TransactionDate")) ?? Date() //FIXME:
        value = Int(try map.value("TransactionSum") as String)!
    }

}
