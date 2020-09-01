//
//  SearchSectionHeader.swift
//  Undefined
//
//  Created by pandora on 2020/09/01.
//  Copyright © 2020 Undefined. All rights reserved.
//

import UIKit

class SearchSectionHeader: UICollectionReusableView {
    var headerTitle: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(headerTitle)
        
        headerTitle.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        setUI()
    }
    
    private func setUI() {
        headerTitle.font = UIFont.boldSystemFont(ofSize: 18.0)
        headerTitle.textColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
