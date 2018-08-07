//
//  Player.swift
//  Objects
//
//  Created by Arrido Arfiadi on 8/6/18.
//  Copyright © 2018 Arrido Arfiadi. All rights reserved.
//

import Foundation
enum typeClasses{
    case Warrior
    case Wizard
    case Archer
}

class Player {
    var name: String = "Player1"
    var classType: typeClasses = .Warrior
    
    init(){
        
    }
    convenience init (name: String){
        self.init()
        self.name = name
    }
    
    convenience init (name: String, classType: typeClasses){
        self.init()
        self.name = name
        self.classType = classType
    }
    
    func speak(){
        print("\(name) said Hi")
    }
}
