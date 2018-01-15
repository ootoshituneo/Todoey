//
//  ViewController.swift
//  Todoey
//
//  Created by Tsuneo Ootoshi on 2018/01/15.
//  Copyright © 2018年 Tsuneo Ootoshi. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Buy Eggos"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Destory Demogoron"
        itemArray.append(newItem3)
        
        
       if let  items = defaults.array(forKey: "TodoListArray") as? [Item]{
       itemArray = items
          }
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //print(itemArray[indexPath.row])
        
       // tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
       
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }

    //Mark - Add New
    
    @IBAction func addButtonPressede(_ sender: Any) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "新しいアイテムを追加",message: "",preferredStyle: .alert)
        
        let action = UIAlertAction(title: "アイテム追加", style: .default){(action) in
            //what will happen once the user click the Add Item button on pur uiAlert
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
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

