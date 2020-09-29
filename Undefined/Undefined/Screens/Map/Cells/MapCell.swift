//
//  MapCell.swift
//  Undefined
//
//  Created by 오준현 on 2020/08/04.
//  Copyright © 2020 Undefined. All rights reserved.
//

import UIKit

class MapCell: UITableViewCell {

    static let identifier = "MapCell"
        
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
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }
    
    let likeButton = UIButton().then {
        $0.setImage(UIImage(named: "bookmark"), for: .normal)
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
        contentView.addSubview(titleLabel)
        contentView.addSubview(locationLabel)
        contentView.addSubview(likeButton)

        cellBackgroundView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top)
            make.leading.equalTo(contentView.snp.leading).offset(18)
            make.trailing.equalTo(contentView.snp.trailing).inset(18)
            make.height.equalTo(80)
        }

        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(cellBackgroundView.snp.top).offset(16)
            make.leading.equalTo(cellBackgroundView.snp.leading).offset(15)
        }

        locationLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalTo(cellBackgroundView.snp.leading).offset(15)
        }
        
        likeButton.snp.makeConstraints { (make) in
            make.top.equalTo(cellBackgroundView.snp.top).offset(10)
            make.trailing.equalTo(cellBackgroundView.snp.trailing).offset(-10)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
    }

}

