//
// Created by Timofey on 9/16/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import RxSwift
import Moya

class Provider<Target: TargetType>: RxMoyaProvider<Target> {

    public override init(
        endpointClosure: @escaping EndpointClosure = MoyaProvider.defaultEndpointMapping,
        requestClosure: @escaping RequestClosure = MoyaProvider.defaultRequestMapping,
        stubClosure: @escaping StubClosure = MoyaProvider.neverStub,
        manager: Manager = RxMoyaProvider<Target>.defaultAlamofireManager(),
        plugins: [PluginType] = [],
        trackInflights: Bool = false
    ) {
        super.init(
            endpointClosure: { target in
                let endpoint = endpointClosure(target)
                return endpoint.adding(
                    newHTTPHeaderFields: [
                        "Accept" : "application/json"
                    ]
                )
            },
            requestClosure: requestClosure,
            stubClosure: stubClosure,
            manager: manager,
            plugins: plugins,
            trackInflights: trackInflights
        )
    }

}
