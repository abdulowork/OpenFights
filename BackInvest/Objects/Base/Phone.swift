//
//  Phone.swift
//  DiscountMarket
//
//  Created by Артмеий Шлесберг on 02/07/2017.
//  Copyright © 2017 Jufy. All rights reserved.
//

import Foundation

//Make phone nonanemic
protocol Phone {
    var number: String { get }
}

class PhoneFrom: Phone {

    let number: String
    init(number: String) {
        self.number = number
    }

}

struct FakePhone: Phone {
    var number: String {
        return "+7 903 5555555"
    }
}
