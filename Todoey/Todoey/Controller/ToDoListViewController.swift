//
//  ViewController.swift
//  Todoey
//
//  Created by Arrido Arfiadi on 8/15/18.
//  Copyright © 2018 Arrido Arfiadi. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift
import ChameleonFramework

class ToDoListViewController: SwipeTableViewController{

    @IBOutlet weak var searchBar: UISearchBar!
    //var itemArray = [ToDoItem]()
    var itemArray: Results<ToDoItem>?
    let realm = try! Realm()
    var selectedCategory: Category? {
        didSet{
            loadItems()
        }
    }
    //CoreData
    //let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //Defaults
    //let defaults = UserDefaults.standard
    
    //NSCoder
    //let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
        
        
//        for i in 1..<14 {
//            itemArray.append(ToDoItem(item: "\(i)", check: false))
//        }
        
        //NSCoder
        //loadItems()
        
        
        //Defaults
        //if let items = defaults.array(forKey: "ToDoList") as? [ToDoItem]{
        //    itemArray = items
        //}
        
        //CoreData
        //loadItems()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        setupNav()
    }
    
    func setupNav(){
        guard let colorHex = selectedCategory?.color else {fatalError()}
        title = selectedCategory?.name
        guard let navBar = navigationController?.navigationBar else {fatalError("Navigation controller does not exist")}
        guard let navbarColor =  UIColor(hexString: colorHex) else{fatalError()}
        navBar.barTintColor = navbarColor
        navBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: ContrastColorOf(navbarColor, returnFlat: true)]
        navBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: ContrastColorOf(navbarColor, returnFlat: true)]
        searchBar.barTintColor = UIColor(hexString: colorHex)
        navBar.tintColor = ContrastColorOf(navbarColor, returnFlat: true)
    }
    
        //CAN IMPLEMENT VIEWWILLDISAPPER FOR RESETING COLOR OF CATEGORY

    
    
    //Mark - Table View Data Source and Delegate
    //How many rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray?.count ?? 1
    }
    
    //Setup cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        //let todo = itemArray[indexPath.row]
        //cell.textLabel?.text = todo.item
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let todo = itemArray?[indexPath.row]{
            cell.textLabel?.text = todo.item
            cell.accessoryType = todo.check ? .checkmark : .none
            if let color = UIColor(hexString: (selectedCategory!.color!))?.darken(byPercentage: (CGFloat(indexPath.row) / CGFloat(itemArray!.count)))
                {
                cell.backgroundColor = color
                cell.textLabel?.textColor = ContrastColorOf(cell.backgroundColor!, returnFlat: true)
            }
            
            
        } else{
            cell.textLabel?.text = "No Items Added"
        }
        
        return cell
    }
    
    //Cell Press action
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        //Core Data
        //itemArray[indexPath.row].check = !itemArray[indexPath.row].check
        //Core Data Delete
        //context.delete(itemArray[indexPath.row])
        //itemArray.remove(at: indexPath.row)
        //saveItems()
        
        if let item = itemArray?[indexPath.row]{
            do{
                try realm.write {
                    //realm.delete(item) //delete at that row
                    item.check = !item.check
                }
            } catch{
                print("Error updating")
            }
            
        }
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func updateModel(at indexPath: IndexPath) {
        if let itemDelete = self.itemArray?[indexPath.row]{
            do{
                try self.realm.write {
                    self.realm.delete(itemDelete) //delete at that row
                    
                }
            } catch{
                print("Error updating")
            }
        }

    }
    
    
    //Mark - Add Item
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        //store value of alert text field
        var textField = UITextField()
        //create alert
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        //create action
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What will happen once the user click the add item button on the alert
            //Append Items
            if textField.text != "" {
                //self.itemArray.append(ToDoItem(item: textField.text!, check: false))
                
                
                
                //Defaults
                //self.defaults.set(self.itemArray, forKey: "ToDoList")
                
                //NSCoder
                //self.saveItems()
                
                
                //CORE DATA
                
                
                //let newItem = ToDoItem(context: self.context)
                //newItem.item = textField.text!
                //newItem.check = false
                //newItem.parentCategory = self.selectedCategory
                //self.itemArray.append(newItem)
                //self.saveItems()
                
                if let currentCategory = self.selectedCategory{
                    do{
                        try self.realm.write {
                            let newItem = ToDoItem()
                            newItem.item = textField.text!
                            newItem.check = false
                            newItem.dateCreated = Date()
                            currentCategory.items.append(newItem)
                        }
                    } catch {
                        print("Save error")
                    }
                    
                }
                
                
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
    
    //NSCoder and CoreData
//    func saveItems(){
//        //let encoder = PropertyListEncoder()
//        do{
//            //let data = try encoder.encode(itemArray)
//            //try data.write(to: dataFilePath!) //Writing
//            //try context.save()
//        }
//        catch{
//           print("Save Error")
//        }
//        tableView.reloadData()
//    }
//    func loadItems(with request: NSFetchRequest<ToDoItem> = ToDoItem.fetchRequest(), query predicate: NSPredicate? = nil){
//        //NSCoder
//        //set data into the data from the URL
////        if let data = try? Data(contentsOf: dataFilePath!){
////            let decoder = PropertyListDecoder()
////            do{
////                //Decode the data and tell it what type of data it is
////                itemArray = try decoder.decode([ToDoItem].self, from: data)
////            } catch{
////                print("load error")
////            }
////        }
////        let request: NSFetchRequest<ToDoItem> = ToDoItem.fetchRequest()
//
//        //CoreData
//         let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
//
//        if let additionalPredicate = predicate {
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,additionalPredicate])
//        }
//        else{
//            request.predicate = categoryPredicate
//        }
//
//        do{
//            itemArray = try context.fetch(request)
//        } catch{
//            print("Fetch Error")
//        }
//
//        tableView.reloadData()
//    }
    
    //Realm
    func loadItems(){
        itemArray = selectedCategory?.items.sorted(byKeyPath: "dateCreated", ascending: false)
        tableView.reloadData()
    }
    
}


extension ToDoListViewController: UISearchBarDelegate{

    func searchItems(){
        //Core Data
//        let request: NSFetchRequest<ToDoItem> = ToDoItem.fetchRequest()
//        let predicate = NSPredicate(format: "item CONTAINS[cd] %@", searchBar.text!)
//        request.sortDescriptors = [NSSortDescriptor(key: "item", ascending: true)]
//        loadItems(with: request, query: predicate)
        itemArray = itemArray?.filter("item CONTAINS[CD] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
    }


    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchItems()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }


        }
        else{
            searchItems()
        }

    }
}
