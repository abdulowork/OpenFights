//
// Created by Timofey on 6/30/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import RxSwift
import Moya

protocol Authority {

    var authenticationPlugin: PluginType { get }

    var logout: Logout { get }

    func asObservable() -> Observable<Authority>

    //TODO: Make authority return its logout object

}
