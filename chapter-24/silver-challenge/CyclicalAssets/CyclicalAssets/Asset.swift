//
//  Asset.swift
//  CyclicalAssets
//
//  Created by Hans Yelek on 1/28/16.
//  Copyright © 2016 Hans Yelek. All rights reserved.
//

import Foundation

class Asset: CustomStringConvertible {
    let name: String
    let value: Double
    weak var owner: Person?
    
    var description: String {
        if let actualOwner = owner {
            return "Asset(\(name) worth \(value), owned by \(actualOwner)"
        } else {
            return "Asset(\(name), worth \(value), not owned by anyone)"
        }
    }
    
    init(name: String, value: Double) {
        self.name = name
        self.value = value
    }
    
    deinit {
        print("\(self) is being deallocated")
    }
}