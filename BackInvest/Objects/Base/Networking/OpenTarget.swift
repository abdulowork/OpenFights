//
// Created by Timofey on 9/16/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import Moya

protocol OpenTarget: TargetType { }

extension OpenTarget {

    var baseURL: URL {
        return URL(string: "https://api.open.ru/MyCards/1.0.0")!
    }

    var parameterEncoding: ParameterEncoding {
        return JSONEncoding()
    }

    var sampleData: Data {
        fatalError("sampleData has not been implemented")
    }

    var task: Task {
        return .request
    }

}