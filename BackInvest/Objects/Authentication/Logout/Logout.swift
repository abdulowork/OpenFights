//
// Created by Timofey on 7/18/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import RxSwift

//Use have to subscribe to Logout before using it
protocol Logout {

    func commit()

    //Use completable instead?
    func asObservable() -> Observable<Void>

}
