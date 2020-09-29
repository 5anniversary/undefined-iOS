//
//  ProfileView.swift
//  Undefined
//
//  Created by 오준현 on 2020/09/21.
//  Copyright © 2020 Undefined. All rights reserved.
//

import UIKit

class ProfileView: UIView {
    let profileBackgroundImageView = UIImageView().then {
        $0.backgroundColor = .paleLavender
    }
    
    let profileImageView = UIImageView().then {
        $0.backgroundColor = .veryLightPink
        $0.layer.cornerRadius = 35
    }
    
    let profileImageButton = UIButton()
    
    let profileBackgroundButton = UIButton()

    let userView = UIView()
    
    let usernameLabel = UILabel()
    
    let userGuideLabel = UILabel()
        
    let userSettingButton = UIButton()
    
    let tableViewGuideLabel = UILabel().then {
        $0.text = "플라츠 리스트"
        $0.font = Font.bold.of(size: 14)
    }
    
    func layout() {
        addSubview(profileBackgroundButton)
        addSubview(profileBackgroundImageView)
        addSubview(profileImageView)
        addSubview(profileImageButton)
        addSubview(userView)
        addSubview(usernameLabel)
        addSubview(userGuideLabel)
        addSubview(userSettingButton)

        profileBackgroundImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(160)
        }
        
        profileImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(profileBackgroundImageView.snp.centerX)
            make.centerY.equalTo(profileBackgroundImageView.snp.centerY)
            make.width.equalTo(70)
            make.height.equalTo(70)
        }

    }
    
    func layoutProfileView() {
        
    }
    
    func layoutListView() {
        addSubview(tableViewGuideLabel)

        tableViewGuideLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(18)
            make.top.equalToSuperview().offset(179)
        }

    }
    
}
