//
//  ViewController.swift
//  BlackJ
//
//  Created by Mythman on 11/20/21.
//

import UIKit
import CloudKit

class ViewController: UIViewController {

    var deck_count = 0
    var dealerCards = 1
    var playerCards = 1
    var dealerSum = 0
    var playerSum = 0
    var newDeck:[String] = []
    @IBOutlet weak var lblDealer: UILabel?
    @IBOutlet weak var lblPlayer: UILabel?
    @IBOutlet weak var lblReault: UILabel?
    @IBOutlet weak var imgDealer: UIImageView!
    @IBOutlet weak var imgPlayer: UIImageView!
    
    @IBOutlet weak var btnDeal: UIButton!
    @IBOutlet weak var btnHit: UIButton!
    @IBOutlet weak var btnStand: UIButton!
    
    @IBAction func DealCard(_ sender: Any){
        btnDeal.isHidden = true
        btnHit.isHidden = false
        btnStand.isHidden = false
        newDeck = Deck()
        newDeck.shuffle()
        deck_count = 0
        dealerSum = 0
        playerSum = 0
        dealerCards = 1
        playerCards = 1
        imgDealer.image = UIImage(named: newDeck[deck_count])
        lblReault?.text = ""
        lblDealer?.text = ""
        lblPlayer?.text = ""
        var first_num = newDeck[deck_count].prefix(1)
        if first_num == "A" && dealerSum <= 21{
            dealerSum += 11
        } else if first_num == "A" && dealerSum > 21{
            dealerSum += 1
        } else if first_num == "J" || first_num == "Q" || first_num == "K"{
            dealerSum += 10
        } else if Int(newDeck[deck_count].prefix(2)) == 10{
            dealerSum += 10
        } else {
            dealerSum = dealerSum + Int(first_num)!
        }
        lblDealer?.text = String(dealerSum)
        deck_count += 1
        imgPlayer.image = UIImage(named: newDeck[deck_count])
        first_num = newDeck[deck_count].prefix(1)
        if first_num == "A" && playerSum <= 21{
            playerSum += 11
        } else if first_num == "A" && playerSum > 21{
            playerSum += 1
        } else if first_num == "J" || first_num == "Q" || first_num == "K"{
            playerSum += 10
        } else if Int(newDeck[deck_count].prefix(2)) == 10{
            playerSum += 10
        } else {
            playerSum = playerSum + Int(first_num)!
        }
        lblPlayer?.text = String(playerSum)
        deck_count += 1
        for sv in view.subviews{
            if sv is UIImageView && sv != imgDealer && sv != imgPlayer{
                sv.removeFromSuperview()
            }
        }
    }
    
    @IBAction func HitCard(_ sender: Any){
        let cardView = UIImageView()
        let selectedCard = newDeck[deck_count]
        cardView.frame = CGRect(x:20 + (playerCards * 30), y:447, width: 132, height: 186)
        cardView.image = UIImage(named: selectedCard)
        let first_num = selectedCard.prefix(1)
        print(selectedCard)
        if first_num == "A"{
            playerSum += 11
            if playerSum > 21{
                playerSum -= 10
            }
        } else if first_num == "J" || first_num == "Q" || first_num == "K"{
            playerSum += 10
        } else if Int(selectedCard.prefix(2)) == 10{
            playerSum += 10
        } else {
            playerSum = playerSum + Int(first_num)!
        }
        lblPlayer?.text = String(playerSum)
        print(playerSum)
        playerCards += 1
        deck_count += 1
        view.addSubview(cardView)
        if playerSum > 21{
            lblReault?.text = "YOU LOSE!"
            btnHit.isHidden = true
            btnStand.isHidden = true
            btnDeal.isHidden = false
        }
    }
    
    @IBAction func StandCard(_ sender: Any){
        while dealerSum < 17 && dealerSum < playerSum{
            let cardView = UIImageView()
            let selected_dealer_Card = newDeck[deck_count]
            print(dealerCards)
            cardView.frame = CGRect(x:20 + (dealerCards * 30), y:114, width: 132, height: 186)
            cardView.image = UIImage(named: selected_dealer_Card)
            view.addSubview(cardView)
            let first_num = selected_dealer_Card.prefix(1)
            print(selected_dealer_Card)
            if first_num == "A" && dealerSum <= 21{
                dealerSum += 11
            } else if first_num == "A" && dealerSum > 21{
                dealerSum += 1
            } else if first_num == "J" || first_num == "Q" || first_num == "K"{
                dealerSum += 10
            } else if Int(selected_dealer_Card.prefix(2)) == 10{
                dealerSum += 10
            } else {
                dealerSum = dealerSum + Int(first_num)!
            }
            lblDealer?.text = String(dealerSum)
            dealerCards += 1
            deck_count += 1
        }
        btnHit.isHidden = true
        btnStand.isHidden = true
        btnDeal.isHidden = false
        checkWin()
    }
    
    func Deck() -> [String]{
        var deck: [String] = []
        let suits = ["S", "H", "C", "D"]
        for suit in suits {
            for rank in 1...13{
                if rank == 1{
                    let card = "A" + suit
                    deck.append(card)
                } else if rank <= 10 {
                    let card = String(rank) + suit
                    deck.append(card)
                } else if rank == 11{
                    let card = "J" + suit
                    deck.append(card)
                } else if rank == 12{
                    let card = "Q" + suit
                    deck.append(card)
                } else if rank == 13{
                    let card = "K" + suit
                    deck.append(card)
                }
            }
        }
        return deck
    }
    
    func checkWin(){
        if dealerSum > playerSum && dealerSum <= 21 || playerSum > 21{
            lblReault?.text = "YOU LOSE!"
        } else if dealerSum == playerSum && dealerSum <= 21 && playerSum <= 21{
            lblReault?.text = "TIE!"
        } else if playerSum > dealerSum || dealerSum > 21 && playerSum <= 21{
            lblReault?.text = "YOU WIN!"
        }
        btnDeal.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        newDeck = Deck()
        newDeck.shuffle()
    }


}

