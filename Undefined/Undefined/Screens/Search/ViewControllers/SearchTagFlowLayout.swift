//
//  SearchTagFlowLayout.swift
//  Undefined
//
//  Created by pandora on 2020/09/01.
//  Copyright © 2020 Undefined. All rights reserved.
//

import Foundation

class SearchTagFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else {
            return nil
        }
        var rows = [TagRow]()
        var currentRowY: CGFloat = -1
        
        _ = attributes.map { attribute in
            if currentRowY != attribute.frame.origin.y {
                currentRowY = attribute.frame.origin.y
                rows.append(TagRow())
            }
            rows.last?.add(attribute: attribute)
        }
        
        _ = rows.map { row in
            row.setRowX()
        }
        
        return rows.flatMap { $0.attributes }
    }
}

class TagRow {
    var attributes = [UICollectionViewLayoutAttributes]()
    var spacing: CGFloat = 0

    init(spacing: CGFloat = 4.0) {
        self.spacing = spacing
    }

    func add(attribute: UICollectionViewLayoutAttributes) {
        attributes.append(attribute)
    }

    func setRowX() { // Row의 x 위치 설정
        let collectionViewInset: CGFloat = 18.0
        var offset = spacing
        
        _ = attributes.map { attribute in
            attribute.frame.origin.x = collectionViewInset + CGFloat(offset)
            offset += attribute.frame.width + spacing
        }
    }
}
