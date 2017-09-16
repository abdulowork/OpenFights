//
// Created by Timofey on 9/16/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper
import Moya

class CardsFromAPI: Cards {

    func fetch() -> Observable<[Card]> {
        return Provider<CardsTarget>()
            .request(.allCards)
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .map{ response in
                guard (200...299).contains(response.statusCode) else { throw ErrorResponse(response: response) }
                return try Mapper<JSONCard>()
                    .mapArray(
                        JSONObject: Unwrap(
                            JSON: Unwrap(
                                JSON: response.mapJSON(failsOnEmptyData: true),
                                path: "Cards"
                            ).JSON,
                            path: "Card"
                        ).JSON
                    )
            }
            .observeOn(MainScheduler.instance)
    }

}
