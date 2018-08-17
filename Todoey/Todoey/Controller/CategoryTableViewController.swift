//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Arrido Arfiadi on 8/16/18.
//  Copyright © 2018 Arrido Arfiadi. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift
import ChameleonFramework

class CategoryTableViewController: SwipeTableViewController {
    
    
    let realm = try! Realm()
    
    //var categoryArray = [Category]()
    
    var categoryArray: Results<Category>?
    //CoreData
    // context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        
            setupNav()
    }
    
    func setupNav(){
        guard let navBar = navigationController?.navigationBar else {fatalError("Navigation controller does not exist")}
        navBar.barTintColor = UIColor.flatMint
        navBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.flatWhite]
        navBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.flatWhite]
    }
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Setting the cell into SwipeTableViewCell in the Storyboard as well
        //let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! SwipeTableViewCell
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No Categories Added"
        //cell.delegate = self
        if let cellColor = categoryArray?[indexPath.row].color{
            cell.backgroundColor = UIColor(hexString: cellColor)
        }
        else{
            do{
                try realm.write {
                    let randomColor = UIColor.randomFlat.hexValue()
                    categoryArray?[indexPath.row].color = randomColor
                    cell.backgroundColor = UIColor(hexString: randomColor)
                }
            } catch{
                print("Error updating")
            }
        }
        
        cell.textLabel?.textColor = ContrastColorOf(cell.backgroundColor!, returnFlat: true)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
           destinationVC.selectedCategory = categoryArray?[indexPath.row]
        }
        
    }
    

    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        //store value of alert text field
        var textField = UITextField()
        //create alert
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        //create action
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What will happen once the user click the add item button on the alert
            //Append Items
            if textField.text != "" {
                //let newCategory= Category(context: self.context)
                let newCategory = Category()
                newCategory.name = textField.text!
                //self.categoryArray.append(newCategory)
                
                self.saveCategories(category: newCategory)
                self.tableView.reloadData()
            }
            
            
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        //create textfield
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        //add action
        alert.addAction(action)
        alert.addAction(cancel)
        
        //present the alert
        present(alert,animated: true, completion: nil)
    }
    
    func saveCategories(category: Category){
        do{

            //try context.save() //CoreData
            try realm.write {
                realm.add(category)
            }
        }
        catch{
            print("Save Error")
        }
        tableView.reloadData()
    }
    
    //Core Data
//    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest() ){
//        do{
//            categoryArray = try context.fetch(request)
//        } catch{
//            print("Fetch Error")
//        }
//
//        tableView.reloadData()
//    }
    func loadCategories() {
        categoryArray = realm.objects(Category.self)
        tableView.reloadData()
    }
    

    
    override func updateModel(at indexPath: IndexPath) {
        
        super.updateModel(at: indexPath) //Call everything inside original class
        if let categoryDelete = self.categoryArray?[indexPath.row]{
            do{
                try self.realm.write {
                    self.realm.delete(categoryDelete) //delete at that row
        
                }
            } catch{
            print("Error updating")
        }
            //tableView.reloadData()
        }
    }
    
}



//extension CategoryTableViewController: SwipeTableViewCellDelegate{
//
//
//}
