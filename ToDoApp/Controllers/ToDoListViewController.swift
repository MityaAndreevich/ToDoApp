//
//  ToDoListViewController.swift
//  ToDoApp
//
//  Created by Dmitry Logachev on 09.02.2022.
//

import UIKit

class ToDoListViewController: UITableViewController{
    
    let defaults = UserDefaults.standard
    
    var itemArray = [Item]()
    
    override func viewWillAppear(_ animated: Bool) {
        setNavBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Find Lindsey"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Buy Eggs"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Buy G-Wagen"
        itemArray.append(newItem3)
         
       // if let items = defaults.array(forKey: "ToDoListArray") as? [String] {
         //   itemArray = items
        //}
    }
    
    //MARK: - TableView Data Source Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        let item = itemArray[indexPath.row]
        content.text = item.title
        
        cell.accessoryType  = item.done ? .checkmark : .none
        
        cell.contentConfiguration = content
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        /*if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }*/
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new ToDo item", message: "", preferredStyle: .alert)
        let action  = UIAlertAction(title: "Add Item", style: .default) { action in
            //what will happen when the user click the Add item button on UIAlert
            let newItem = Item()
            newItem.title = textField.text ?? "New Task"
            
            self.itemArray.append(newItem)
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            self.tableView.reloadData()
            
            /*if let inputText = textField.text, inputText != "" {
                DispatchQueue.main.async {
                }
            } else {
                self.sendingAlertMessage(title: "Ooops, seems no input", message: "Please, enter what to do")
            }*/
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
//MARK: - Navigation Bar Appearance
extension ToDoListViewController {
    private func setNavBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor.systemBlue
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
    }
}
//MARK: - Private Custom Alert Message
extension ToDoListViewController {
    private func sendingAlertMessage(title: String, message: String) {
        let alertMessage = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertMessage.addAction(okAction)
        present(alertMessage, animated: true)
    }
}
