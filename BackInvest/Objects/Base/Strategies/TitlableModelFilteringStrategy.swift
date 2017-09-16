//
// Created by Timofey on 6/16/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct TitlableModelFilteringStrategy {

    fileprivate let filteringPredicate: String
    init(filteringPredicate: String?) {
        self.filteringPredicate = filteringPredicate ?? ""
    }

    func shouldInclude(item: Titlable) -> Bool {
        return filteringPredicate.isEmpty ? true : item.title.localizedCaseInsensitiveContains(filteringPredicate)
    }

    func equals(to another: TitlableModelFilteringStrategy) -> Bool {
        return filteringPredicate == another.filteringPredicate
    }

}
