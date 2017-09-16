//
// Created by Timofey on 7/20/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import ObjectMapper

class JSONErrors: Swift.Error, ImmutableMappable {

    let localizedDescription: String

    required init(map: Map) throws {
        let errors = (try map.value("messages") as [String])
        self.localizedDescription = errors.reduce("") { $0.0 + "\($0.1)\n" }
    }

    func mapping(map: Map) {

    }

}
