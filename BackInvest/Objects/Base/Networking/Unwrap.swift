//
// Created by Timofey on 6/30/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation

class Unwrap {

    let JSON: Any
    //FIXME: wtf
    init(JSON: Any, path: String) throws {
        guard
            let dataJSON = JSON as? [String : Any],
            dataJSON.contains(where: { key, _ in key == path }) else { throw NSError(domain: "Can't unwrap JSON", code: 1) }
        self.JSON = dataJSON[path] ?? [] //FIXME: ??
    }

}
