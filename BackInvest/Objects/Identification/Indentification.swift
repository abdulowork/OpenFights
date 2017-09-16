//
// Created by Timofey on 9/16/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation

protocol Identification {

    func identical(to: Identification) -> Bool

    func toInt() -> Int

}