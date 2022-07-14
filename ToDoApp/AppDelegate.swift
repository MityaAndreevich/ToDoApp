//
//  AppDelegate.swift
//  ToDoApp
//
//  Created by Dmitry Logachev on 09.02.2022.
//

import UIKit
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
}





