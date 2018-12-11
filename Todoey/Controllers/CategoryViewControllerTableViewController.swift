//
//  CategoryViewControllerTableViewController.swift
//  Todoey
//
//  Created by RAMON DAVO GONZALEZ on 12/11/18.
//  Copyright © 2018 com.Adan Nunez. All rights reserved.
//

import UIKit

import RealmSwift
class CategoryViewControllerTableViewController: UITableViewController {
    let realm = try! Realm()
    var categoryArray: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }
    //MARK: - TableView Datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell",for: indexPath)
        
        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No categories found"
        return cell
    }
    
    //MARK: - TableView Delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToItems" {
            let destinationVC = segue.destination as! TodoListViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.selectedCategory = categoryArray?[indexPath.row]
            }
        }
    }
    
    //MARK: - Data manipulation methods
    
    func loadCategories(){
        categoryArray = realm.objects(Category.self)
        
        self.tableView.reloadData()
    }
    func save(category: Category){
        do {
            try realm.write {
                realm.add(category)
            }
        } catch  {
            print("Error saving categories \(error)")
        }
        self.tableView.reloadData()
    }
    //MARK: - Add category
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add category", style: .default) { (action) in
            if let category = textField.text{
                let newCategory = Category()
                newCategory.name = category
                self.save(category: newCategory)
            }
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
        
    }
}
