//
//  CategoryTableViewController.swift
//  ToDoApp
//
//  Created by Dmitry Logachev on 19.04.2022.
//

import UIKit

class CategoryTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()

    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
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
