//
// Created by Timofey on 6/6/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import UIKit

class StandardNavigationController: UINavigationController, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationBar.backgroundColor = .clear
        navigationBar.tintColor = UIColor.BackInvest.mainFontColor
        navigationBar.titleTextAttributes = [
            NSFontAttributeName : UIFont.openFont(ofSize: 17),
            NSForegroundColorAttributeName : UIColor.BackInvest.mainFontColor
        ]

        delegate = self
        self.interactivePopGestureRecognizer?.isEnabled = false
        self.interactivePopGestureRecognizer?.delegate = self
    }
    
    open override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        let backButton = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        viewController.navigationItem.backBarButtonItem = backButton
        super.pushViewController(viewController, animated: animated)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
//        self.interactivePopGestureRecognizer?.isEnabled = self.viewControllers.count > 1
    }

    override var childViewControllerForStatusBarHidden: UIViewController? {
        return viewControllers.last
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

}
