//
// Created by Артмеий Шлесберг on 16/09/2017.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import RxSwift

struct FakeInvestmentCategories: InvestmentCategories {
    func fetch() -> Observable<[InvestmentCategory]> {
        return Observable.just([FakeICOInvestmentCategory(),
                                FakeICOInvestmentCategory(),
                                FakeICOInvestmentCategory(),
                                FakeICOInvestmentCategory()])
    }
}

struct FakeICOInvestmentCategory: InvestmentCategory {
    private(set) var description: DescribableCharacteristic = FakeICODescriptionCharacteristic()
    private(set) var title: String = "ICO Investment"
    private(set) var punchCount: CountableCharacteristic = FakeICOPunchCountCharacteristic()
    private(set) var fatalityDifficulty: MeasurableCharacteristic = FakeICOFatalityDifficultyCharacteristic()
    private(set) var fatalityFailRisk: MeasurableCharacteristic = FakeICOFatalityFailRiskCharacteristic()
    private(set) var image: ObservableImage = FakeImage()
}

struct FakeImage : ObservableImage {
    var image: Observable<UIImage> {
        return  Observable.just(#imageLiteral(resourceName: "cat"))
    }
}

struct FakeICODescriptionCharacteristic: DescribableCharacteristic {
    private(set) var description: String = "ISO ISO ISO ISO ISO ISO ISO ISO ISO ISO ISO ISO v ISO ISOмv v v v ISO ISOISO ISO "
    private(set) var title: String = "Описание"
    private(set) var information: UIView = UIView()
}

struct FakeICOPunchCountCharacteristic: CountableCharacteristic {
    private(set) var title: String = "Количество ударов"
    private(set) var count: Int = 90
    private(set) var information: UIView = UIView()
}

struct FakeICOFatalityDifficultyCharacteristic : MeasurableCharacteristic {
    var title: String = "Сложность фаталити"
    private(set) var range: Double = 100
    private(set) var value: Double = 30
    private(set) var information: UIView = UIView()
}

struct FakeICOFatalityFailRiskCharacteristic: MeasurableCharacteristic {
    var title: String = "Риск провалить фаталити"
    private(set) var range: Double = 100
    private(set) var value: Double = 17
    private(set) var information: UIView = UIView()
}

