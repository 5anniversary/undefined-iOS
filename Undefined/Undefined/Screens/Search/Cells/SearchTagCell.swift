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
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        setUI()
    }
    
    func setUI() {
        self.nameLabel.textColor = .white
    }
    
    func setData(viewModel: SearchTagCellViewModel) {
        guard let unwrappedName = viewModel.name else { return }
        self.nameLabel.text = "#" + unwrappedName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
