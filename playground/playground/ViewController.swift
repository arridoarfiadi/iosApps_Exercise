//
//  ViewController.swift
//  playground
//
//  Created by Arrido Arfiadi on 8/6/18.
//  Copyright © 2018 Arrido Arfiadi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let middleButton: UIButton = { //anon functions or closure
        let button = UIButton()
        button.backgroundColor = .yellow
        button.setTitle("test", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private func setupContraints(){
        middleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        middleButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true //set to center of the view
        middleButton.widthAnchor.constraint(equalToConstant: 200).isActive = true //set width constraint
        middleButton.heightAnchor.constraint(equalToConstant: 200).isActive = true //set width constraint
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        let square =  UIView(frame: CGRect(x: 20, y: 20, width: 20, height: 20))
//        square.backgroundColor = .black
//        self.view.addSubview(square)
        // Do any additional setup after loading the view, typically from a nib.
        view.addSubview(middleButton)
        setupContraints()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

