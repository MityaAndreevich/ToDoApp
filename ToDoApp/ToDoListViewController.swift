//
//  ToDoListViewController.swift
//  ToDoApp
//
//  Created by Dmitry Logachev on 09.02.2022.
//

import UIKit

class ToDoListViewController: UITableViewController{
    
    let itemArray = ["Find 10000$", "Buy Eggs", "Buy New G-Wagen"]
    
    override func viewWillAppear(_ animated: Bool) {
        setNavBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - TableView Data Source Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = itemArray[indexPath.row]
        cell.contentConfiguration = content
        return cell
    }
}

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
