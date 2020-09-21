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
    
    let profileImageView = UIImageView()
    
    let profileImageButton = UIButton()
    
    let profileBackgroundButton = UIButton()

    let userView = UIView()
    
    let usernameLabel = UILabel()
    
    let userGuideLabel = UILabel()
        
    let userSettingButton = UIButton()
    
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
}
