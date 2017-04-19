import DeckOfPlayingCardsKit

var deck = Deck.standard52CardDeck()
deck.shuffle()

for _ in 0..<10 {
    guard let card = deck.deal() else {
        print("No more Cards!")
        break
    }
    
    print(card)
}


