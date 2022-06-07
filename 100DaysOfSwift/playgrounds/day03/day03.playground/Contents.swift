import UIKit

//operators
let firstScore = 12
let secondScore = 4

let total = firstScore + secondScore
let difference = firstScore - secondScore

let product = firstScore * secondScore
let divided = firstScore / secondScore
let remainder = 13 % firstScore

//operator overloading
let meaningOfLife = 42
let doubleMeaning = 42 + 42

let fakers = "Fakers gonna "
let action = fakers + "fake"

let firstHalf = ["John", "Paul"]
let secondHalf = ["George", "Ringo"]
let beatles = firstHalf + secondHalf

//compound assignment operators
var score = 95
score -= 5

var quote = "The rain in Spain falls mainly on the "
quote += "Spaniards"

//comparison operators
let firstScore1 = 6
let secondScore1 = 4

firstScore1 == secondScore1
firstScore1 != secondScore1

firstScore1 < secondScore1
firstScore1 >= secondScore1

"Taylor" <= "Swift"

//conditions
let firstCard = 11
let secondCard = 10

if firstCard + secondCard == 2 {
    print("Aces A lucky!")
} else if firstCard + secondCard == 21 {
    print("Blackjack!")
} else {
    print("Regular cards")
}

//combining conditions
let age1 = 12
let age2 = 21

if age1 > 18 && age2 > 18 {
    print("Both are over 18")
}

if age1 > 18 || age2 > 18 {
    print("One of them is over 18")
}

//the ternary operators
let firstCard1 = 11
let secondCard1 = 10

print(firstCard1 == secondCard1 ? "Cards are the same" : "Cards are different")

if firstCard1 == secondCard1 {
    print("Cards are the same")
} else {
    print("Cards are different")
}

//switch statements
let weather = "sunny"

switch weather {
case "rain":
    print("Bring an umbrella")
case "snow":
    print("Wrap up warm")
case "sunny":
    print("Wear sunscreen")
    fallthrough
default:
    print("Enjoy your day!")
}

//range operators
let score2 = 85

switch score2 {
case ..<50:
    print("You failed badly.")
case ...85:
    print("You did OK.")
fallthrough
default:
    print("You did great!")
}
