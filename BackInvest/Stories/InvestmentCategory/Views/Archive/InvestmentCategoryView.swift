//
//  InvestmentCategoryView.swift
//  BackInvest
//
//  Created by Timofey on 9/17/17.
//  Copyright © 2017 Jufy. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import SnapKit

class InvestmentCategoryView: UIView {
    
    @IBOutlet weak var punchLabel: UILabel!
    
    @IBOutlet weak var fatalityLabel: UILabel!
    
    @IBOutlet weak var warriorsCount: UILabel!
    
    @IBOutlet weak var punchTempo: UILabel!
    
    let gr = UITapGestureRecognizer()
    
    func addInfoButtons() {
        
        addGestureRecognizer(gr)
        
        let punchInfoButton = InfoButton(info: "Количество ударов - это основной показатеь для первоначально оценки бизнеса. Чем больше ударов, тем больше здоровья теряет противник.", closeOn: gr.rx.event.asObservable().map { _ in })
        let fatalityInfo = InfoButton(info: "Сложность фаталити - важный показатель для инвесторов. С помощью этого показателя можно оценить шансы бизнеса на мега-фаталити. Finish him!", closeOn: gr.rx.event.asObservable().map { _ in })
        let warriorsInfo = InfoButton(info: "Количество бойцов показывает какого размер отряд у бизнеса. Большие отряды позволяют одержать более масшабные победы, но требуют бОльших расходов на содержание", closeOn: gr.rx.event.asObservable().map { _ in })
        let tempoInfo = InfoButton(info: "Темп ударов, более комплекный показатель. Отражает как менялось количестов ударов со временм. На это влияет множество факторов. Начиная от физического состояния бизнеса, до донусов или ослаблений наложенных на него ", closeOn: gr.rx.event.asObservable().map { _ in })
        
        addSubviews([punchInfoButton, fatalityInfo, warriorsInfo, tempoInfo])
        
        let centering = { (label: UIView) in return { (make: ConstraintMaker) in
            make.centerY.equalTo(label.snp.centerY)
            make.trailing.equalToSuperview().inset(20)
            }
        }
        
        punchInfoButton.snp.makeConstraints(centering(punchLabel))
        fatalityInfo.snp.makeConstraints(centering(fatalityLabel))
        warriorsInfo.snp.makeConstraints(centering(warriorsCount))
        tempoInfo.snp.makeConstraints(centering(punchTempo))
        
    }
}
