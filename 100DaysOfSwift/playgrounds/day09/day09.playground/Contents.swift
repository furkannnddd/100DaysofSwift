import UIKit

//initializers
struct User {
    var username: String
    
    init() {
        username = "Anonymous"
        print("Creating a new user!")
    }
}
var user = User()
print(user.username)

//referring to the current instance
struct Person {
    var name: String
    init(name: String) {
        print("\(name) was born!")
        self.name = "Ahmet"
    }
}

//lazy properties
struct FamilyTree {
    init () {
        print("Creating family tree!")
    }
}
struct Person1 {
    var name: String
    lazy var familyTree = FamilyTree()
    init(name: String) {
        self.name = name
    }
}

var ed = Person1(name: "Ed")
ed.familyTree

//static properties and methods
struct Student {
    static var classSize = 0
    var name: String
    init(name: String) {
        self.name = name
        Student.classSize += 1
    }
}

let ed1 = Student(name: "Ed")
let taylor = Student(name: "Taylor")
print(Student.classSize)

//access control
struct Person2 {
    private var id: String
    init(id: String) {
        self.id = id
    }
    func identify() -> String {
        return "My social security number is \(id)"
    }
}

let ed2 = Person2(id: "12345")

