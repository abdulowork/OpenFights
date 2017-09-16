//
// Created by Timofey on 6/30/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation

class Unwrap {

    let JSON: Any
    //FIXME: wtf
    //FIXME: Refactor via Hashable instead of string and int
    //FIXME: Separate dictionary unwrap from array unwrap or make it an explicit JSON unwra. Verify against JSON protocol.
    init(JSON: Any, path: String) throws {
        guard
            let dataJSON = JSON as? [String : Any],
            dataJSON.contains(where: { key, _ in key == path }) else { throw NSError(domain: "Can't unwrap JSON", code: 1) }
        self.JSON = dataJSON[path] ?? [] //FIXME: ??
    }

    init(JSON: Any, index: Int) throws {
        guard
            let dataJSON = JSON as? [Any],
            dataJSON.enumerated().contains(where: { number, _ in number == index }) else { throw NSError(domain: "Can't unwrap JSON", code: 1) }
        self.JSON = dataJSON[index]
    }

}
