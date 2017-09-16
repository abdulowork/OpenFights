//
// Created by Timofey on 8/28/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation

struct SecondsToMinutesAndSecondsString {

    private let seconds: Int
    private let delimiter: String
    init(seconds: Int, delimiter: String) {
        self.seconds = seconds
        self.delimiter = delimiter
    }

    func toString() -> String {
        return "\(seconds/60)\(delimiter)\(String(format: "%.2d", seconds%60))"
    }

}