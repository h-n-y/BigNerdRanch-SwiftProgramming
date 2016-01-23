import Cocoa

let precinctPopulations = [ 1_244, 2_021, 2_157 ]
let projectedPopulations = precinctPopulations.map {
    (population: Int) -> Int in
    return population * 2
}

//  ORIGINAL IMPLEMENTATION

let totalProjection = projectedPopulations.reduce(0) {
    (accumulatedProjection: Int, precinctProjection: Int) -> Int in
    return accumulatedProjection + precinctProjection
}
totalProjection


/*
    ONE LINE IMPLEMENTATION


    This solution takes advantage of
        - the Swift compiler's type inference capabilities
        - the fact that single-expression closures can omit the return keyword
        - trailing closure syntax
*/
let totalProjection2 = projectedPopulations.reduce(0) { $0 + $1 }
totalProjection2
