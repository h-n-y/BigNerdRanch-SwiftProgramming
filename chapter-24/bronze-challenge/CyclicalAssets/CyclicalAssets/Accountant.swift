//
//  Accountant.swift
//  CyclicalAssets
//
//  Created by Hans Yelek on 1/28/16.
//  Copyright © 2016 Hans Yelek. All rights reserved.
//

import Foundation

class Accountant {
    typealias NetWorthChanged = (Double) -> ()
    
    var netWorthChangedHandler: NetWorthChanged? = nil
    var netWorth: Double = 0.0 {
        didSet {
            netWorthChangedHandler?(netWorth)
        }
    }
    
    func gainedNewAsset(asset: Asset) {
        netWorth += asset.value
    }
    
    // BRONZE CHALLENGE
    func lostAsset(asset: Asset) {
        netWorth -= asset.value
    }
}