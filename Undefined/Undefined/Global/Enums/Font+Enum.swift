//
//  Font+Enum.swift
//  Undefined
//
//  Created by 오준현 on 2020/09/28.
//  Copyright © 2020 Undefined. All rights reserved.
//

import UIKit

enum Font: String {
    
    case regular = "SpoqaHanSans-Regular"
    case bold = "SpoqaHanSans-Bold"
    case light = "SpoqaHanSans-Light"
    case thin = "SpoqaHanSans-Thin"
     
    func of(size: CGFloat) -> UIFont {
      return UIFont(name: self.rawValue, size: size)!
    }
}
