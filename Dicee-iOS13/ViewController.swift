//
//  ViewController.swift
//  Dicee-iOS13
//
//  Created by Angela Yu on 11/06/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit



class ViewController: UIViewController,RestartGame {
    
    @IBOutlet weak var player1Label: UILabel!
    @IBOutlet weak var player2Label: UILabel!
    
    @IBOutlet weak var player1Button: UIButton!
    @IBOutlet weak var player2Button: UIButton!
    
    @IBOutlet weak var player1Dice1: UIImageView!
    @IBOutlet weak var player1Dice2: UIImageView!
    @IBOutlet weak var player2Dice1: UIImageView!
    @IBOutlet weak var player2Dice2: UIImageView!
    
    @IBOutlet weak var player1ScoreLabel: UILabel!
    
    @IBOutlet weak var player2ScoreLabel: UILabel!
    
    var dice1: Int?
    var dice2: Int?
    var isFirstPlayerDiced = false
    var isSecondPlayerDiced = false
    var isGameFinished = false
    var player1Score: Int?
    var player2Score: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inverPlayer2Views()
        // Do any additional setup after loading the view.
    }
    
    enum PlayerType{
        case PLAYER1, PLAYER2
    }
    
    func inverPlayer2Views(){
        player2Label.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        player2ScoreLabel.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        player2Button.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        player2Dice1.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        player2Dice2.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
    }
    
    func diceForButton(diceView1:inout UIImageView,diceView2: inout UIImageView, player: PlayerType){
        dice1 = Int.random(in: 1...6)
        dice2 = Int.random(in: 1...6)
        let total = dice1! + dice2!
        if(player == PlayerType.PLAYER1){
            player1ScoreLabel.text = String(total)
            player1Score = total
        }else{
            player2ScoreLabel.text = String(total)
            player2Score = total
        }
        
        diceView1.image = getDiceView(num: dice1!)
        diceView2.image = getDiceView(num: dice2!)
        
        
    }
    
    func getDiceView(num:Int)->UIImage{
        switch num{
        case 1:
            return UIImage(named: "DiceOne")!
        case 2:
            return UIImage(named: "DiceTwo")!
        case 3:
            return UIImage(named: "DiceThree")!
        case 4:
            return UIImage(named: "DiceFour")!
        case 5:
            return UIImage(named: "DiceFive")!
        default:
            return UIImage(named: "DiceSix")!
        }
        
    }
    
    
    @IBAction func diceForPlayer1(_ sender: Any) {
        if(!isFirstPlayerDiced){
            diceForButton(diceView1: &player1Dice1, diceView2: &player1Dice2, player: PlayerType.PLAYER1)
            isFirstPlayerDiced = true
        }
        checkGameFinished()
    }
    
    @IBAction func diceForPlayer2(_ sender: Any) {
        if(!isSecondPlayerDiced){
            diceForButton(diceView1: &player2Dice1, diceView2: &player2Dice2, player: PlayerType.PLAYER2)
            isSecondPlayerDiced = true
        }
        checkGameFinished()
    }
    
    
    func checkGameFinished(){
        if(isFirstPlayerDiced && isSecondPlayerDiced){
            finishTheGame()
        }
    }
    
    func finishTheGame(){
        var popUpWindow: PopUpWindow!
        var winningMessage = ""
        guard let value_one = player1Score, let value_two = player2Score else {
                print("Some value is nil")
                return
            }
        if(value_one > value_two){
            winningMessage = "Player 1 WON!"
        }
        else if(value_two > value_one){
            winningMessage = "Palyer 2 WON!"
        }else{
            winningMessage = "It is a DRAW, AMAZING!"
        }
        popUpWindow = PopUpWindow(title: winningMessage, buttontext: "RETRY")
        self.present(popUpWindow, animated: true, completion: nil)
        
    }
    
    func restartTheGame(_ sender: UIButton) {
        player1ScoreLabel.text = nil
        player2ScoreLabel.text = nil
        player1Dice1.image = nil
        player1Dice2.image = nil
        player2Dice1.image = nil
        player2Dice2.image = nil
        isFirstPlayerDiced = false
        isSecondPlayerDiced = false
        isGameFinished = false
        dice1 = nil
        dice2 = nil
        player1Score = nil
        player2Score = nil
    }
    
    
}


