import Foundation

struct Town {
    
    static let region = "South"
    var population = 5422 {
        didSet(oldPopulation) {
            
            // BRONZE CHALLENGE
            //
            //  - only print population change if population is less than old population
            //
            if population < oldPopulation {
                print("The population has changed to \(population) from \(oldPopulation).")
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
    
    
    func printTownDescription() {
        print("Population: \(population); number of stoplights: \(numberOfStoplights)")
    }
    
    mutating func changePopulation(amount: Int) {
        population += amount
    }
}