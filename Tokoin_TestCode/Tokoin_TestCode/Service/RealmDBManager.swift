//
//  RealmDBManager.swift
//  Tokoin_TestCode
//
//  Created by Nexle-LanDT on 2/8/20.
//  Copyright © 2020 LanThien. All rights reserved.
//

import Foundation
import RealmSwift

class RealmDBManager {
    var database: Realm
    
    static let shareInstance = RealmDBManager()
    
    private init() {
        let config = Realm.Configuration(schemaVersion: 1, migrationBlock: { (migration, oldSchema) in
            if oldSchema < 1 {
                // Nothing to do!
                // Realm will automatically detect new properties and removed properties
                // And will update the schema on disk automatically
            }
        }, deleteRealmIfMigrationNeeded: true)
        database = try! Realm(configuration: config)
    }
    
    func getDataFromDB<T:Object>() -> [T] {
        var result = [T]()
        let data = database.objects(T.self)
        for item:T in data {
            result.append(item)
        }
        return result
    }
    
    func getDataFromDB<T:Object>(primaryKey: Any) -> T? {
        return database.object(ofType: T.self, forPrimaryKey: primaryKey)
    }
    
    /**
     Add or update model
     
     - parameter object: The object need add or update
     */
    func addObject(_ object: Object) -> Bool {
        do {
            try database.write {[unowned self] in
                self.database.add(object, update: .all)
            }
            return true
        } catch  {
            return false
        }
    }
    
    /**
     Add or update models
     
     - parameter objects: The objects need add or update
     */
    func addObjects(_ objects: [Object]) -> Bool {
        do {
            try database.write {[unowned self] in
                self.database.add(objects, update: .all)
            }
            return true
        } catch  {
            return false
        }
    }
    
    func deleteObject(_ object: Object) -> Bool {
        do {
            try database.write {[unowned self] in
                self.database.delete(object)
            }
            return true
        } catch  {
            return false
        }
    }
    
    func deleteObjects(_ objects: [Object]) -> Bool {
        do {
            try database.write {[unowned self] in
                self.database.delete(objects)
            }
            return true
        } catch {
            return false
        }
    }
    
    func deleteAllDatabase() -> Bool {
        do {
            try database.write {[unowned self] in
                self.database.deleteAll()
            }
            return true
        } catch {
            return false
        }
    }
}
