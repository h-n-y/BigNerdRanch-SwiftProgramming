//
//
// GOLD CHALLENGE
//
//  - anxiety level increases when mayor is responding to reported violence, which occurs
//      when a mayor's town reports a decrease in population: see related SILVER CHALLENGE
//

import Foundation

struct Mayor {
    
    private var anxietyLevel = 0
    
    mutating func increaseAnxietyLevel() {
        ++anxietyLevel
    }
    
    mutating func respondToReportedViolence() {
        print("I'm deeply saddened to hear about this latest tragedy. I promise that my office is looking into the nature of this rash of violence.")
        
        increaseAnxietyLevel()
    }
}