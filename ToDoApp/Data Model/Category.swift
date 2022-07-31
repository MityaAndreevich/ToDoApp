//
//  Category.swift
//  ToDoApp
//
//  Created by Dmitry Logachev on 09.07.2022.
//

import RealmSwift

class Category: Object {
    // in latest versions @Persisted is used instead of old variants with @objc and dynamic
    @Persisted var name: String = ""
    //@Persisted var color: String = ""
    @Persisted var items = List<Item>()
}
