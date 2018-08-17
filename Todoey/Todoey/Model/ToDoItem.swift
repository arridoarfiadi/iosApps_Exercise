//
//  ToDoItem.swift
//  Todoey
//
//  Created by Arrido Arfiadi on 8/16/18.
//  Copyright © 2018 Arrido Arfiadi. All rights reserved.
//

import Foundation
import RealmSwift
//
//class ToDoItem: Codable{
//    var item: String = ""
//    var check: Bool = false
//    init(item: String, check: Bool) {
//        self.item = item
//        self.check = check
//    }
//    
//}

class ToDoItem: Object{
    @objc dynamic var item: String = ""
    @objc dynamic var check: Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items"
    )
    
}
