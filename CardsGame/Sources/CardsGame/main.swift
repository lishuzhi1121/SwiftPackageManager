import Foundation
import DeckOfPlayingCardsKit
import Rainbow

var deck = Deck.standard52CardDeck()
deck.shuffle()

print("How many cards do you want?(0-52)".green)

let input = readLine() ?? ""

guard !input.isEmpty else {
    print("Your input is invalid.".red.bold)
    exit(EX_USAGE)
}

let numberOfCards = Int(input) ?? 0

for _ in 0..<numberOfCards {
    guard let card = deck.deal() else {
        print("No more Cards!".yellow.bold)
        break
    }
    
    print(card)
}


