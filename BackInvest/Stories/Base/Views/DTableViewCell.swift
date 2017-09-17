//
//  DTableViewCell.swift
//  BackInvest
//
//  Created by Timofey on 9/17/17.
//  Copyright © 2017 Jufy. All rights reserved.
//

import UIKit
import RxSwift

class DTableViewCell: UIScrollView {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var contentView: UIView!
    
    private let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addSubview(firstView)
        addSubview(secondView)
        segmentedControl
            .setTitleTextAttributes(
                [NSFontAttributeName : UIFont.openFontMedium(ofSize: 18)],
                for: UIControlState.normal
            )
        segmentedControl.layer.cornerRadius = 11
        segmentedControl.layer.masksToBounds = true
        
        segmentedControl.rx.value
            .subscribe(onNext: { [unowned self] value in
                if value == 0 {
                    self.firstView.isHidden = false
                    self.secondView.isHidden = true
                } else {
                    self.firstView.isHidden = true
                    self.secondView.isHidden = false
                }
            })
            .disposed(by: disposeBag)
    }
    
    private var firstView = UIView()
    private var secondView = UIView()
    func set(firstView: UIView, secondView: UIView) {
        firstView.removeFromSuperview()
        secondView.removeFromSuperview()
        self.firstView = firstView
        self.secondView = secondView
        contentView.addSubview(secondView)
        secondView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        contentView.addSubview(firstView)
        firstView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    
    
}
