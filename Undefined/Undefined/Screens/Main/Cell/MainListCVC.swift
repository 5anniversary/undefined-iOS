//
//  MainListCVC.swift
//  Undefined
//
//  Created by 오준현 on 2020/09/03.
//  Copyright © 2020 Undefined. All rights reserved.
//

import UIKit

class MainListCVC: UICollectionViewCell {
    static let identifier = "mainListCollectionCell"
    
    let userImageView = UIImageView().then {
        $0.backgroundColor = UIColor(red: 227/255,
                                     green: 227/255,
                                     blue: 227/255,
                                     alpha: 1)
        $0.layer.cornerRadius = 33
    }
    
    let nameLabel = UILabel().then {
        $0.text = "윤우식"
        $0.font = Font.regular.of(size: 12)
    }
    
    func setUpLayout(){
        contentView.addSubview(userImageView)
        contentView.addSubview(nameLabel)
        
        userImageView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top)
            make.leading.equalTo(contentView.snp.leading)
            make.width.equalTo(66)
            make.height.equalTo(64)
        }

        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(userImageView.snp.bottom).offset(7)
            make.centerX.equalTo(userImageView.snp.centerX)
        }

    }


}
