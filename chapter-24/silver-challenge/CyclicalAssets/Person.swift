//
//  Person.swift
//  CyclicalAssets
//
//  Created by Hans Yelek on 1/28/16.
//  Copyright © 2016 Hans Yelek. All rights reserved.
//

import Foundation

class Person: CustomStringConvertible {
    let name: String
    let accountant = Accountant()
    var assets = [Asset]()
    
    var description: String {
        return "Person(\(name))"
    }
    
    init(name: String) {
        self.name = name
        
        accountant.netWorthChangedHandler = {
            [weak self]( netWorth ) in
            
            self?.netWorthDidChange(netWorth)
            return 
        }
    }
    
    deinit {
        print("\(self) is being deallocated")
    }
    
    func takeOwnershipOfAsset(asset: Asset) {
        
        // SILVER CHALLENGE
        //
        // prevent asset from being assigned to a second owner if
        // it is already owned
        guard asset.owner == nil else {
            print("Cannot take ownership - asset is already owned!")
            return 
        }
        asset.owner = self
        assets.append(asset)
        
        accountant.gainedNewAsset(asset)
    }
    
    func netWorthDidChange(netWorth: Double) {
        print("The net worth of \(self) is now \(netWorth)")
    }
}
