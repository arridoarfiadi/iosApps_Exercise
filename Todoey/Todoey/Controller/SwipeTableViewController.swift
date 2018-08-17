//
//  SwipeTableViewController.swift
//  Todoey
//
//  Created by Arrido Arfiadi on 8/17/18.
//  Copyright © 2018 Arrido Arfiadi. All rights reserved.
//

import UIKit
import SwipeCellKit

class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80.0
        tableView.separatorStyle = .none

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source


    //SWIPEABLE CELL
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            print("Delete Cell")
            self.updateModel(at: indexPath)
//            if let categoryDelete = self.categoryArray?[indexPath.row]{
//                do{
//                    try self.realm.write {
//                        self.realm.delete(categoryDelete) //delete at that row
//
//                    }
//                } catch{
//                    print("Error updating")
//                }
//                //tableView.reloadData()
//            }
            
        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete")
        
        return [deleteAction]
    }
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        return options
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Setting the cell into SwipeTableViewCell in the Storyboard as well
        //Generic cell name for all
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
        cell.delegate = self
        return cell
    }
    
    func updateModel(at indexPath: IndexPath){
        //Update
    }

}
