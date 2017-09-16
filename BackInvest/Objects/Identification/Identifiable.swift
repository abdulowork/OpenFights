//
// Created by Timofey on 9/16/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation

protocol Identifiable {

    var identification: Identification { get }

}

extension Identifiable {

    func identical(to identifiable: Identifiable) -> Bool {
        return self.identification.identical(to: identifiable.identification)
    }

}
