//
// Created by Артмеий Шлесберг on 17/09/2017.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import RxSwift

struct MyICOInvestments: MyInvestments {
    func fetch() -> RxSwift.Observable<[MyInvestment]> {
        return Observable.just([
            MyICOInvestment(),
            MyICOInvestment(),
            MyICOInvestment(),
            MyICOInvestment(),
        ])
    }
}

struct MyICOInvestment: MyInvestment {
    var title: String = "ICO"

    private(set) var business: Business = CoffeeBusiness()
}

struct CoffeeBusiness: Business {
    private(set) var title: String = "Кофейня \"Finish him\""
    private(set) var description: String = "ICO ICO ICO ICO v ICO ICO ICO ICO ICO ICOICO ICO ICO ICO ICO "
}
