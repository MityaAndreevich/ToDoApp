//
//  SwipeTableViewController.swift
//  ToDoApp
//
//  Created by Dmitry Logachev on 24.07.2022.
//

import UIKit

class SwipeTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80
        tableView.separatorStyle = .none
    }
    
    // TableView Datasource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        //cell.backgroundColor = randomColor()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            // we update model with deletion
            self.updateModel(at: indexPath)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func updateModel(at indexPath: IndexPath) {
        //Update data model
    }
}

//extension SwipeTableViewController {
//    private func randomColor() -> UIColor {
//        let randomColor = UIColor(
//            red: .random(in: 0...1),
//            green: .random(in: 0...1),
//            blue: .random(in: 0...1),
//            alpha: .random(in: 0...1))
//        return randomColor
//    }
//}
