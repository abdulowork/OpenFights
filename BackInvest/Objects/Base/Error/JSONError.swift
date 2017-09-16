//
// Created by Timofey on 7/20/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import ObjectMapper

class JSONError: Swift.Error, ImmutableMappable {

    let localizedDescription: String

    required init(map: Map) throws {
        self.localizedDescription = try map.value("message")
    }

    func mapping(map: Map) {

    }
    
}
