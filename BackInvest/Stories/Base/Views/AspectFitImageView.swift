//
// Created by Timofey on 9/4/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

class AspectFitImageView: UIImageView {

    private let heightConstraintPriority: Int
    init(heightConstraintPriority: Int = 500) {
        self.heightConstraintPriority = heightConstraintPriority
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFill
        snp.makeConstraints {
            $0.height.equalTo(0).priority(heightConstraintPriority)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        guard let image = self.image else { return }
        snp.updateConstraints {
            $0.height.equalTo(
                AspectFitSide(
                    image: image,
                    width: frame.width
                ).side
            ).priority(heightConstraintPriority)
        }
    }

}

struct AspectFitSide {

    let side: CGFloat

    init(image: UIImage, width: CGFloat) {
        let height = AVMakeRect(
            aspectRatio: image.size,
            insideRect: CGRect(
                origin: .zero,
                size: CGSize(
                    width: width,
                    height: .greatestFiniteMagnitude
                )
            )
        ).height

        guard !height.isNaN else { side = 0; return }
        side = height
    }

    init(image: UIImage, height: CGFloat) {
        let width = AVMakeRect(
            aspectRatio: image.size,
            insideRect: CGRect(
                origin: .zero,
                size: CGSize(
                    width: .greatestFiniteMagnitude,
                    height: height
                )
            )
        ).width

        guard !width.isNaN else { side = 0; return }
        side = width
    }

}
