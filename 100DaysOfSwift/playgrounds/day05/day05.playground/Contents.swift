import UIKit
import Darwin

//writing functions
func printHelp() {
    let message = """
Welcome to MyApp

Run this app inside a directory of images and
MyApp will resize them all into thumbnails
"""
    print(message)
}
printHelp()

//accepting parameters
func square(number: Int) {
    print(number * number)
}
square(number: 8)

//returning values
func square1(number: Int) -> Int {
    return number * number
}

let result = square1(number: 8)
print(result)

//paramater labels
func square2(number2: Int) -> Int {
    return number2 * number2
}
let result2 = square2(number2: 8)

func sayHello(to name: String) {
    print("Hello \(name)!")
}
sayHello(to: "Taylor")

//omitting parameter labels
func greet(_ name: String) {
    print("Hello \(name)!")
}
greet("Taylor")

//default parameters
func greet1(_ person: String, nicely: Bool = true) {
    if nicely == true {
        print("Hello \(person)!")
    } else {
        print("Oh no, it's \(person) again...")
    }
}
greet1("Taylor")
greet1("Taylor", nicely: false)

//variadic functions
func square3(number3: Int...) {
    for number in number3 {
        print("\(number) squared is \(number * number)")
    }
}
square3(number3: 1, 2, 3, 4, 5)

//writing throwing functions
enum PasswordError: Error {
    case obvious
}

func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }
    return true
}

//running throwing functions
enum PasswordError1: Error {
    case obvious
}

func checkPassword1(_ password1: String) throws -> Bool {
    if password1 == "password" {
        throw PasswordError1.obvious
    }
    return true
}

do {
    try checkPassword1("password")
    print("That password is good!")
} catch {
    print("You can't use that password.")
}

//inout parameters
func doubleInPlace(number: inout Int) {
    number *= 2
}

var myNum = 10
doubleInPlace(number: &myNum)
