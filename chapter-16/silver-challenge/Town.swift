import Foundation

struct Town {
    
    static let region = "South"
    var population = 5422 {
        didSet(oldPopulation) {
            if population < oldPopulation {
                print("The population has changed to \(population) from \(oldPopulation).")
                
                //  SILVER CHALLENGE
                //
                //  - mayor's obligatory response to decreased population
                //
                mayor.respondToReportedViolence()
            }
            
        }
    }
    var numberOfStoplights = 4
    
    enum Size {
        case Small
        case Medium
        case Large
    }
    
    var townSize: Size {
        get {
            switch self.population {
            case 0...10_000:
                return Size.Small
                
            case 10_001...100_000:
                return Size.Medium
                
            default:
                return Size.Large
            }
        }
    }
    
    var mayor: Mayor = Mayor()
    
    
    func printTownDescription() {
        print("Population: \(population); number of stoplights: \(numberOfStoplights)")
    }
    
    mutating func changePopulation(amount: Int) {
        population += amount
    }
}
