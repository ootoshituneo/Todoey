//
//  ViewController.swift
//  Todoey
//
//  Created by Tsuneo Ootoshi on 2018/01/15.
//  Copyright © 2018年 Tsuneo Ootoshi. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = ["Find Mike","Buy Eggs","Destroy Demogoron"]
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let  items = defaults.array(forKey: "TodoListArray") as? [String]{
            itemArray = items
        }
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //print(itemArray[indexPath.row])
        
       // tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }

    //Mark - Add New
    
    @IBAction func addButtonPressede(_ sender: Any) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "新しいアイテムを追加",message: "",preferredStyle: .alert)
        
        let action = UIAlertAction(title: "アイテム追加", style: .default){(action) in
            //what will happen once the user click the Add Item button on pur uiAlert
            
            self.itemArray.append(textField.text!)
            
            self.defaults.set(self.itemArray,forKey: "TodoListArray")
            
            self.tableView.reloadData()
            
           
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "新しいアイテムを追加"
            textField = alertTextField
            
           
        }
        
            alert.addAction(action)
            
            present(alert, animated: true, completion: nil)
            
       
    }
}

