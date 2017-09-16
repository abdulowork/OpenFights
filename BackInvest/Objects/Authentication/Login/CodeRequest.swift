//
// Created by Timofey on 7/20/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import RxSwift

//Use have to subscribe to Login before using it
protocol CodeRequest {

    //Use completable instead?
    func asObservable() -> Observable<Void>

}
