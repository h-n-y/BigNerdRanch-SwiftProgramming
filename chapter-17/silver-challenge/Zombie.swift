import Foundation

class Zombie: Monster {
    
    override class var spookyNoise: String {
        return "Brains..."
    }
    
    var walksWithLimp: Bool
    private(set) var isFallingApart: Bool
    
    init(limp: Bool, fallingApart: Bool, town: Town?, monsterName: String) {
        walksWithLimp = limp
        isFallingApart = fallingApart
        super.init(town: town, monsterName: monsterName)
    }
    convenience init(limp: Bool, fallingApart: Bool) {
        self.init(limp: limp, fallingApart: fallingApart, town: nil, monsterName: "Fred")
        if walksWithLimp {
            print("This zombie has a bad knee.")
        }
    }
    
    /*
    **
    **  SILVER CHALLENGE
    **
    */
    convenience required init(town: Town?, monsterName: String) {
        // call across to this class' designated initializer
        self.init(limp: false, fallingApart: false, town: town, monsterName: monsterName)
    }
    
    
    final override func terrorizeTown() {
        
        let decrementAmount = 10
        
        // only terrorize town if population is greater than zero
        if !isFallingApart && town?.population > 0 {
            
            town?.population < decrementAmount ?    ( town?.population = 0 ) :
                ( town?.changePopulation(-decrementAmount) )
        }
        
        super.terrorizeTown()
    }
    
    func changeName(name: String, walksWithLimp: Bool) {
        self.name = name
        self.walksWithLimp = walksWithLimp
    }
    
    deinit {
        print("Zombie named \(name) is no longer with us.")
    }
}


