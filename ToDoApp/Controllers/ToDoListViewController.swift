//
//  ToDoListViewController.swift
//  ToDoApp
//
//  Created by Dmitry Logachev on 09.02.2022.
//

import RealmSwift

class ToDoListViewController: SwipeTableViewController {
    
    var todoItems: Results<Item>?
    let realm = try! Realm()
    
    var selectedCategory: Category? {
        didSet {
            loadItems()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setNavBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - TableView Data Source Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        //let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        if let item = todoItems?[indexPath.row] {
            content.text = item.title
            cell.accessoryType  = item.done ? .checkmark : .none
            cell.contentConfiguration = content
        } else {
            content.text = "No items added yet"
            cell.contentConfiguration = content
        }
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = todoItems?[indexPath.row] {
            StorageManager.shared.done(item: item)
        }
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new ToDo item", message: "", preferredStyle: .alert)
        let action  = UIAlertAction(title: "Add Item", style: .default) { action in
            //what will happen when the user click the Add item button on UIAlert
            
            if self.selectedCategory != nil {
                StorageManager.shared.save(itemWith: textField.text ?? "", to: self.selectedCategory!)
            }
            self.tableView.reloadData()
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Model Manipulation Methods
    func loadItems() {
        todoItems = selectedCategory?.items.sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
    }
    
    //MARK: - Delete Data from Swipe
    override func updateModel(at indexPath: IndexPath) {
        if let item = self.todoItems?[indexPath.row] {
            StorageManager.shared.delete(item: item)
        }
    }
}
//MARK: - Navigation Bar Appearance
extension ToDoListViewController {
    private func setNavBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor.systemBlue
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
    }
} 
//MARK: - Search Bar methods
extension ToDoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
