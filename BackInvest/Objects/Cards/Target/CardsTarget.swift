//
// Created by Timofey on 9/16/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import Moya

enum CardsTarget: OpenTarget {

    case allCards

    var path: String {
        switch self {
        case .allCards:
            return "/MyCardsInfo/cardlist"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var parameters: [String : Any]? {
        return nil
    }
    
}
