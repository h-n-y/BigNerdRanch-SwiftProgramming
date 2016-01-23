import Foundation

class Vampire: Monster {
    
    var vampireThralls = [Vampire]()
    override func terrorizeTown() {
        
        if town?.population > 0 {
            
            // decrement town population and create a new vampire thrall
            town?.changePopulation(-1)
            
            vampireThralls.append(Vampire())
        }
    }
}