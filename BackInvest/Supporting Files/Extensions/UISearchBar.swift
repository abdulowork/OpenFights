//
// Created by Артмеий Шлесберг on 16/06/2017.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import RxSwift

extension UISearchBar {

    var textField: UITextField {
        //FIXME: This force cast can fail! SearchBar doesn't always have a searchField.
        return value(forKey: "_searchField") as! UITextField
    }
    
    var titlableFilteringStrategy: Observable<TitlableModelFilteringStrategy> {
     return self.rx
        .text
        .map{ TitlableModelFilteringStrategy(filteringPredicate: $0) }
    }
}
