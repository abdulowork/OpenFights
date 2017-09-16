//
// Created by Timofey on 7/20/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import ObjectMapper
import Moya

class ErrorResponse: LocalizedError {

    private let description: String
    
    init(response: Moya.Response, fallbackError: Swift.Error = UnknownError()) {
        
        let errorJSON: Any
        
        do {
            errorJSON = try Unwrap(
                JSON: response.mapJSON(failsOnEmptyData: true),
                path: "error"
            ).JSON
        } catch {
            self.description = fallbackError.localizedDescription
            return
        }
        
        if let error = try? Mapper<JSONError>().map(JSONObject: errorJSON) {
            self.description = error.localizedDescription
        } else if let error = try? Mapper<JSONErrors>().map(JSONObject: errorJSON) {
            self.description = error.localizedDescription
        } else {
            self.description = fallbackError.localizedDescription
        }

    }

    var localizedDescription: String {
        return description
    }

    var errorDescription: String? {
        return localizedDescription
    }

}
