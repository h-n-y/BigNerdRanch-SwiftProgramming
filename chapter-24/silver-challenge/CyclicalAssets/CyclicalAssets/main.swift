//
//  main.swift
//  CyclicalAssets
//
//  Created by Hans Yelek on 1/28/16.
//  Copyright © 2016 Hans Yelek. All rights reserved.
//

import Foundation

var bob: Person? = Person(name: "Bob")
print("created \(bob)")

var laptop: Asset? = Asset(name: "Shiny Laptop", value: 1_500.0)
var hat: Asset? = Asset(name: "Cowboy Hat", value: 175.0)
var backpack: Asset? = Asset(name: "Blue Backpack", value: 45.0)

bob?.takeOwnershipOfAsset(laptop!)
bob?.takeOwnershipOfAsset(hat!)


// SILVER CHALLENGE

var jane = Person(name: "Jane")
jane.takeOwnershipOfAsset(laptop!)

print("Bob's assets: \(bob?.assets)")
print("Jane's assets: \(jane.assets)")
