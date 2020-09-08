//
//  SearchViewModel.swift
//  Undefined
//
//  Created by pandora on 2020/08/31.
//  Copyright © 2020 Undefined. All rights reserved.
//

import Foundation

struct SearchViewModel {
    var cellViewModels: [SearchTagCellViewModel] = [SearchTagCellViewModel]()
    
    mutating func setDummyData() {
        cellViewModels.append(SearchTagCellViewModel(model: SearchTagModel(name: "성수맛집맛집맛집맛집맛집맛집맛집맛집맛집맛집맛집맛집")))
        cellViewModels.append(SearchTagCellViewModel(model: SearchTagModel(name: "성수카페")))
        cellViewModels.append(SearchTagCellViewModel(model: SearchTagModel(name: "성수동 치킨")))
        cellViewModels.append(SearchTagCellViewModel(model: SearchTagModel(name: "성수")))
        cellViewModels.append(SearchTagCellViewModel(model: SearchTagModel(name: "성수동 핫플")))
        cellViewModels.append(SearchTagCellViewModel(model: SearchTagModel(name: "성수동 카페거리")))
        cellViewModels.append(SearchTagCellViewModel(model: SearchTagModel(name: "성수술집")))
    }
    
    init() {
        setDummyData()
    }
    
}
