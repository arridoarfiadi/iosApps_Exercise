//
//  Category.swift
//  Todoey
//
//  Created by Arrido Arfiadi on 8/16/18.
//  Copyright © 2018 Arrido Arfiadi. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object{
    @objc dynamic var name: String = ""
    var items = List<ToDoItem>()
    @objc dynamic var color: String?
}
