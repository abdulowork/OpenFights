//
// Created by Timofey on 8/24/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import RxSwift

class LogoutConfirmationController: UIAlertController {

    private let disposeBag = DisposeBag()
    private let logout: Logout
    //FIXME: It's not possible to change presentation style when subclassing UIAlertController. Switch to composition if alert style will be needed
    init(logout: Logout) {
        self.logout = logout
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = NSLocalizedString(
            "LogoutConfirmationTitle",
            comment: "Title for logout confirmation"
        )

        message = NSLocalizedString(
            "LogoutConfirmationMessage",
            comment: "Message for logout confirmation"
        )

        self.addAction(
            UIAlertAction(
                title: NSLocalizedString(
                    "Cancel",
                    comment: "input tool bar"
                ),
                style: .cancel,
                handler: { [unowned self] _ in
                    self.dismiss(animated: true)
                }
            )
        )

        self.addAction(
            UIAlertAction(
                title: NSLocalizedString(
                    "LogoutButtonTitle",
                    comment: "Title for button on logout confirmation screen"
                ),
                style: .default,
                handler: { [unowned self] _ in
                    self.logout.commit()
                }
            )
        )

    }

}
