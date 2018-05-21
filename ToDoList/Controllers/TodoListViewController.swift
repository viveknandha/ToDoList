//
//  ViewController.swift
//  ToDoList
//
//  Created by einfochips on 18/05/18.
//  Copyright © 2018 einfochips. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    let defaults = UserDefaults.standard
    var itemArray = [Item]()//["Find Mike","Buy Eggos","Destory Demogrgon"]
    override func viewDidLoad() {
        super.viewDidLoad()

        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Buy Eggos"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Destory Demogrgon"
        itemArray.append(newItem3)
        if let items = defaults.array(forKey: "TodoListArray") as? [Items] {

            itemArray = items
        }
       
    }
    //MARK - datasource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
        
    }
    //MARK -Delegates mathods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //print(itemArray[indexPath.row])
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
      
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true) //use for just flash select, it just appear and go
    }
    
    //MARK - Add new Item
    @IBAction func barButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New TodoList Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once user click on add item
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem )
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            self.tableView.reloadData()
        }
            alert.addTextField { (alertTextField) in
                
                alertTextField.placeholder = "Creat new item"
                textField = alertTextField
            }
        
        alert.addAction(action)
        
        present(alert,animated: true,completion: nil)
    }
    
}

