//
//  CALayer+.swift
//  Undefined
//
//  Created by 오준현 on 2020/09/15.
//  Copyright © 2020 Undefined. All rights reserved.
//

import UIKit

extension CALayer {
    func applyShadow(
        color: UIColor = .black,
        alpha: Float = 0.5,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 4
    ) {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
    }
    
}
