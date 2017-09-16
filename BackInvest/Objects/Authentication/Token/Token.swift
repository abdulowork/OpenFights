//
// Created by Timofey on 6/30/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import RxSwift

protocol Token {

    var value: String { get }

    func asObservable() -> Observable<Token>

}