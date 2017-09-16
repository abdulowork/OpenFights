//
// Created by Timofey on 8/3/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import UIKit

extension UIWindow {

    func transition(to viewController: UIViewController) {
        let snapShot = UIScreen.main.snapshotView(afterScreenUpdates: false)
        viewController.view.addSubview(snapShot)
        self.rootViewController = viewController
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: .transitionCrossDissolve,
            animations: { snapShot.alpha = 0},
            completion: { _ in
                snapShot.removeFromSuperview()
            }
        )
        self.rootViewController = viewController
    }

}
