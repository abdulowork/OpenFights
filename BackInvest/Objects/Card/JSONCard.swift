//
// Created by Timofey on 9/16/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import ObjectMapper

class JSONCard: Card, ImmutableMappable {

    let identification: Identification

    required init(map: Map) throws {
        identification = try StandardIdentification(id: Int(map.value("CardId") as String)!)
    }

}