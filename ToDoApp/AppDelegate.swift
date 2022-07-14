//
//  AppDelegate.swift
//  ToDoApp
//
//  Created by Dmitry Logachev on 09.02.2022.
//

import UIKit
import CoreData
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //print(Realm.Configuration.defaultConfiguration.fileURL)
        // Realm migration code
        Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 1, migrationBlock: { migration, oldSchemaVersion in
            if (oldSchemaVersion < 1) {
                migration.enumerateObjects(ofType: Item.className()) { oldObject, newObject in
                    // we do not need to manually transfer old objects if the new one is not connected (ex. if we want to count smth from it) its made automatically in our simple case
                    //let title = oldObject!["title"] as! String
                    //let done = oldObject!["done"] as! Bool
                    newObject!["dateCreated"] = Date()
                }
            }
        })
        
        do {
            let realm = try Realm()
        } catch {
            print("Error initilizing new realm, \(error)")
        }
        
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        //self.saveContext()
    }
    
    // MARK: - Core Data stack
//    lazy var persistentContainer: NSPersistentContainer = {
//        let container = NSPersistentContainer(name: "DataModel")
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//        return container
//    }()
//
//    // MARK: - Core Data Saving support
//
//    func saveContext () {
//        let context = persistentContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }
}





