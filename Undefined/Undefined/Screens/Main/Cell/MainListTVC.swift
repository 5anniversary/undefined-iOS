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

    let emojiView = UIView().then {
        $0.layer.borderWidth = 4
        $0.layer.borderColor = UIColor.lightishPurple.cgColor
        $0.layer.cornerRadius = 11
        $0.backgroundColor = .white
    }
    
    let emojiLabel = UILabel().then {
        $0.text = "🍕"
        $0.font = .systemFont(ofSize: 34)
    }
    
    let cellBackgroundView = UIView().then {
        $0.backgroundColor = UIColor(red: 227/255, green: 227/255, blue: 227/255, alpha: 1)
        $0.layer.cornerRadius = 11
    }
    
    let titleLabel = UILabel().then {
        $0.text = "성수동 피자맛집 다로베"
        $0.font = UIFont.systemFont(ofSize: 18, weight: .regular)
    }
    
    let locationLabel = UILabel().then {
        $0.text = "서울 성동구 서울숲길 48 삼호빌딩 1층 다로베"
        $0.font = UIFont.systemFont(ofSize: 10, weight: .regular)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpLayout(){
        contentView.addSubview(cellBackgroundView)
        contentView.addSubview(emojiView)
        contentView.addSubview(emojiLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(locationLabel)
        
        emojiView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top)
            make.leading.equalTo(contentView.snp.leading).offset(18)
            make.width.equalTo(62)
            make.height.equalTo(62)
        }
        
        emojiLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(emojiView.snp.centerX)
            make.centerY.equalTo(emojiView.snp.centerY)
        }

        cellBackgroundView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top)
            make.leading.equalTo(contentView.snp.leading).offset(18)
            make.trailing.equalTo(contentView.snp.trailing).inset(17)
            make.height.equalTo(62)
        }

        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(cellBackgroundView.snp.top).offset(13)
            make.leading.equalTo(emojiView.snp.trailing).offset(8)
        }

        locationLabel.snp.makeConstraints { (make) in
            make.top.equalTo(cellBackgroundView.snp.top).offset(37)
            make.leading.equalTo(emojiView.snp.trailing).offset(8)
        }
    }
}
