//
//  SearchViewModel.swift
//  Undefined
//
//  Created by pandora on 2020/08/31.
//  Copyright © 2020 Undefined. All rights reserved.
//

import Foundation

struct SearchViewModel {
    var tagViewModels: [SearchKeywordCellViewModel] = [SearchKeywordCellViewModel]()
    var recentKeywordViewModels: [SearchKeywordCellViewModel] = [SearchKeywordCellViewModel]()
    
    mutating func setDummyData() {
        let keywords: [String] = ["성수맛집","성수카페","성수동 치킨","성수","성수동 핫플","성수동 카페거리","성수술집"]
        
        tagViewModels = keywords.map { (keyword) -> SearchKeywordCellViewModel in
            let model = SearchKeywordModel(keyword: keyword)
            return SearchKeywordCellViewModel(model: model)
        }
    }
    
    init() {
        setDummyData()
    }
    
}
