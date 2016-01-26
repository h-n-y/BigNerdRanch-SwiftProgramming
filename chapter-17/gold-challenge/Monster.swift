import Foundation

class Monster {
    static let isTerrifying = true
    class var spookyNoise: String {
        return "Grrr"
    }
    
    var town: Town?
    var name: String!   // implicitly unwrapped optional
    var victimPool: Int {
        get {
            return town?.population ?? 0
        }
        set(newVictimPool) {
            town?.population = newVictimPool
        }
    }
    
    /*
    GOLD CHALLENGE
    
    - make the designated initializer failable
    - make self.name an implicitly unwrapped optional
    - if initialization should fail (i.e. monsterName is an empty string), set the two stored properties ( town and name ) to nil
    before returning nil
    */
    required init?(town: Town?, monsterName: String) {
        if monsterName.isEmpty {
            self.town = nil
            self.name = nil
            return nil
        }
        self.town = town
        name = monsterName
    }
    
    func terrorizeTown() {
        if town != nil {
            print("\(name) is terrorizing a town!")
        } else {
            print("\(name) hasn't found a town to terrorize yet...")
        }
    }
}