import UIKit

//creating basic closures
let driving = {
    print("I'm driving in my car.")
}
driving()

//accepting parameters in a closure
let driving1 = { (place: String) in
    print("I'm going to \(place) in my car.")
}
driving1("London")

//returning values from a closure
let drivingWithReturn = { (place: String) -> String in
    return "I'm going to \(place) in my car"
}
let message = drivingWithReturn("London")
print(message)

//closures as parameters
let driving2 = {
    print("I'm driving in my car.")
}
func travel(action: () -> Void) {
    print("I'm getting ready to go")
    action()
    print("I arrived!")
}
travel(action: driving2)

//trailing closure syntax
func travel1(action: () -> Void) {
    print("I'm getting ready to go")
    action()
    print("I arrived!")
}
travel {
    print("I'm driving in my car.")
}
