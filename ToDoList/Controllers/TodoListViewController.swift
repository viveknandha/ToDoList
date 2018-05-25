//
//  ViewController.swift
//  ToDoList
//
//  Created by einfochips on 18/05/18.
//  Copyright © 2018 einfochips. All rights reserved.
//

import UIKit
import RealmSwift
class TodoListViewController: UITableViewController {

    
    var selectedCategory : Category? {
        didSet {
            loadItems()
        }
    }
    
    let realm = try! Realm()
    var todoItems : Results<Item>?       //["Find Mike","Buy Eggos","Destory Demogrgon"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        


        
    }
    
    //MARK: - datasource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            
            cell.accessoryType = item.done ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No Items Added Yet"
        }
        return cell
    }
    
    //MARK: - Delegates mathods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if let item = todoItems?[indexPath.row] {
            
            do {
               try realm.write {
                    item.done = !item.done
           
                }
            } catch {
                print("Error saving done status \(error )")
            }
        }
        tableView.reloadData()

        tableView.deselectRow(at: indexPath, animated: true) //use for just flash select, it just appear and go
    }
    
    //MARK: - Add new Item
    
    @IBAction func barButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New TodoList Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once user click on add item
            
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                }
                catch {
                    print("Error adding items into realm, \(error)")
                }
                
            }
           self.tableView.reloadData()
         
        }
            alert.addTextField { (alertTextField) in
                
                alertTextField.placeholder = "Creat new item"
                textField = alertTextField
            }
        
        alert.addAction(action)
        
        present(alert,animated: true,completion: nil)
    }
    
//    func saveItem() {
//
//        do {
//                try context.save()
//        }
//        catch {
//            print("Error decoding item \(error)")
//        }
//
//        self.tableView.reloadData()
//    }
    
    func loadItems() {

        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
         tableView.reloadData()
    }
    
}

//MARK: search Bar method

extension TodoListViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
        
    }
    

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()

            //this will manage the thread that after search process done it disappeare key-board
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }

        }
    }
}

