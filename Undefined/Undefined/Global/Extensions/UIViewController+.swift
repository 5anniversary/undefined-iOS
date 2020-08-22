//
//  Extension.swift
//  Undefined
//
//  Created by 오준현 on 2020/08/04.
//  Copyright © 2020 Undefined. All rights reserved.
//

import UIKit

extension UIViewController {
    func gz_addChild(_ child: UIViewController, in containerView: UIView, edges: UIRectEdge = .all) {
        guard containerView.isDescendant(of: view) else { return }
        addChild(child)
        containerView.addSubview(child.view)
        child.view.gz_pinToSuperview(edges: edges)
        child.didMove(toParent: self)
    }
}
