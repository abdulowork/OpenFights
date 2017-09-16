//
// Created by Timofey on 9/16/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import ObjectMapper

class TransactionsFromAPI: Transactions {

    func fetch() -> Observable<TransactionsInfo> {
        return Provider<TransactionsTarget>()
            .request(.transactions(for: card))
            .map{ response in
                guard (200...299).contains(response.statusCode) else { throw ErrorResponse(response: response) }
                return TransactionsInfoFrom(
                    transactions: try Mapper<JSONTransaction>().mapArray(
                        JSONObject: Unwrap(
                            JSON: Unwrap(
                                JSON: Unwrap(
                                    JSON: response.mapJSON(failsOnEmptyData: true),
                                    path: "CardTransactionsList"
                                ).JSON,
                                index: 0
                            ).JSON,
                            path: "CardTransaction"
                        ).JSON
                    )
                )
            }
    }

    let card: Card
    init(card: Card) {
        self.card = card
    }

}
