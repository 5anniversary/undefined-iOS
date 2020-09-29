//
//  MainListTVC.swift
//  Undefined
//
//  Created by 오준현 on 2020/09/03.
//  Copyright © 2020 Undefined. All rights reserved.
//

import UIKit

class MainListTVC: UITableViewCell {

    static let identifier = "mainListTableCell"

    // MARK: - UI Components
    
    let emojiLabel = UILabel().then {
        $0.text = "🍕"
        $0.font = .systemFont(ofSize: 40)
    }
    
    let cellBackgroundView = UIView().then {
        $0.backgroundColor = UIColor(red: 227/255, green: 227/255, blue: 227/255, alpha: 1)
        $0.layer.cornerRadius = 11
    }
    
    let titleLabel = UILabel().then {
        $0.text = "죽다가도 모를 피자가게 모음"
        $0.font = UIFont.systemFont(ofSize: 18, weight: .regular)
    }
    
    let locationLabel = UILabel().then {
        $0.text = "#도미노피자보다 맛있는 #성수피자 #한번만 먹어보세요"
        $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
    }
    
    let likeButton = UIButton().then {
        $0.setImage(UIImage(named: "bookmark"), for: .normal)
    }
    
    // MARK: - Variables and Properties
    
    var rootVC: UIViewController?
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    
    
}

// MARK: - Helper

extension MainListTVC {
    
    func setUpLayout(){
        contentView.addSubview(cellBackgroundView)
        contentView.addSubview(emojiLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(locationLabel)
        contentView.addSubview(likeButton)

        cellBackgroundView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top)
            make.leading.equalTo(contentView.snp.leading).offset(21)
            make.trailing.equalTo(contentView.snp.trailing).inset(21)
            make.height.equalTo(130)
        }

        emojiLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(cellBackgroundView.snp.centerX)
            make.top.equalTo(cellBackgroundView.snp.top).offset(14)
        }

        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(cellBackgroundView.snp.top).offset(71)
            make.centerX.equalTo(cellBackgroundView.snp.centerX)
        }

        locationLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.centerX.equalTo(cellBackgroundView.snp.centerX)
        }
        
        likeButton.snp.makeConstraints { (make) in
            make.top.equalTo(cellBackgroundView.snp.top).offset(10)
            make.trailing.equalTo(cellBackgroundView.snp.trailing).offset(-10)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
    }

}
