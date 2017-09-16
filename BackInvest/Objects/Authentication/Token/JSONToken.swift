//
//  DiscountMarket
//
//  Created by Timofey on 6/30/17.
//  Copyright © 2017 Jufy. All rights reserved.
//

import Foundation
import ObjectMapper
import RxSwift

class JSONToken: Token, ImmutableMappable, ObservableType {
    
    let value: String

    typealias E = Token
    func subscribe<O:ObserverType>(_ observer: O) -> Disposable where O.E == E {
        return Observable
            .just(self)
            .subscribe(observer)
    }

    init(origin: Token) {
        self.value = origin.value
    }

    required init(map: Map) throws {
        value = try map.value("token")
    }

    func mapping(map: Map) {
        value >>> map["token"]
    }

}
