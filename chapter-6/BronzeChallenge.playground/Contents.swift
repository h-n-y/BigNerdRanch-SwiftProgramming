import Cocoa

for i in 1...5 {                                    // execute inner loop five times
    
    for case let i in 0...100 where i % 2 == 0 {    // count by two from zero to one hundred
        print(i)
    }
}
