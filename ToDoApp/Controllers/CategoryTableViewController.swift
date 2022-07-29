//
//  CategoryTableViewController.swift
//  ToDoApp
//
//  Created by Dmitry Logachev on 19.04.2022.
//

import RealmSwift

class CategoryTableViewController: SwipeTableViewController {
    
    //let realm = try! Realm()
    var categories: Results<Category>?
    
    override func viewWillAppear(_ animated: Bool) {
        setNavBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categories = StorageManager.shared.realm.objects(Category.self)
        //loadCategories()
    }
    
    //MARK: - TableView Datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        var content = cell.defaultContentConfiguration()
        
        let category = categories?[indexPath.row]
        content.text = category?.name ?? "No categories added yet"
        
        cell.contentConfiguration = content
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    //MARK: - Add New Category
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new ToDo category", message: "", preferredStyle: .alert)
        let action  = UIAlertAction(title: "Add Category", style: .default) { action in
            //what will happen when the user click the Add category button on UIAlert
            let newCategory = Category()
            newCategory.name = textField.text ?? "New Category"
            self.save(category: newCategory)
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Data Manipulation Methods
    func save(category: Category) {
        StorageManager.shared.save(category: category)
        
        tableView.reloadData()
    }
    
    func loadCategories() {
        categories = StorageManager.shared.realm.objects(Category.self)
        tableView.reloadData()
    }
    
    //MARK: - Delete Data from Swipe
    override func updateModel(at indexPath: IndexPath) {
        if let category = self.categories?[indexPath.row] {
            StorageManager.shared.delete(category: category)
        }
    }
}
//MARK: - Navigation Bar Appearance
extension CategoryTableViewController {
    private func setNavBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor.systemBlue
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
    }
}
