//
// Created by Timofey on 9/16/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation

protocol InvestmentCategory: Titlable {

    var image: ObservableImage { get }

    var characteristic: InvestmentCharacteristic { get }

}