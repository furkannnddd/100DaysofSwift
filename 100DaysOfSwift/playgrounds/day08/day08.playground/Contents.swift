import UIKit

//creating your own structs
struct Sport {
    var name: String
}
var tennis = Sport(name: "Tennis")
print(tennis.name)

//computed properties
struct Sport1 {
    var name: String
    var isOlympicSport: Bool
    
    var olympicStatus: String {
        if isOlympicSport {
            return "\(name) is an Olumpic sport."
        } else {
           return "\(name) is not an Olympic sport."
        }
        }
    }
let chessBoxing = Sport1(name: "Chessboxing", isOlympicSport: false)
print(chessBoxing.olympicStatus)

//property observers
struct Progress {
    var task: String
    var amount: Int {
        didSet {
            print("\(task) is now \(amount)% complete.")
        }
    }
}

var progress = Progress(task: "Loading Data", amount: 0)
progress.amount = 30
progress.amount = 80
progress.amount = 100

//methods
struct City {
    var population: Int
    func collectTaxes() -> Int {
        return population * 1000
    }
}

let london = City(population: 9_000_000)
london.collectTaxes()

//mutating methods
struct Person {
    var name: String
    mutating func makeAnonymous() {
        name = "Anonymous"
    }
}
var person = Person(name: "Ed")
person.makeAnonymous()

//properties and methods of strings
let string = "Do or do not, there is no try."
print(string.count)
print(string.hasPrefix("Do"))
print(string.uppercased())
print(string.sorted())

//properties and methods of arrays
var toys = ["Woody"]
print(toys.count)
toys.append("Buzz")
toys.firstIndex(of: "Buzz")
print(toys.sorted())
toys.remove(at: 0)

let cardGames = ["Poker", "Blackjack", "Whist"]
cardGames.firstIndex(of: "Whist") == 1
