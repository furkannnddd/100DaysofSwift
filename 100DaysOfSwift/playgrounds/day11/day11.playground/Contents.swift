import UIKit

//protocols
protocol Identifiable {
    var id: String { get set }
}
struct User: Identifiable {
    var id: String
}
func displayID(thing: Identifiable) {
    print("My ID is \(thing.id)")
}

//protocol inheritance
protocol Payable {
    func calculateWages() -> Int
}
protocol NeedsTraining {
    func study()
}
protocol HasVacation {
    func takeVacation(days: Int)
}
protocol Employee: Payable, NeedsTraining, HasVacation { }

//extensions
extension Int {
    func squared() -> Int {
        return self * self
    }
}
let number = 8
number.squared()
extension Int {
    var isEven: Bool {
        return self % 2 == 0
    }
}
number.isEven

//protocol extensions
let pythons = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]
let beatles = Set(["John", "Paul", "George", "Ringo"])
extension Collection {
    func summarize() {
        print("There are \(count) of us:")
        for name in self {
            print(name)
        }
    }
}
pythons.summarize()
beatles.summarize()

//protocol-oriented programming
protocol Identifiable1 {
    var id1: String { get set }
    func identify1()
}
extension Identifiable1 {
    func identify1() {
        print("My ID is \(id1).")
    }
}
struct User1: Identifiable1 {
    var id1: String
}
let twostraws = User1(id1: "12345")
twostraws.identify1()
