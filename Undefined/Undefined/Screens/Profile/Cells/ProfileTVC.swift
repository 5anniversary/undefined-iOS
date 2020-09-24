//
//  ProfileTVC.swift
//  Undefined
//
//  Created by 오준현 on 2020/09/21.
//  Copyright © 2020 Undefined. All rights reserved.
//

import UIKit

class ProfileTVC: UITableViewCell {

    static let identifier = "profileCell"
    
    let label = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 15, weight: .light)
    }
    
    func layout() {
        contentView.addSubview(label)
        
        label.snp.makeConstraints { (make) in
            make.leading.equalTo(contentView.snp.leading).offset(28)
            make.centerY.equalTo(contentView.snp.centerY)
        }
    }
    
}
