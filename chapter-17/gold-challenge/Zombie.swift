import Foundation

class Zombie: Monster {
    
    override class var spookyNoise: String {
        return "Brains..."
    }
    
    var walksWithLimp: Bool
    private(set) var isFallingApart: Bool
    
    /*
    GOLD CHALLENGE
    
    - make all initializers failable:
    - the designated initializer must be failable b/c it calls the superclass' designated, failable initializer
    - the convenience initializers must be failable b/c they call the failable designated initializer
    */
    init?(limp: Bool, fallingApart: Bool, town: Town?, monsterName: String) {
        walksWithLimp = limp
        isFallingApart = fallingApart
        super.init(town: town, monsterName: monsterName)
    }
    convenience init?(limp: Bool, fallingApart: Bool) {
        self.init(limp: limp, fallingApart: fallingApart, town: nil, monsterName: "Fred")
        if walksWithLimp {
            print("This zombie has a bad knee.")
        }
    }
    
    convenience required init?(town: Town?, monsterName: String) {
        // call across to this class' designate initializer
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