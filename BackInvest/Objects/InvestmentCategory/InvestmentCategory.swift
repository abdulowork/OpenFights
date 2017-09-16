//
// Created by Timofey on 9/16/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation

protocol InvestmentCategory: Titlable {

    var image: ObservableImage { get }

    var description: DescribableCharacteristic { get }
    var punchCount: CountableCharacteristic { get }
    var fatalityDifficulty: MeasurableCharacteristic { get }
    var fatalityFailRisk: MeasurableCharacteristic { get }

}