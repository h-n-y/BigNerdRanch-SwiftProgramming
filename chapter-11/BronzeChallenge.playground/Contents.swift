import Cocoa

let myCities    = Set(["Atlanta", "Chicago", "Jacksonville", "New York", "San Francisco"])
let yourCities  = Set(["Chicago", "San Francisco", "Jacksonville"])

let myCitiesIsASuperSet = myCities.isSupersetOf(yourCities)
print(myCitiesIsASuperSet)
