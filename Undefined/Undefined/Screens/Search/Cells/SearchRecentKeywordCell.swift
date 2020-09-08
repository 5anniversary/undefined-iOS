//
//  SearchRecentKeywordCell.swift
//  Undefined
//
//  Created by summer on 2020/09/08.
//  Copyright © 2020 Undefined. All rights reserved.
//

import UIKit
import SnapKit

class SearchRecentKeywordCell: UICollectionViewCell {
    var viewModel: SearchKeywordCellViewModel?
    var nameLabel: UILabel = UILabel()
    var divideLine: UIView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(nameLabel)
        self.addSubview(divideLine)
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        divideLine.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(1.0)
        }
        
        setUI()
    }
    
    func setUI() {
        self.backgroundColor = .white
        self.nameLabel.font = .systemFont(ofSize: 13)
        self.nameLabel.textColor = UIColor(red: 45.0/255.0,
                                           green: 45.0/255.0,
                                           blue: 45.0/255.0,
                                           alpha: 1.0)
        self.divideLine.backgroundColor = UIColor(red: 216.0/255.0,
                                                  green: 216.0/255.0,
                                                  blue: 216.0/255.0,
                                                  alpha: 1.0)
    }
    
    func setData(viewModel: SearchKeywordCellViewModel) {
        guard let unwrappedName = viewModel.keyword else { return }
        self.nameLabel.text = unwrappedName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
