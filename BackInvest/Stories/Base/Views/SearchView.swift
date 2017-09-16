//
//  SearchView.swift
//  DiscountMarket
//
//  Created by Timofey on 5/31/17.
//  Copyright © 2017 Jufy. All rights reserved.
//

import Foundation
import SnapKit
import RxSwift
import RxCocoa

class SearchView: UITableViewHeaderFooterView {

    private var disposeBag = DisposeBag()
    
    private let searchBar = UISearchBar()

    lazy var text: ControlProperty<String?> = self.searchBar.rx.text

    lazy var titlableFilteringStrategy: Observable<TitlableModelFilteringStrategy> = self.searchBar.rx
        .text
        .map{ TitlableModelFilteringStrategy(filteringPredicate: $0) }

    override var frame: CGRect {
        didSet {
            searchBar.layer.cornerRadius = searchBar.bounds.height/2
        }
    }

    private let titleLabel = StandardLabel().with(font: .systemFont(ofSize: 17)).with(text: "DONTREMOVE")

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        backgroundView = UIView().with(backgroundColor: .white)

        searchBar.placeholder = NSLocalizedString("Search", comment: "search view")
        searchBar.textField.backgroundColor = .white
        searchBar.textField.textColor = .lightGray
        searchBar.textField.font = searchBar.textField.font?.withSize(15)
        searchBar.backgroundColor = .white
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = UIColor.LaLaSale.separatorColor.cgColor
        searchBar.setValue(nil, forKey: "_background")
        searchBar.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(6)
            $0.leading.equalToSuperview().offset(25)
        }

        contentView.addSubview(searchBar)
        searchBar.snp.makeConstraints{
            $0.leading.equalTo(titleLabel)
            $0.trailing.equalToSuperview().inset(40)
            $0.top.equalTo(titleLabel.snp.bottom).offset(15)
            $0.bottom.equalToSuperview().inset(6)
            $0.height.equalTo(29)
        }

    }

    func configured(with publishTo: PublishSubject<TitlableModelFilteringStrategy>, title: String) -> SearchView {
        titleLabel.text = title

        titlableFilteringStrategy
            .bind(to: publishTo)
            .disposed(by: disposeBag)
        return self
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

}
