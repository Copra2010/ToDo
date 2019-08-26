//
//  ViewController.swift
//  ToDo
//
//  Created by Ahmed Zaki Mohamed on 8/25/19.
//  Copyright © 2019 Ahmed Zaki Mohamed. All rights reserved.
//

import UIKit

class ToDoviewcontroller: UITableViewController {

    var itemArrey = [item] ()
    let datafilepath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("items.plist")
 
    //   let defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let newItem = item()
        newItem.title = "Banks"
        itemArrey.append(newItem)
        
        loaditems()
     
        
 /*
       if let items = defaults.array(forKey: "TodoListArray") as? [item] {
            itemArrey = items
       }
       */
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArrey.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)

        let item = itemArrey[indexPath.row]
        cell.textLabel?.text = item.title
        
        
        //Using ternary operator ==>
        // Value = condition ? valueiftrue : valueifFalse
        
        cell.accessoryType = item.done ? .checkmark : .none
        
            return cell

}

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
     //Using the obosit function with the bool only for False and true
        
        itemArrey[indexPath.row].done = !itemArrey[indexPath.row].done
       
        self.saveitems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @IBAction func addbuttonpressed(_ sender: UIBarButtonItem) {
        
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "Add new ToDo item", message: "", preferredStyle: .alert)
    
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newitem = item()
            newitem.title = textfield.text!
          
            self.itemArrey.append(newitem)
            
            //self.defaults.set(self.itemArrey, forKey: "TodoListArray")
       
            self.saveitems()
          
            
        }
        alert.addTextField { (alertTextfield) in
            alertTextfield.placeholder = "Create new Item"
            textfield = alertTextfield
            
        }
        
        alert.addAction(action)
        present(alert , animated: true , completion: nil)
    }
    
    
    func saveitems() {
        
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArrey)
            try data.write(to: datafilepath!)
        } catch {
            print ("error encoding item , \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loaditems() {
        
        if let data = try? Data(contentsOf: datafilepath!) {
            let decoder = PropertyListDecoder()
            
            do {
                itemArrey = try decoder.decode([item].self, from: data)
            } catch {
                 print ("error encoding item , \(error)")
            }
        }
        
        
    }
    
    
    
}
