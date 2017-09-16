//
// Created by Timofey on 9/16/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation

class StandardIdentification: Identification {

    private let id: Int
    init(id: Int) {
        self.id = id
    }

    func identical(to: Identification) -> Bool {
        return id == id
    }

    func toInt() -> Int {
        return id
    }
}