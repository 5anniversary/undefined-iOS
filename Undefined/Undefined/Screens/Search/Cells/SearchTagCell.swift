//
//  SearchCell.swift
//  Undefined
//
//  Created by 오준현 on 2020/08/04.
//  Copyright © 2020 Undefined. All rights reserved.
//

import UIKit
import SnapKit

class SearchTagCell: UICollectionViewCell {
    var viewModel: SearchTagCellViewModel?
    var nameLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.center.equalTo(self.contentView)
        }
        
        setUI()
    }
    
    func setUI() {
        self.backgroundColor = UIColor(red: 224.0/255.0,
                                       green: 224.0/255.0,
                                       blue: 224.0/255.0,
                                       alpha: 1.0)
        self.layer.cornerRadius = 20
        
        self.nameLabel.font = .systemFont(ofSize: 13)
        self.nameLabel.textColor = UIColor(red: 45.0/255.0,
                                           green: 45.0/255.0,
                                           blue: 45.0/255.0,
                                           alpha: 1.0)
    }
    
    func setData(viewModel: SearchTagCellViewModel) {
        guard let unwrappedName = viewModel.name else { return }
        self.nameLabel.text = "#" + unwrappedName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
