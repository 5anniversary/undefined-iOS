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
        cellViewModels.append(SearchTagCellViewModel(model: SearchTagModel(name: "가동맛집")))
        cellViewModels.append(SearchTagCellViewModel(model: SearchTagModel(name: "나동맛집")))
        cellViewModels.append(SearchTagCellViewModel(model: SearchTagModel(name: "다동맛집")))
        cellViewModels.append(SearchTagCellViewModel(model: SearchTagModel(name: "라동맛집")))
        cellViewModels.append(SearchTagCellViewModel(model: SearchTagModel(name: "마동맛집")))
    }
    
    init() {
        setDummyData()
    }
    
}
