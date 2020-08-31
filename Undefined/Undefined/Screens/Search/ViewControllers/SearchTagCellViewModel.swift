//
//  SearchTagCellViewModel.swift
//  Undefined
//
//  Created by pandora on 2020/08/31.
//  Copyright © 2020 Undefined. All rights reserved.
//

import Foundation

struct SearchTagModel {
    var name: String?
}

struct SearchTagCellViewModel {
    var name: String?
    
    init(model: SearchTagModel) {
        self.name = model.name
    }
    
}
