//
// Created by Timofey on 9/16/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import Moya

enum TransactionsTarget: OpenTarget {

    case transactions(for: Card)
    var path: String {
        switch self {
        case .transactions:
            return "/MyCardsInfo/history"
        }
    }

    var method: Moya.Method {
        return .post
    }

    var parameters: [String: Any]? {
        switch self {
        case let .transactions(for: card):
            return [
                "CardId" : card.identification.toInt()
            ]
        }
    }

}