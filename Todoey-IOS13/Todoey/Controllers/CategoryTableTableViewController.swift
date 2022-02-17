//
//  CategoryTableTableViewController.swift
//  Todoey
//
//  Created by Andrei Marinescu on 15.04.2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryTableTableViewController: SwipeTableViewController {
    
    var categories: Results<Category>?
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategory()
        
        tableView.rowHeight = 60
        tableView.separatorStyle = .none
        
    }
    
    // Setup Navigation Bar
    override func viewWillAppear(_ animated: Bool) {
        
        let defaultColour = UIColor(hexString: "379AFF")!
        
        updateNavBarColor(defaultColour)
        
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No category added yet"
        
        cell.backgroundColor = UIColor(hexString: categories?[indexPath.row].color ?? "379AFF")
        cell.textLabel?.textColor = ContrastColorOf(UIColor(hexString: categories?[indexPath.row].color ?? "379AFF")!, returnFlat: true)
        
        return cell
    }

    // MARK: - Data manipulation
    
    func save(category:Category){
        
        do {
            try realm.write{
                realm.add(category)
            }
        } catch {
            print(error)
        }
        tableView.reloadData()
        
    }
    
    func loadCategory() {
        
        categories = realm.objects(Category.self)
        
        tableView.reloadData()
    }
    
    override func updateModel(at indexPath: IndexPath) {
        
        if let categoryForDeletion = self.categories?[indexPath.row] {
        do {
            try self.realm.write{
                self.realm.delete(categoryForDeletion)
            }
        } catch {
            print(error)
        }
        }
    }
                       
    
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondVC = segue.destination as! ToDoLisitViewController
        
        if let index = tableView.indexPathForSelectedRow{
            secondVC.selectedCategory = categories?[index.row]
        }
    }
    
    // MARK: - Actions
    @IBAction func addButtonPressed(_ sender: Any) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Category ", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCategory = Category()
            newCategory.name = textField.text!
            newCategory.color = UIColor.randomFlat().hexValue()
            
            self.save(category: newCategory)
            
        }
        
        
        
        alert.addTextField { (field) in
            
            field.placeholder = "Add one more category"
            textField = field
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
}
