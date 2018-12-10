//
//  ViewController.swift
//  Todoey
//
//  Created by RAMON DAVO GONZALEZ on 12/10/18.
//  Copyright © 2018 com.Adan Nunez. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    var itemArray = [Item]()
    let defaults=UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let newItem=Item()
        newItem.title="Find keys"
        itemArray.append(newItem)
        let newItem2=Item()
        newItem2.title="Buy coffee"
        itemArray.append(newItem2)
        let newItem3=Item()
        newItem3.title="Go to movie"
        itemArray.append(newItem3)
        if let itemsSaved = defaults.array(forKey: "TodoListArray") as? [Item] {
                itemArray=itemsSaved
        }
    }
    // MARK - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell" , for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text=item.title
        cell.accessoryType = item.done ? .checkmark : .none
        return cell
    }
    //MARK - TableView delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(itemArray[indexPath.row])
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //MARK - Add new items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField=UITextField()
        let alert = UIAlertController(title: "Add new Todoey item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            if let item = textField.text{
                let newItem = Item()
                newItem.title=item
                self.itemArray.append(newItem)
                self.tableView.reloadData()
                print("success")
                self.defaults.set(self.itemArray, forKey: "TodoListArray")
            }
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder="Create new item"
            textField=alertTextField
        }
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
    }
    
}

