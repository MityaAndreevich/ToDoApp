//
//  ToDoListViewController.swift
//  ToDoApp
//
//  Created by Dmitry Logachev on 09.02.2022.
//

import UIKit

class ToDoListViewController: UITableViewController{
    
    override func viewWillAppear(_ animated: Bool) {
        setNavBar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
