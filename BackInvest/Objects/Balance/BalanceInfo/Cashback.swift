//
// Created by Артмеий Шлесберг on 16/09/2017.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation

protocol Cashback {
    var value: Double { get }
    func asString() -> String
}

extension Cashback {
    func asString() -> String {
        return String(format: "%.2d ₽", arguments: [value])
    }
}