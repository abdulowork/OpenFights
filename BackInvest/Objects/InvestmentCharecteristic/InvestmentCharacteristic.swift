//
// Created by Timofey on 9/16/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import UIKit

protocol InvestmentCharacteristic: Titlable {

    var information: UIView { get }

}

protocol MeasurableCharacteristic: InvestmentCharacteristic {

    var range: Double { get }
    var value: Double  { get }

}

protocol CountableCharacteristic: InvestmentCharacteristic {

    var count: Int { get }

}

protocol DescribableCharacteristic: InvestmentCharacteristic {

    var description: String { get }

}