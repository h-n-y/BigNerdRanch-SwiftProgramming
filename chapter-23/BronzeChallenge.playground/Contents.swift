import Cocoa

protocol ExerciseType: CustomStringConvertible {
    var name: String { get }
    var caloriesBurned: Double { get }
    var minutes: Double { get }
    
    var title: String { get }   // BRONZE CHALLENGE
}

extension ExerciseType {
    var description: String {
        return "Exercise(\(name), burned \(caloriesBurned) calories in \(minutes) minutes)"
    }
}

/*
// Default implementation for required *title* property
*/
extension ExerciseType {
    var title: String {
        return "\(name) - \(minutes) minutes"
    }
}

struct EllipticalTrainer: ExerciseType {
    let name = "Elliptical Machine"
    let title = "Go Fast Elliptical Machine 300"
    let caloriesBurned: Double
    let minutes: Double
}

struct Treadmill: ExerciseType {
    let name = "Treadmill"
    let caloriesBurned: Double
    let minutes: Double
    let distanceInMiles: Double
}

extension Treadmill {
    var description: String {
        return "Treadmill(\(caloriesBurned) calories and \(distanceInMiles) miles in \(minutes) minutes)"
    }
}

let runningWorkout = Treadmill(caloriesBurned: 350, minutes: 25, distanceInMiles: 4.2)
let ellipticalWorkout = EllipticalTrainer(caloriesBurned: 335, minutes: 30)


let mondayWorkout: [ExerciseType] = [ellipticalWorkout, runningWorkout]
for exercise in mondayWorkout {
    print(exercise.title)
}
print(ellipticalWorkout.title)



































