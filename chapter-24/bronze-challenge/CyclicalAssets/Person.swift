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
        asset.owner = self
        assets.append(asset)
        
        accountant.gainedNewAsset(asset)
    }
    
    // BRONZE CHALLENGE
    //
    func releaseOwnershipOfAsset(asset: Asset) {
        if let indexOfAsset = ( assets.indexOf { $0 === asset } ) {
            
            assets.removeAtIndex(indexOfAsset)
            accountant.lostAsset(asset)
        }
    }
    
    func netWorthDidChange(netWorth: Double) {
        print("The net worth of \(self) is now \(netWorth)")
    }
}
