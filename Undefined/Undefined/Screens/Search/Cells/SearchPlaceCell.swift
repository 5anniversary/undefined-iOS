//
//  SearchPlaceCell.swift
//  Undefined
//
//  Created by summer on 2020/09/24.
//  Copyright © 2020 Undefined. All rights reserved.
//

import SnapKit
import UIKit


class SearchPlaceCell: UICollectionViewCell {
    var titleLabel: UILabel = UILabel()
    var addressLabel: UILabel = UILabel()
    var bookmarkButton: UIButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(titleLabel)
        self.addSubview(addressLabel)
        self.addSubview(bookmarkButton)
        
        configureUI()
        configureConstraints()
    }
    
    func configureUI() {
        self.layer.cornerRadius = 12.0
        self.backgroundColor = UIColor(red: 234.0/255.0,
                                       green: 234.0/255.0,
                                       blue: 234.0/255.0,
                                       alpha: 1.0)
        self.titleLabel.font = .systemFont(ofSize: 18.0)
        self.addressLabel.font = .systemFont(ofSize: 14.0)
        self.bookmarkButton.backgroundColor = .purple
    }
    
    func setData(viewModel: SearchPlaceCellViewModel) {
        self.titleLabel.text = viewModel.title
        self.addressLabel.text = viewModel.address
    }
    
    func configureConstraints() {
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16.0)
            make.leading.equalToSuperview().offset(15.0)
            make.height.equalTo(18.0)
        }
        
        self.addressLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(titleLabel.snp.leading)
            make.top.equalTo(titleLabel.snp.bottom).offset(5.0)
            make.height.equalTo(18.0)
        }
        
        self.bookmarkButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(11.0)
            make.trailing.equalToSuperview().offset(-11.0)
            make.width.equalTo(20.0)
            make.height.equalTo(22.0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
