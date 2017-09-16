//
// Created by Timofey on 7/21/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation

class ErrorFrom: LocalizedError {

    let errorDescription: String?

    var localizedDescription: String {
        return errorDescription ?? UnknownError().localizedDescription
    }

    init(_ description: String) {
        self.errorDescription = description
    }

}
