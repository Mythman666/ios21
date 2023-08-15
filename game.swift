//
//  game.swift
//  BlackJ
//
//  Created by Mythman on 11/22/21.
//

import Foundation
class Card {
    enum Suit : CaseIterable{
        case C
        case D
        case H
        case S
    }
    var rank: Int
    var suit: Suit
    
    var desc:String{
        get{
            switch rank{
            case 1:
                return "A\(suit)"
            case 11:
                return "J\(suit)"
            case 12:
                return "Q\(suit)"
            case 13:
                return "K\(suit)"
            default:
                return "\(rank)\(suit)"
            }
        }
    }
    
    init(rank: Int, suit:Suit){
        self.rank = rank
        self.suit = suit
    }
}

class Deck{
    var cards:[Card] = []
    var currentTop:Int = 0
    
    init() {
        for s in Card.Suit.allCases{
            for r in 1...13{
                let card = Card(rank:r, suit:s)
                cards.append(card)
            }
        }
    }
    func shuffle(){
        cards.shuffle()
    }
    func deal() -> Card {
        let card = cards[currentTop]
        currentTop += 1
        if currentTop > 52 {
            currentTop = 0
            cards.shuffle()
        }
        return card
    }
}

func all(){
    
}
