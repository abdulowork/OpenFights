//
// Created by Timofey on 9/16/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import RxSwift

protocol Balance {

    func fetchInformation() -> Observable<BalanceInfo>

}