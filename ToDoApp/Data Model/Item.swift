//
//  Item.swift
//  ToDoApp
//
//  Created by Dmitry Logachev on 17.02.2022.
//

import Foundation

class Item: Encodable {
    var title: String = ""
    var done: Bool = false
}
