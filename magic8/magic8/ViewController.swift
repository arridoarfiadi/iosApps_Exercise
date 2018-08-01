//
//  ViewController.swift
//  magic8
//
//  Created by Arrido Arfiadi on 8/1/18.
//  Copyright © 2018 Arrido Arfiadi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var randomNum:Int = 0
    let ballArray = ["ball1","ball2","ball3","ball4","ball5"]
    @IBOutlet weak var magicBall: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        playBall()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func playButton(_ sender: UIButton) {
        playBall()
    }
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        playBall()
    }
    
    func playBall(){
        randomNum = Int(arc4random_uniform(4))
        magicBall.image = UIImage(named: ballArray[randomNum])
    }
    
}

