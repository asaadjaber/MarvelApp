//
//  UIButtonTappable.swift
//  MarvelApp
//
//  Created by Asaad Jaber on 3/15/21.
//

import UIKit

class UIButtonTappable: UIButton {
    let minTappableArea = 44 as CGFloat
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let extendedBounds = bounds.insetBy(dx: -(minTappableArea - self.bounds.width), dy: -(minTappableArea - self.bounds.height))
        return extendedBounds.contains(point)
    }
}
