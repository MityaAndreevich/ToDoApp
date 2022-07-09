//
//  Category.swift
//  ToDoApp
//
//  Created by Dmitry Logachev on 09.07.2022.
//

import Foundation
import RealmSwift

class Category: Object {
    @Persisted var name: String = ""
    @Persisted var items = List<Item>()
}
