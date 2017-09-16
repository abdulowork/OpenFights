//
// Created by Артмеий Шлесберг on 16/06/2017.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation

extension Int {

    var rowPath: IndexPath {
        return IndexPath(row: self, section: 0)
    }

    func rowPath(for section: Int) -> IndexPath {
        return IndexPath(row: self, section: section)
    }

    var itemPath: IndexPath {
        return IndexPath(item: self, section: 0)
    }

    func itemPath(for section: Int) -> IndexPath {
        return IndexPath(item: self, section: section)
    }
}