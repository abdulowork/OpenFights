//
// Created by Timofey on 7/24/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation

extension URLRequest {

    mutating func with(httpBody: Data) -> URLRequest {
        self.httpBody = httpBody
        return self
    }

}
