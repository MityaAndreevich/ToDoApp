//
//  Item.swift
//  ToDoApp
//
//  Created by Dmitry Logachev on 09.07.2022.
//

import Foundation
import RealmSwift

class Item: Object {
    @Persisted var title: String = ""
    @Persisted var done: Bool = false
    @Persisted var dateCreated: Date?
    // here is up to date way of linking objects in Realm
    @Persisted(originProperty: "items") var assignee: LinkingObjects<Category>
}
