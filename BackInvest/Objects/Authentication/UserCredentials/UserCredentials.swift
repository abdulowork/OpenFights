//
// Created by Timofey on 7/18/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import RxSwift

protocol UserCredentials {

    var phone: Phone { get }
    var code: String { get }

    func asObservable() -> Observable<UserCredentials>

}
