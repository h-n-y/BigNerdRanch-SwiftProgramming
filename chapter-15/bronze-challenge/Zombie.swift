import Foundation

class Zombie: Monster {
    
    var walksWithLimp = true
    
    final override func terrorizeTown() {
        
        let decrementAmount = 10
        
        // only terrorize town if population is greater than zero
        if town?.population > 0 {
            
            town?.population < decrementAmount ?    ( town?.population = 0 ) :
                                                    ( town?.changePopulation(-decrementAmount) )
        }

        super.terrorizeTown()
    }
    
    func changeName(name: String, walksWithLimp: Bool) {
        self.name = name
        self.walksWithLimp = walksWithLimp 
    }
}
