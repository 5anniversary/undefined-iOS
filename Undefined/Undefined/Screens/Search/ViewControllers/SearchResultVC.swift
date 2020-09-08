//
//  SearchResultVC.swift
//  Undefined
//
//  Created by pandora on 2020/09/02.
//  Copyright © 2020 Undefined. All rights reserved.
//

import UIKit
import RxCocoa

class SearchResultVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton(frame: CGRect(x: 30, y: 30, width: 30, height: 30))
        button.setTitle("<", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        button.rx.tap.bind {
            self.navigationController?.popViewController(animated: true)
        }
        
        self.view.addSubview(button)
        self.view.backgroundColor = .brown
    }
    
}
