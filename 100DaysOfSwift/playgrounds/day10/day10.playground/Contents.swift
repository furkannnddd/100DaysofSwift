import UIKit

//creating your own classes
class Dog {
    var name: String
    var breed: String
    
    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}
let poppy = Dog(name: "Poppy", breed: "Poodle")

//class inheritance
class Dog1 {
    var name: String
    var breed: String

    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}
class Poodle: Dog1 {
    init(name: String) {
        super.init(name: name, breed: "Poodle")
    }
}

//overriding methods
class Dog2 {
    func makeNoise() {
        print("Woof!")
    }
}
class Poodle1: Dog2 {
    override func makeNoise() {
        print("Puff")
    }
}
let poppy1 = Poodle1()
poppy1.makeNoise()

//final classes
final class Dog3 {
    var name: String
    var breed: String

    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}

//copying objects
class Singer {
    var name = "Taylor Swift"
}
var singer = Singer()
print(singer.name)
var singerCopy = singer
singerCopy.name = "Justin Bieber"
print(singer.name)

//deinitializers
class Person {
    var name = "John Doe"

    init() {
        print("\(name) is alive!")
    }
    func printGreeting() {
        print("Hello, I'm \(name)")
    }
    deinit {
        print("\(name) is no more!")
    }
}
for _ in 1...5 {
    let person = Person()
    person.printGreeting()
}

//mutability
class Singer1 {
    var name1 = "Taylor Swift"
}

let taylor = Singer1()
taylor.name1 = "Ed Sheeran"
print(taylor.name1)
