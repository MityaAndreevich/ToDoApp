//
//  Data.swift
//  ToDoApp
//
//  Created by Dmitry Logachev on 09.07.2022.
//

import Foundation
import RealmSwift

class Data: Object {
    @Persisted var name: String = ""
    @Persisted var age: Int = 0
}
