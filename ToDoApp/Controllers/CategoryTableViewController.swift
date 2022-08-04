//
//  CategoryTableViewController.swift
//  ToDoApp
//
//  Created by Dmitry Logachev on 19.04.2022.
//

import RealmSwift
import UIKit

class CategoryTableViewController: SwipeTableViewController {
    var myColor: UIColor = .randomColor
    //lazy var color = randomColor()
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
        myColor = colorWithHexString(hexString:category?.color ?? "")
        cell.backgroundColor = myColor
        //cell.backgroundColor = UIColor.getHexValue(categor)
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
            newCategory.color = UIColor.randomColor.getHexValue() ?? ""
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

extension UIColor {
    static var randomColor: UIColor { return UIColor(red: .random(in: 0...1),
                                                     green: .random(in: 0...1),
                                                     blue: .random(in: 0...1),
                                                     alpha: 1)}
    
    func getHexValue() -> String? {
        guard var components = self.cgColor.components else { return nil }
        
        if self.cgColor.numberOfComponents == 4 { components.removeLast() } // removes alpha value
        
        let rgbValues = components.map{ Int($0 * CGFloat(255)) } // convert UIColor components to RGB
        let hexValues = rgbValues.map{ String(format: "%02x", $0) } // convert RGB to hexidecimal values
        return "#" + hexValues.joined().uppercased()  // concatenate string
      }
}
extension CategoryTableViewController {
    func colorWithHexString(hexString: String, alpha:CGFloat = 1.0) -> UIColor {
        
        // Convert hex string to an integer
        let hexint = Int(self.intFromHexString(hexStr: hexString))
        let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexint & 0xff) >> 0) / 255.0
        
        // Create color object, specifying alpha as well
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }
    
    func intFromHexString(hexStr: String) -> UInt32 {
        var hexInt: UInt32 = 0
        // Create scanner
        let scanner: Scanner = Scanner(string: hexStr)
        // Tell scanner to skip the # character
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        // Scan hex value
        hexInt = UInt32(bitPattern: scanner.scanInt32(representation: .hexadecimal) ?? 0)
        return hexInt
    }
}
