//
//  ViewController.swift
//  diceRoll
//
//  Created by Arrido Arfiadi on 8/1/18.
//  Copyright © 2018 Arrido Arfiadi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dice1: UIImageView!
    @IBOutlet weak var dice2: UIImageView!
    
    var randomNum1: Int = 0;
    var randomNum2: Int = 0;
    let diceArray = ["dice1","dice2","dice3","dice4","dice5","dice6"]
    override func viewDidLoad() {
        super.viewDidLoad()
        rollDices()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func rollButton(_ sender: Any) {
        rollDices();
    }
    func rollDices(){
        randomNum1 = Int(arc4random_uniform(6))
        randomNum2 = Int(arc4random_uniform(6))
        dice1.image = UIImage(named: diceArray[randomNum1])
        dice2.image = UIImage(named: diceArray[randomNum2])
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        rollDices()
    }
}

