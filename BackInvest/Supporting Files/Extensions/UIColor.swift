//
//  UIColor.swift
//  DiscountMarket
//
//  Created by Артмеий Шлесберг on 13/06/2017.
//  Copyright © 2017 Jufy. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    struct BackInvest {
        static var shareButtonTop: UIColor {
            return UIColor(colorLiteralRed: 104 / 255, green: 153 / 255, blue: 244 / 255, alpha: 1)
        }

        static var shareButtonButtom: UIColor {
            return UIColor(colorLiteralRed: 100 / 255, green: 132 / 255, blue: 235 / 255, alpha: 1)
        }

        static var standartGradientTop: UIColor {
            return UIColor(colorLiteralRed: 1, green: 120 / 255, blue: 110 / 255, alpha: 1)
        }

        static var standartGradientBottom: UIColor {
            return UIColor(colorLiteralRed: 1, green: 102 / 255, blue: 140 / 255, alpha: 1)
        }

        static var discountBackgroundSmall: UIColor {
            return UIColor(colorLiteralRed: 97 / 255, green: 184 / 255, blue: 126 / 255, alpha: 1)
        }

        static var discountBackgroundMiddle: UIColor {
            return UIColor(colorLiteralRed: 237 / 255, green: 195 / 255, blue: 36 / 255, alpha: 1)
        }

        static var discountBackgroundBig: UIColor {
            return UIColor(colorLiteralRed: 223 / 255, green: 75 / 255, blue: 101 / 255, alpha: 1)
        }

        static var mainFontColor: UIColor {
            return UIColor(colorLiteralRed: 58 / 255, green: 58 / 255, blue: 58 / 255, alpha: 1)
        }

        static var mainTintColor: UIColor {
            return UIColor(colorLiteralRed: 75 / 255, green: 45 / 255, blue: 145 / 255, alpha: 1)
        }

        static var separatorColor: UIColor {
            return UIColor(colorLiteralRed: 237 / 255, green: 237 / 255, blue: 237 / 255, alpha: 1)
        }

        static var darkGrey: UIColor {
            return UIColor(colorLiteralRed: 88 / 255, green: 88 / 255, blue: 88 / 255, alpha: 1)
        }

        static var paleGrey: UIColor {
            return UIColor(red: 230.0 / 255.0, green: 233.0 / 255.0, blue: 237.0 / 255.0, alpha: 1.0)
        }

        static var softGreen: UIColor {
            return UIColor(red: 97.0 / 255.0, green: 184.0 / 255.0, blue: 126.0 / 255.0, alpha: 1.0)
        }

        static var macaroniAndCheese: UIColor {
            return UIColor(red: 237.0 / 255.0, green: 195.0 / 255.0, blue: 36.0 / 255.0, alpha: 1.0)
        }

        static var darkishPink: UIColor {
            return UIColor(red: 223.0 / 255.0, green: 75.0 / 255.0, blue: 101.0 / 255.0, alpha: 1.0)
        }
    }
}


extension UIColor {

    static var darkRed: UIColor {

        return UIColor(red: 186.0/255.0, green: 84.0/255.0, blue: 81.0/255.0, alpha: 1)
    }

    static var theLightestGray: UIColor {
        return UIColor(red: 200.0/255.0, green: 199.0/255.0, blue: 204.0/255.0, alpha: 1.0)
    }

    static var lightRedStub: UIColor {
        return UIColor(red: 253.0/255.0, green: 111.0/255.0, blue: 106.0/255.0, alpha: 1.0)
    }
}
