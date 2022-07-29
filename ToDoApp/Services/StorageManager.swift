//
//  StorageManager.swift
//  ToDoApp
//
//  Created by Dmitry Logachev on 27.07.2022.
//

import RealmSwift

class StorageManager {
    static let shared = StorageManager()
    let realm = try! Realm()
    
    private init() {}
    
    //MARK: - Categories Methods
    func save(category: Category) {
        do {
            try realm.write({
                realm.add(category)
            })
        } catch {
            print("Error saving category context, \(error)")
        }
    }
    
    func delete(category: Category) {
        do {
            try self.realm.write {
                self.realm.delete(category.items)
                self.realm.delete(category)
            }
        } catch {
            print("Error while deleting")
        }
    }
    
    //MARK: - Items Methods
    func delete(item: Item) {
        do {
            try self.realm.write {
                self.realm.delete(item)
            }
        } catch {
            print("Error while deleting")
        }
    }
    
    func save(itemWith title: String , to category: Category) {
        do {
            try realm.write{
                let newItem = Item()
                newItem.title = title
                newItem.dateCreated = Date()
                category.items.append(newItem)
            }
        } catch {
            print("Error occurd \(error)")
        }
    }
    
    func done(item: Item) {
        do {
            try realm.write{
                //item.done = !item.done
                item.done.toggle()
            }
        } catch {
            print("Error saving done status, \(error)")
        }
    }
}
