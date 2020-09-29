//
//  Extension.swift
//  Undefined
//
//  Created by 오준현 on 2020/08/04.
//  Copyright © 2020 Undefined. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func gz_addChild(_ child: UIViewController,
                     in containerView: UIView,
                     edges: UIRectEdge = .all) {
        
        guard containerView.isDescendant(of: view) else { return }
        addChild(child)
        containerView.addSubview(child.view)
        child.view.gz_pinToSuperview(edges: edges)
        child.didMove(toParent: self)
        
    }
    
    func showToast(_ message: String,
                   _ yAnchor: CGFloat,
                   _ textColor: UIColor,
                   _ textFont: UIFont,
                   _ backgroundColor: UIColor,
                   _ backgroundRadius: CGFloat,
                   _ duration: TimeInterval) {
                   
        let label = UILabel()
        let backgroundView = UIView()
        
        backgroundView.backgroundColor = backgroundColor.withAlphaComponent(0.6)
        backgroundView.layer.cornerRadius = backgroundRadius;
        label.textColor = textColor
        label.textAlignment = .center;
        label.font = textFont
        label.text = message
        label.alpha = 1.0
        label.clipsToBounds  =  true

        self.view.addSubview(backgroundView)
        self.view.addSubview(label)

        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,
                                        constant: -yAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.topAnchor.constraint(equalTo: label.topAnchor).isActive = true
        backgroundView.leadingAnchor.constraint(equalTo: label.leadingAnchor,
                                                constant: -20).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: label.trailingAnchor,
                                                 constant: 20).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: label.bottomAnchor).isActive = true

        UIView.animate(withDuration: duration, delay: 0.1, options: .curveEaseOut, animations: {
            label.alpha = 0.0
            backgroundView.alpha = 0.0
        }, completion: {(isCompleted) in
            label.removeFromSuperview()
            backgroundView.removeFromSuperview()
        })
    }

}
