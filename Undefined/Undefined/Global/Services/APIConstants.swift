//
//  APIConstants.swift
//  Undefined
//
//  Created by 오준현 on 2020/08/04.
//  Copyright © 2020 Undefined. All rights reserved.
//

import Foundation

struct APIConstants {
    
    static var BaseURL: String {
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist") {
            let dictRoot = NSDictionary(contentsOfFile: path)
            if let dict = dictRoot {
                return dict["API_URL"] as? String ?? ""
            }
            return dictRoot?["API_URL"] as? String ?? ""
        }
        return ""
    }
    
}
