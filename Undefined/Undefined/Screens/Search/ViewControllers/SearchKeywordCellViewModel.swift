//
//  SearchTagCellViewModel.swift
//  Undefined
//
//  Created by pandora on 2020/08/31.
//  Copyright © 2020 Undefined. All rights reserved.
//

import Foundation

struct SearchKeywordModel {
    var keyword: String?
}

struct SearchKeywordCellViewModel {
    var keyword: String?
    
    init(model: SearchKeywordModel) {
        self.keyword = model.keyword
    }
    
}
